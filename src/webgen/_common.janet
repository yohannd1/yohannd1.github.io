(defn buf-push [buf & data]
  (each x data
    (buffer/push-string buf (string x))))

(defn- replacer
  `Creates a PEG that replaces instances of patt with subst.

  Source: https://janet-lang.org/docs/peg.html`
  [patt subst]

  (peg/compile ~(% (any (+ (/ (<- ,patt) ,subst) (<- 1))))))

(defn- escape
  "Escapes a string `x` for safe embedding in XML/HTML."
  [x]

  (def replace-patterns
    [["&" "&amp;"] # always keep this one as the first!
     ["<" "&lt;"]
     [">" "&gt;"]
     [`"` "&quot;"]
     [`'` "&#39;"]
     ["`" "&#96;"]])

  (var result x)
  (each [patt sub] replace-patterns
    (set result (-> (replacer patt sub)
                    (peg/match result)
                    (get 0))))
  result)

(varfn render-any [& args] (error "usage before definition"))

########################################

(defn- valid-tag? [tag]
  (def compiled-peg
    (comptime
      (peg/compile '(* :a+ (any (+ :a :d (set "-_"))) -1))))
  (and
    (symbol? tag)
    (truthy? (peg/match compiled-peg tag))))

(defn- buf-push-tag-start [buf tag attrs self-close]
  (buf-push buf "<" tag)
  (eachp [k v] attrs
    (cond
      (= v true) (buf-push buf " " k)
      (= v false) nil
      (buf-push buf " " k `="` (escape v) `"`)))
  (buf-push buf (if self-close "/>" ">")))

(defn- expand-node
  "Expands a node, if possible, or just returns it as normal."
  [node specials]

  (def [head & _] node)
  (if-let [func (get specials head)]
    (func node)
    node))

(defn- parse-node [node]
  (def tag (get node 0))

  (unless (or (keyword? tag) (valid-tag? tag))
    (-> "Invalid tag %j - it should be a symbol and a valid HTML identifier (I might be wrong about this); if it was supposed to be expanded, uh..."
        (string/format tag) (error)))

  (var ch-idx 1) # children start index
  (var attrs {})

  # get attributes if we have them, and update the start index for the children elements
  (let [x (get node ch-idx)]
    (when (dictionary? x)
      (set ch-idx 2)
      (set attrs x)))

  (def children (array/slice node ch-idx))

  [tag attrs children])

(defn- render-node
  "Renders a node to the buffer. Does expansion as necessary and according to the passed config."
  [node buf config]

  (def {:specials specials} config)
  (defn expand [x] (expand-node x specials))

  (match (expand node)
    [:void & node]
    (let [[tag attrs children] (parse-node node)]
      (assert (empty? children) "void tag should have no children")
      (buf-push-tag-start buf tag attrs true))

    [:raw x & tail]
    (do
      (assert (empty? tail) "more than one element given to :raw")
      (buf-push buf x))

    [:cdata-wrap & children]
    (let [acc @""]
      (each c children
        (render-any c acc config))
      # TODO: check if the embedding is correct (]] cannot be embedded, for example)
      (buf-push buf "<![CDATA[ " acc " ]]>"))

    [:cdata-raw x & tail]
    (do
      (assert (empty? tail) "more than one element given to :cdata-raw")
      # TODO: check if the embedding is correct (]] cannot be embedded, for example)
      (buf-push buf "<![CDATA[ " x " ]]>"))

    node
    (let [[head & _] node]
      (assert (symbol? head) (string/format "expected symbol, got %j" head))
      (def node (expand node))
      (def [tag attrs children] (parse-node node))

      (buf-push-tag-start buf tag attrs false) # open tag
      (each c children
        (render-any c buf config))
      (buf-push buf "</" tag ">") # close tag
      )))

(varfn render-any
  "Attempts to render something."
  [x buf config]

  (cond
    (or (string? x) (buffer? x))
    (buf-push buf (escape x))

    (indexed? x)
    (render-node x buf config)

    (-> "Expected string, buffer or indexed, found %s" (string/format x) (error))))
