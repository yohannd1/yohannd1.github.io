(import spork/path)
(import spork/sh)
(import spork/date)
(import ./webgen)
(import ./common)

(var prog-dir nil)
(var out-dir nil)

(defn build-page-tree [prog-dir]
  (def ret @[])

  (defn ap [val]
    (array/push ret val))

  (defn add-self-pages [& args]
    (loop [name :in args
           :let [out-path (string name ".html")
                 in-path (string "pages/" name ".janet")]]
      (ap [out-path [:html-gen in-path]])))

  (defn copy-glob [dest-dir src-dir]
    (each fname (os/dir (path/join prog-dir src-dir))
      (ap [fname [:copy (path/join src-dir fname)]])))

  # TODO: support redirects (for pages that I've moved around)

  (def self-pages
    ["index"
     "key-tester"
     "sistema-pa"
     "tutorial-c"
     "projects"
     "music"
     "updates"
     "sheel"])

  (add-self-pages ;self-pages)

  (copy-glob "." "../res")
  (ap ["img" [:copy "../img"]])

  (ap ["rss.xml" [:xml-gen "misc/updates-rss.janet"]])
  (ap ["sitemap.xml" [:xml-gen "misc/sitemap.janet" "https://yohannd1.github.io" self-pages]])

  ret)

(defn process-page-entry [out-name action]
  (def html-config
    {:specials common/html-specials})

  (defn get-root [page-mod args]
    (if (def build-root (get page-mod 'build-root))
      ((get build-root :value) ;args)
      (-> page-mod (get 'root) (get :value))))

  (eprintf "processing target %j" out-name)
  (match action
    # generate a HTML page by running janet code
    [:html-gen in-path-pre & args]
    (let [in-path (path/join prog-dir in-path-pre)
          page-mod (dofile in-path :exit true)
          page-root (get-root page-mod args)
          out-path (path/join out-dir out-name)]
      (with [fd (file/open out-path :w)]
        (:write fd (webgen/html/render-doc page-root html-config))))

    # generate a HTML page by running janet code
    [:xml-gen in-path-pre & args]
    (let [in-path (path/join prog-dir in-path-pre)
          page-mod (dofile in-path :exit true)
          page-root (get-root page-mod args)
          out-path (path/join out-dir out-name)]
      (with [fd (file/open out-path :w)]
        (:write fd (webgen/xml/render-doc page-root {}))))

    # copy a file
    [:copy in-path]
    (sh/copy
      (path/join prog-dir in-path)
      (path/join out-dir out-name))

    _
    (error (string/format "unknown format: %j" action))))

(defn main [arg0 & args]
  (set prog-dir (path/dirname arg0))
  (set out-dir (in args 0))
  (os/mkdir out-dir)

  (each [out-name action] (build-page-tree prog-dir)
    (process-page-entry out-name action)))
