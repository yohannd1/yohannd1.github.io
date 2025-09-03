(import ../common)
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
   '(p `So yeah, I'm also a musician.`)
   '(p `I started doing music in 2021, I think. I have some things from 2018 and 2019, but not anything notable.`)
   '(p `At the moment I publish my music at:`)
   ~(ul
      (li `My ` ,(-link "https://youtube.com/@SwapXFO" "youtube channel") ` (main place at the moment)`)
      (li `TODO: the rest`))
   '(p `TODO: list all songs and albums here, with links to where they are uploaded`)
   '(p `TODO: a page with old tunes? might be cool`)
   ])

(def root
  (common/make-page
    :head head
    :body body
    :sidebar-items sidebar))
