(import ../common)
(use ../data/updates)
(use ../data/projects)
(import ../utils)

(def -fold common/make-fold)
(def -summary common/make-summary)
(def -link common/make-link)
(def -script common/make-script)

(def- commits-url `https://github.com/yohannd1/yohannd1.github.io/commits/main/`)

(defn format-update [u]
  ~(table
     (tr (td (i ,(in u :time))))
     (tr (td ,(in u :message)))))

(defn -project-title [title &opt year]
  (assert (string? title) (-> "Expected string, got %j" (string/format title)))

  (def year-arr
    (cond
      (nil? year) []

      (or (string? year) (number? year))
      [['small (string/format " (%s)" (string year))]]

      (-> "Expected string or number, got %j" (string/format year) (error))))

  ['span title ;year-arr])

(defn -project-row [title & content]
  ~(tr
     {:class "project-row"}
     (td ,title)
     (td ,;content)))

(defn -project-field [name & content]
  ['p {:class (string "project-" name)} ;content])

(defn make-set
  "Turn a data structure into a set of its elements."
  [ds]
  (def ret @{})
  (each x ds
    (set (ret x) true))
  (table/to-struct ret))

(def valid-project-tags
  (make-set
    ["music" "tool" "library" "game" "game-jam"
     "in-progress" "abandoned"
     # not sure about these:
     "standard" "website"]))

(defn valid-project-tag? [t]
  (-> valid-project-tags (in t) (= true)))

(defn -project-taglist [& tags]
  (def arr @[])
  (defn normalize-tag [tag]
    (cond
      (string? tag) tag
      (symbol? tag) (string tag)
      (error (string/format "invalid project tag: %j" tag))))
  (loop [[i tag-] :pairs tags
         :let [tag (normalize-tag tag-)]]
    (unless (valid-project-tag? tag)
      (-> "invalid project tag: %j" (string/format tag) (error)))
    (array/push arr ~(span {:class "project-tag-clickable"} ,tag))
    (unless (= i (-> tags (length) (- 1)))
      (array/push arr '(:raw "&nbsp;"))))
  ~(div {:class "project-taglist"} ,;arr))

(defn -project-description [& content]
  ['div {:class "project-description"} ;content])

(defn -h1 [& content] ['h1 {:class "big1"} ;content])
(defn -h2 [& content] ['h2 {:class "big2"} ;content])

(defn render-project [project]
  (def ret @[])
  (when (def title (in project :title))
    (array/push ret (-project-title title)))
  (when (def desc (in project :desc))
    (array/push ret (-project-description desc)))
  (each [name url] (in project :urls [])
    (array/push ret (-project-field "url" (-link url name))))
  (def tags (in project :tags []))
  (when (not (empty? tags))
    (array/push ret (-project-taglist ;tags)))
  (-project-row ;ret))

(def- head
  ['(title `yohannd1 :)`)
   (-script `index.js`)])

(def- sidebar
  [~(p ,(-link "#s-start" "Start"))
   ~(p ,(-link "#s-links" "Links"))
   ~(p ,(-link "#projects-list" "Projects"))
   ~(p ,(-link "#s-apps" "Mini apps"))
   ~(p ,(-link "#s-documents" "Notes & documents"))
   ~(p ,(-link "#s-updates" "Updates"))
   ~(p ,(-link "#s-todos" "To-dos"))])

(def- body
  ['(h1 {:class "big1" :id "s-start"} `hey there!`)

   ~(p
      `This is one of the places I currently put my stuff.` (br)
      `I am an aspiring programmer, currently pursuing a CS degree, and also a musician.` (br)
      (small (i `psst: I'm still organizing this, but I hope to make it in a portfolio of some kind later. Partially, I mean.`)))

   (-> all-updates (in 0) (format-update))

   (-fold
     {:open true :id "s-links"} (-summary 2 `Links`)

     ['p (-link `https://github.com/yohannd1/` `My GitHub`)]
     ['p (-link `https://swapxfo.bandcamp.com/music` `My music (on Bandcamp - organized + you can pay me if you want!!1)`)]
     ['p (-link `https://youtube.com/@SwapXFO` `My music (on YouTube - updated more frequently)`)]
     ['p (-link `https://archive.org/search?query=creator%3A%22SwapXFO%22`
                `My music (on Archive.org - inconsistent uploads but I put module/project files over there)`)]
     ['p (-link `https://swapxfo.newgrounds.com/` `Newgrounds page (at the moment it's mostly music as well)`)])

   (-fold
     {:open true :id "projects-list"} (-summary 2 `Projects`)

     ~(p `Here is an attempt at a somewhat comprehensible list of projects I've worked on.` (br)
         `As I've already worked in many, there will probably a lot of them not included here.` (br)
         `But I'll be trying to put the most important ones.`)

     ['div {:id "search-bar-div"}]

     ['table ;(map render-project all-projects)])

   (-fold
     {:open true :id "s-apps"} (-summary 2 `Mini apps`)
     ['p `I'm not the biggest web app enthusiast but I recognize it can be a good tool.`]
     ['p `Here I am putting forth some small tools (only one at the moment) that I think might be useful.`]
     ['p (-link `key-tester.html` `Key tester`) ` (uses JS to track key presses)`])

   (-fold
     {:open true :id "s-documents"} (-summary 2 `Notes and documents`)
     ['p `While I don't have my personal wiki, I guess this suffices?`]
     ['p (-link `tutorial-c.html` `Mini tutorial de C`) ` (wip) (pt-br)`]
     ['p (-link `sistema-pa.html` `Sistema Pa`) ` (lógica) (pt-br)`])

   (-fold
     {:id "s-updates"} (-summary 2 `Updates`)

     ~(p `A short update log. I'm lazy so I probably won't update this always.` (br)
         `If you want a thorough list, check out the `
         ,(-link commits-url `git log`)
         ` instead.`)

     ;(as->
        all-updates .x
        (map format-update .x)
        (utils/interpolate .x ~(br))))

   (-fold
     {:open true :id "s-todos"} (-summary 2 `To-dos`)

     '(p `Turns out I still have a lot to do with this website. I plan to make it one of my main "outlets" to the internet, though I'm still not fully sure if I'd make it the main one.` (br)
         `Well, here's a general list of stuff I need to do:`)

     '(ul
        (li `TODO: dedicated music page (with info about songs and filtering the project list)`)
        (li `TODO: dedicated programming page (could be kind of a portfolio ig)`)
        (li `TODO: blog + RSS feed + count them in the updates list`) # see https://www.w3schools.com/XML/xml_rss.asp and https://www.pwndrenard.net/nouvelles.xml
        (li `TODO: add contact info`)
        (li `TODO: make a list of old projects! ` (small `yeah this is also inspired by em's website lol`))
        (li `TODO: make a favicon`)
        (li `TODO: figure out a better way to place the small website cards (maybe make what friend did @ https://www.pwndrenard.net/about/liens.htm)`))

     '(p `And here's also a list of more codebase-related to-dos I guess...`)

     '(ul
        (li `TODO: restructure the page code so each page exposes a single function that takes some export info and returns the contents`)
        (li `TODO: make the page list a map with the name and its info. Would help with page titles and automatic sidebar.`)
        (li `TODO: figure a simple way to batch-import functions in each page (I'm lazy).`)
        (li `TODO: fetch some font from the internet at build time (PLEASE CACHE IT WHEN DOING IT LOCALLY)`)
        (li `TODO: tag system: make each word some sort of command. Must be easy to parse though ffs`)
        (li `TODO: integrate acrylic wiki here... somehow`))

     '(div {:class "little-cards"}
           (a {:href "https://openmpt.org/"} (img {:src "img/button-openmpt.png"}))
           (a {:href "https://pwndrenard.net/"} (img {:src "img/button-pwndrenard.png"}))))])

(def root
  (common/make-page
    :head head
    :body body
    :sidebar-items sidebar))
