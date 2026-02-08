(import ../common)
(import ../utils)
(use ../data/updates)

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

(def- commits-url
  `https://github.com/yohannd1/yohannd1.github.io/commits/main/`)

(def- body
  ['(h1 {:class "big1" :id "s-start"} `updates`)
   ~(p `A short update log. I'm lazy so I probably won't update this always.` (br)
       `If you want a thorough list, check out the ` ,(-link commits-url `git log`) ` instead.`)
   ;(as->
      all-updates .x
      (map common/render-update .x)
      (utils/interpolate .x ~(br)))])

(def root
  (common/make-page
    :head head
    :body body
    :sidebar-items sidebar))
