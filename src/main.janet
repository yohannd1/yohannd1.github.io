(import spork/path)
(import spork/sh)
(import ./webgen)

(defn build-page-tree [prog-dir]
  (def ret @[])

  (defn ap [val]
    (array/push ret val))

  (defn make-janet-gen [out-path in-path]
    [out-path [:janet-gen in-path]])

  (defn add-self-pages [& args]
    (loop [name :in args
           :let [out-path (string name ".html")
                 in-path (string "pages/" name ".janet")]]
      (ap (make-janet-gen out-path in-path))))

  (defn copy-glob [dest-dir src-dir]
    (each fname (os/dir (path/join prog-dir src-dir))
      (ap [fname [:copy (path/join src-dir fname)]])))

  # TODO: support redirects (for pages that I've moved around)

  (add-self-pages
    "index"
    "key-tester"
    "sistema-pa"
    "tutorial-c"
    "projects"
    "music"
    "updates"
    "sheel")

  (copy-glob "." "../res")
  (ap ["img" [:copy "../img"]])

  ret)

(defn main [arg0 out-dir]
  (def prog-dir (path/dirname arg0))

  (os/mkdir out-dir)

  (each [out-name value] (build-page-tree prog-dir)
    (eprintf "processing target %j" out-name)
    (match value
      [:janet-gen in-path-pre]
      (let [in-path (path/join prog-dir in-path-pre)
            page-mod (dofile in-path :exit true)
            page-root (-> page-mod (get 'root) (get :value))
            out-path (path/join out-dir out-name)]
        (with [fd (file/open out-path :w)]
          (:write fd (webgen/gen page-root))))

      [:copy in-path]
      (sh/copy (path/join prog-dir in-path)
               (path/join out-dir out-name))

      _
      (error (string/format "unknown format: %j" value))
      )))
