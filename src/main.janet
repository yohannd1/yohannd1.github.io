(import spork/path)
(import spork/sh)
(import ./webgen)

(defn main [exec out-path]
  (def here (path/dirname exec))

  (def pages-to-gen
    ["index" "key-tester" "sistema-pa" "tutorial-c" "music"])

  (def pages-path (path/join here "pages"))

  (os/mkdir out-path)

  # generate pages
  (each page pages-to-gen
    (def jn-filename (string page ".janet"))
    (def html-filename (string page ".html"))

    (def page-mod
      (dofile (path/join pages-path jn-filename) :exit true))

    (def page-out-path (path/join out-path html-filename))

    (:write stderr (string/format "building %s to %s\n" jn-filename page-out-path))
    (with [fd (file/open page-out-path :w)]
      (:write fd (webgen/gen (-> page-mod (get 'root) (get :value)))))
    )

  # copy resources
  (each filename (os/dir (path/join here "../res"))
    (sh/copy (path/join here "../res" filename)
             (path/join out-path filename)))

  (sh/copy (path/join here "../img")
           (path/join out-path "img"))
  )
