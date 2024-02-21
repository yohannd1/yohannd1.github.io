(defn make-page [&keys args]
  (def head (-> args (get :head) (or [])))
  (def body (-> args (get :body) (or [])))
  (def footer (-> args (get :footer) (or [])))

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
       # TODO: a nav maybe?
       (main
         ,;body))
     (footer
       ,;footer
       (noscript {:style `font-style: italic;`}
                 `It appears you're not using javascript! That's nice. There are some JS features here but they are not crucial.`)
       (a {:href "https://openmpt.org/"}
          (img {:src "img/openmpt-button-1.png"}))
       )
     )
  )

(defn make-fold [attrs summary & children]
  (def summary-node
    (cond
      (string? summary) ['summary summary]
      (or (array? summary) (tuple? summary)) summary
      (error (string "Expected string, array or tuple, got " summary))))

  ~(details ,attrs
            ,summary-node
            (div {:class "node-contents"}
                 ,;children))
  )

(defn make-summary [size & content]
  (def attrs (if (nil? size)
               {}
               {:class (string "big" size)}))
  ['summary attrs ;content])

(defn make-link [href text]
  ['a {:href href} text])

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
