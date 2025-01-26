(defn make-link [href text]
  ['a {:href href} text])

(def- all-pages-sidebar-items
  [
   ~(p ,(make-link `index.html` `Index`))
   ~(p ,(make-link `music.html` `Music`))
   ])

(defn make-page [&keys args]
  (def head (-> args (get :head) (or [])))
  (def body (-> args (get :body) (or [])))
  (def footer (-> args (get :footer) (or [])))
  (def sidebar-items (-> args (get :sidebar-items) (or [])))

  (def side-final @[])

  (array/push side-final '(p {:class "big2"} "OVERVIEW"))
  (if (empty? sidebar-items)
    (array/push side-final '(p "..."))
    (each item sidebar-items
      (array/push side-final item))
    )

  (array/push side-final '(p {:class "big2"} "WEBSITE"))
  (if (empty? all-pages-sidebar-items)
    (array/push side-final '(p "..."))
    (each item all-pages-sidebar-items
      (array/push side-final item))
    )

  ~(html
     (head
       ,;head
       (meta {:name "viewport" :content "width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no"})
       (meta {:http-equiv "X-UA-Compatible" :content "IE=edge,chrome=1"})
       (meta {:name "HandheldFriendly" :content "true"})
       (meta {:charset "UTF-8"})
       (link {:rel "stylesheet" :type "text/css" :href "style.css"})
       )

     (body
       (div {:class "sidebar"}
         ,;side-final)

       (main
         ,;body

         (footer
           ,;footer
           (noscript {:style `font-style: italic;`}
                     `It appears you're not using javascript! That's nice. There are some JS features here but they are not crucial.`)
           (div {:class "little-cards"}
             (a {:href "https://openmpt.org/"} (img {:src "img/button-openmpt.png"}))
             (a {:href "https://pwndrenard.net/"} (img {:src "img/button-pwndrenard.png"}))
             )
           )
         )
       )
     )
  )

(defn make-fold [attrs summary & children]
  (def summary-node
    (cond
      (string? summary) ['summary summary]
      (or (array? summary) (tuple? summary)) summary
      (error (string "Expected string, array or tuple, got " summary))))

  ~(details
     ,attrs
     ,summary-node
     (div {:class "node-contents"} ,;children))
  )

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
      rows)
   ])

(defn make-code-inline [& content]
  ['code ;content])

(defn make-code-block [& content]
  ['pre ['code ;content]])

(defn make-small-note-p [& content]
  ['p ['small ['i ;content]]])
