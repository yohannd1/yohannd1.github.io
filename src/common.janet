(use ./utils)

(defn make-link [href text]
  ['a {:href href} text])

(def- all-pages-sidebar-items
  [(make-link `index.html` `index`)
   (make-link `music.html` `music`)
   (make-link `projects.html` `projects`)
   (make-link `updates.html` `updates`)])

(defn make-page [&keys args]
  (def head (-> args (get :head) (or [])))
  (def body (-> args (get :body) (or [])))
  (def footer (-> args (get :footer) (or [])))
  (def sidebar-items (-> args (get :sidebar-items) (or [])))

  (def side-final
    [
     '(li {:class "big2"} "OVERVIEW")
     ;(if sidebar-items (map |['li $] sidebar-items) '((li "...")))
     ])

  (def nav-sep ~(a {:class "nav-spacing"} "|"))
  (def nav-final (->> all-pages-sidebar-items (map |['span " " $ " "]) (interpose nav-sep)))

  ~(html
     (head
       ,;head
       (meta {:name "viewport" :content "width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no"})
       (meta {:http-equiv "X-UA-Compatible" :content "IE=edge,chrome=1"})
       (meta {:name "HandheldFriendly" :content "true"})
       (meta {:charset "UTF-8"})
       (link {:rel "stylesheet" :type "text/css" :href "style.css"}))

     (body
       (div {:class "sidebar"}
         (ul ,;side-final))

       (main
         (nav ,;nav-final)

         (div {:id "sidebar-toggle" :hidden true}
           (button `Open sidebar...`)
           (br))

         ,;body

         (footer
           ,;footer
           (noscript
             {:style `font-style: italic;`}
             `(It appears you're not using javascript! That's nice. There are some JS features here but they are not crucial.)`)))
       )))

(defn make-fold [attrs summary & children]
  (def summary-node
    (cond
      (string? summary) ['summary summary]
      (or (array? summary) (tuple? summary)) summary
      (error (string "Expected string, array or tuple, got " summary))))

  ~(details
     ,attrs
     ,summary-node
     (div {:class "node-contents"} ,;children)))

(defn make-summary [size & content]
  (def attrs @{})

  (unless (nil? size)
    (assert (number? size))
    (set (attrs :class) (string "big" size)))

  ['summary attrs ;content])

(defn make-script [script-uri]
  ['script {:src script-uri}])

(defn make-table-simple [head & rows]
  ['table
   ;(if (nil? head)
      []
      [['tr (map |['th ;$] head)]])
   ;(map
      (fn [row] ['tr ;(map |['td $] row)])
      rows)])

(defn make-code-inline [& content]
  ['code ;content])

(defn make-code-block [& content]
  ['pre ['code ;content]])

(defn make-small-note-p [& content]
  ['p ['small ['i ;content]]])

(def valid-project-tags
  (make-set
    ["music" "tool" "library" "game" "game-jam"
     "in-progress" "abandoned"
     # not sure about these:
     "standard" "website"]))

(defn project/has-tag? [tag project]
  (as->
    project .x
    (in .x :tags)
    (find |(= (string tag) (string $)) .x)))

(defn valid-project-tag? [t]
  (-> valid-project-tags (in t) (= true)))

(defn -project-taglist [& tags]
  (def arr @[])
  (defn normalize-tag [tag]
    (cond
      (string? tag) tag
      (symbol? tag) (string tag)
      (error (string/format "invalid project tag: %j" tag))))
  (loop [[i tag-] :pairs tags
         :let [tag (normalize-tag tag-)]]
    (unless (valid-project-tag? tag)
      (-> "invalid project tag: %j" (string/format tag) (error)))
    (array/push arr ~(span {:class "project-tag-clickable"} ,tag))
    (unless (= i (-> tags (length) (- 1)))
      (array/push arr '(:raw "&nbsp;"))))
  ~(div {:class "project-taglist"} ,;arr))

(defn -project-title [title &opt year]
  (assert (string? title) (-> "Expected string, got %j" (string/format title)))

  (def year-arr
    (cond
      (nil? year) []

      (or (string? year) (number? year))
      [['small (string/format " (%s)" (string year))]]

      (-> "Expected string or number, got %j" (string/format year) (error))))

  ['span title ;year-arr])

(defn -project-row [title & content]
  ~(tr
     {:class "project-row"}
     (td ,title)
     (td ,;content)))

(defn -project-field [name & content]
  ['p {:class (string "project-" name)} ;content])

(defn -project-description [& content]
  ['div {:class "project-description"} ;content])

(defn render-update [u]
  ~(table
     (tr (td (i ,(in u :time))))
     (tr (td ,(in u :message)))))

(defn render-project [project]
  (def ret @[])
  (when (def title (in project :title))
    (def args @[title])
    (when (def year (in project :year))
      (array/push args year))
    (array/push ret (apply -project-title args)))
  (when (def desc (in project :desc))
    (def value
      (if (array-or-tuple? desc)
        (apply -project-description desc)
        (-project-description desc)))
    (array/push ret value))
  (each [name url] (in project :urls [])
    (array/push ret (-project-field "url" (make-link url name))))
  (def tags (in project :tags []))
  (when (not (empty? tags))
    (array/push ret (-project-taglist ;tags)))
  (-project-row ;ret))

(defn render-song [song]
  (def icons
    {:archive "img/button-internetarchive.png"
     :youtube "img/button-youtube.png"})

  (def names
    {:archive "Internet Archive"
     :youtube "YouTube"})

  (def avail (get song :avail {}))

  (def buttons
    (seq [:let [keylist (sorted (keys avail))]
          key :in keylist
          :let [url (in avail key)
                icon (in icons key)
                name (in names key)]]
      (assert (and icon name) (string/format "unknown avail type: %j" key))
      ~(a {:href ,url :title ,name} (img {:src ,icon :alt ,name :class "music-source-button"}))))

  ~(tr
     (td ,(in song :title) (small ` (` ,(in song :year) `)`))
     (td ,(in song :medium))
     (td ,;(interpose ~(span ` `) buttons))))
