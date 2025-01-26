(import ../common)
(import ../data/updates)
(import ../utils)

(def -summary common/make-summary)
(def -link common/make-link)
(def -script common/make-script)

(def- head
  [
   '(title `My music`)
   (-script `index.js`)
   ])

(def- sidebar
  [
   ~(p ,(-link "#s-start" "Start"))
   ])

(def- body
  [
   '(h1 {:class "big1" :id "s-start"} `music`)
   '(p `I started doing music in 2021, I think. I have some things from 2018 and 2019, I think, but not anything really that considerable.`)
   '(p `TODO: explain where my music is, and the strategy I use for publishing them atm`)
   '(p `TODO: a place to put old tunes?`)
   ])

(def root
  (common/make-page
    :head head
    :body body
    :sidebar-items sidebar))
