(import spork/path)
(import spork/sh)
(import ./webgen)

(defn main [exec out-path]
  (def here (path/dirname exec))

  (def pages-to-gen
    ["index" "404"])

  (def pages-path (path/join here "pages"))

  (os/mkdir out-path)

  # generate pages
  (each page pages-to-gen
    (def page-mod (dofile (path/join pages-path (string page ".janet"))
                          :exit true))
    (def page-out-path (path/join out-path (string page ".html")))
    (with [fd (file/open page-out-path :w)]
      (:write fd (webgen/gen (-> page-mod (get 'root) (get :value)))))
    )

  # copy resources
  (each x ["img" "index.js" "style.css"]
    (sh/copy (path/join here ".." x) (path/join out-path x)))

  )
