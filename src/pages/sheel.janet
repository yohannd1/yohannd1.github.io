(import ../common)
(import ../utils)

(def -summary common/make-summary)
(def -link common/make-link)
(def -script common/make-script)

(def- head
  [
   '(title `:)`)
   (-script `index.js`)
   ])

(def- sidebar [])

(def- body
  ['(img {:src "img/sheel1.jpg"})
   ])

(def root
  (common/make-page
    :head head
    :body body
    :sidebar-items sidebar))
