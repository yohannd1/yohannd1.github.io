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
   '(p ($link "#s-start" "Start"))
   ])

(def- body
  [
   '(h1 {:class "big1" :id "s-start"} `music`)

   '(p `So yeah, I'm also a musician. It's a rather fun activity.`)
   '(p `I started doing "okay" music in late 2021, I think. `
       `At the moment I mostly use ` ($link "https://github.com/tildearrow/furnace" "Furnace") ` and `
       ($link "https://lmms.io/" "LMMS" "quite the odd piece...")
       ` to make music. They're really powerful open source tools, despite some shortcomings.`)

   '(p `Over the years I've posted my music in a few different places:`)
   '(ul
      (li "my " ($link "https://youtube.com/@SwapXFO" "youtube channel") " has most of them;")
      (li "my " ($link "https://archive.org/details/@swapxfo" "internet archive account") " also has most of them, including project files / modules in most cases;")
      (li "some tracks were made for " ($link "https://battleofthebits.com/barracks/Profile/swapxfo/" "battle of the bits") ", so there's related songs there as well;")
      (li "I occasionally publish albums on " ($link "https://swapxfo.bandcamp.com/" "bandcamp") ", and you can give me money there hehe;")
      (li "I also have a " ($link "https://swapxfo.newgrounds.com/" "newgrounds") " account but I haven't used that very often;"))
   '(p `This page is supposed to eventually mention all songs I've published, and for now I'm focusing on uploading them to the internet archive. I'd like to host them close to the website as well but I don't think putting the files on a GitHub repo is a good idea, and that might get the repo deleted...`)

   '(p `Song names here usually follow a specific format, composed of these, in order:`)
   '(ul
      (li `song name;`)
      (li `"(Arrange)" if the song is a rearrangement/remix/cover;`)
      (li `Source of the song, if applicable, in square brackets (e.g. "[Deltarune CH2]");`)
      (li `other people who worked on the song (e.g. "ft. SwapXFO");`))

   ~(div
      {:id "music-list"}
      (div {:class "project-search-div"})
      (table ,;(map common/render-song songs-published)))

   '(p `TODO: list older songs and albums here, with links to where they are uploaded`)

   ])

(def root
  (common/make-page
    :head head
    :body body
    :sidebar-items sidebar))
