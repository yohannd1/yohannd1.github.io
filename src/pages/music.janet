(import ../common)
(import ../utils)
(use ../data/music)

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

   '(p `So yeah, I'm also a musician. It's a rather fun activity.`)
   ~(p `I started doing "okay" music in late 2021, I think. `
       `At the moment I mostly use ` ,(-link "https://github.com/tildearrow/furnace" "Furnace") ` and `
       (a {:href "https://lmms.io/" :title "quite the odd piece..."} "LMMS")
       ` to make music. Really powerful open source tools, despite their flaws.`)
   ~(p `Most of my music is at my ` ,(-link "https://youtube.com/@SwapXFO" "youtube channel")
       `, and I upload them (in due time) to my ` ,(-link "" "internet archive account") `. I wanna host them elsewhere more practical as well in the future, but for now this is alright, I think.`)

   '(p `TODO: talk about bandcamp,newgrounds,botb`)
   '(p `TODO: list all songs and albums here, with links to where they are uploaded`)

   ~(div
      {:id "music-list"}
      (div {:class "project-search-div"})
      (table ,;(map common/render-song all-songs)))
   ])

(def root
  (common/make-page
    :head head
    :body body
    :sidebar-items sidebar))
