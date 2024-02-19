(defn make-fold [fold-state summary & children]
  (def folded
    (match fold-state
      'open false
      'closed true
      x (error (string "Expected :open or :closed, found " x))))

  (def summary-node
    (cond
      (string? summary) ['summary summary]
      (or (array? summary) (tuple? summary)) summary
      (error (string "Expected string, array or tuple, got " summary))))

  ~(details {:open ,(not folded)}
     ,summary-node
     (div {:class "node-contents"}
          ,;children))
  )

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
       (script {:src "index.js"})
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
