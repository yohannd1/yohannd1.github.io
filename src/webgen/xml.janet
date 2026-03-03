(use ./_common)

(def- specials @{})

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

(defn render-doc [root &opt config]
  (def start-string
    (get config :start-string "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"))

  (def buf @"")
  (buf-push buf start-string)
  (render-any root buf (make-r-config config))
  buf)
