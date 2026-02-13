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

(def all-songs
  [

   {:title "This is a somewhat long title, as these can have"
    :medium "YM2612+PCMD8"
    :avail {:archive "https://archive.org/details/yonkagor-singles"
            :youtube "https://www.youtube.com/watch?v=dQw4w9WgXcQ"}
    :year "2027"}

   ])


(def- body
  [
   '(h1 {:class "big1" :id "s-start"} `music`)

   '(p `So yeah, I'm also a musician. It's really fun! I started doing "okay" music in late 2021, I think.`)
   '(p `At the moment I mostly use Furnace and LMMS to make music. Really powerful open source tools, despite their flaws (man LMMS is odd...).`)
   ~(p `My music is at my ` ,(-link "https://youtube.com/@SwapXFO" "youtube channel")
       `, and I upload them (in due time) to my ` ,(-link "" "internet archive account") `. I wanna host them elsewhere more practical as well in the future, but for now this is alright, I think.`)

   '(p `TODO: Talk about bandcamp,newgrounds,botb`)
   '(p `TODO: list all songs and albums here, with links to where they are uploaded`)

   ~(div
      {:id "music-list"}
      (div {:class "project-search-div"})
      (table
        (tr (th "Title") (th "Medium") (th "Available"))
        ,;(map common/render-song all-songs)))
   ])

(def root
  (common/make-page
    :head head
    :body body
    :sidebar-items sidebar))
