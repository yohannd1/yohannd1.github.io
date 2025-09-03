(import ../common)
(import ../utils)
(use ../data/projects)

(def -summary common/make-summary)
(def -link common/make-link)
(def -script common/make-script)
(def -fold common/make-fold)

(def- head
  [
   '(title `My projects`)
   (-script `index.js`)
   ])

(def- sidebar
  [~(p ,(-link "#s-start" "Start"))])

(def- body
  ['(h1 {:class "big1" :id "s-start"} `Projects`)
   '(p `Here is an attempt at a somewhat comprehensible list of projects I've worked on.` (br)
       `As I've already worked in many, there will probably a lot of them not included here.` (br)
       `But I'll be trying to put the most important ones.`)
   ~(div
      {:id "projects-list"}
      (div {:id "search-bar-div"})
      (table ,;(map common/render-project all-projects)))])

(def root
  (common/make-page
    :head head
    :body body
    :sidebar-items sidebar))
