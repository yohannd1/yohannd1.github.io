# TODO: figure out "single tags"
#
# Or just do something like (for <meta .../>):
#  (/ meta {...})
# I guess that kinda conveys it? It's akward but it works.

(defn- buf-push-all [buf & data]
  (each x data
    (buffer/push-string buf (string x))))

(defn replacer
  `Creates a peg that replaces instances of patt with subst.

  Source: https://janet-lang.org/docs/peg.html`
  [patt subst]

  (peg/compile ~(% (any (+ (/ (<- ,patt) ,subst) (<- 1))))))

(defn escape-html [x]
  (def replace-patterns
    '(
      ("&" "&amp;")
      ("<" "&lt;")
      (">" "&gt;")
      (`"` "&quot;")
      (`'` "&#39;")
      ("`" "&#96;")
    ))

  (var result x)
  (each [patt sub] replace-patterns
    (set result (-> (replacer patt sub)
                    (peg/match result)
                    (get 0))))
  result)

(varfn to-html [x buf] (error "placeholder"))

(defn- text-to-html [text buf]
  (buf-push-all buf (escape-html text)))

(def- void-tags
  {'area true
   'base true
   'br true
   'col true
   'embed true
   'hr true
   'img true
   'input true
   'link true
   'meta true
   'param true
   'source true
   'track true
   'wbr true})

(defn- void-tag? [tag]
  (-> void-tags (in tag) (truthy?)))

(defn node-to-html [node buf]
  (def tag (get node 0))

  # get attributes if we have them. whether we have them will affect where the children index starts, so we have to calculate that as well.
  (def [children-start-idx attrs]
    (let [x (get node 1)]
      (if (or (struct? x) (table? x))
        [2 x]
        [1 {}])))

  (def self-close? (and (>= children-start-idx (length node))
                        (void-tag? tag)))

  # tag and attributes
  (buf-push-all buf "<" tag)
  (each [k v] (pairs attrs)
    (cond
      (= v true) (buf-push-all buf " " k)
      (= v false) nil
      (buf-push-all buf " " k `="` (escape-html v) `"`)))
  (buf-push-all buf (if self-close? "/>" ">"))

  (unless self-close?
    # children
    (loop [i :range [children-start-idx (length node)]]
      (to-html (get node i) buf))

    # close tag
    (buf-push-all buf "</" tag ">"))
  )

(varfn to-html [x buf]
  (cond
    (string? x) (text-to-html x buf)
    (or (array? x) (tuple? x)) (node-to-html x buf)
    (error (string "Expected string, array or tuple, found " x))))

(defn gen [node]
  (def buf @"<!DOCTYPE html>\n")
  (to-html node buf)
  buf)
