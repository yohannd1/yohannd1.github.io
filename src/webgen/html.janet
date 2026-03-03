(use ./_common)

(def- void-tags '(area base br col embed hr img input link meta param source track wbr))

(def- specials @{})
(each vt void-tags
  (set (specials vt) (fn [x] [:void ;x])))

(defn- make-r-config [config]
  (default config {})

  (def r-specials specials)
  (eachp [k v] (get config :specials {})
    (set (r-specials k) v))

  {:specials r-specials})

(defn render-node
  [node &opt config]

  (def buf @"")
  (render-any node buf (make-r-config config))
  buf)

(defn render-doc
  "Render a HTML document based on TODO(rest of the docs lmao).
  Valid options:
    :specials - special form mappers;
    :start-string - starting string, defaults to DOCTYPE header;"
  [root &opt config]

  (def start-string
    (get config :start-string "<!DOCTYPE html>\n"))

  (def buf @"")
  (buf-push buf start-string)
  (render-any root buf (make-r-config config))
  buf)
