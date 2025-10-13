(import ../common)
(import ../utils)
(use ../data/updates)
(use ../data/projects)

(def -fold common/make-fold)
(def -summary common/make-summary)
(def -link common/make-link)
(def -script common/make-script)

(def- commits-url
  `https://github.com/yohannd1/yohannd1.github.io/commits/main/`)

(defn -h1 [& content] ['h1 {:class "big1"} ;content])
(defn -h2 [& content] ['h2 {:class "big2"} ;content])

(def- head
  ['(title `yohannd1...`)
   (-script `index.js`)])

(def- sidebar
  [~(p ,(-link "#s-start" "Start"))
   ~(p ,(-link "#s-apps" "Mini apps"))
   ~(p ,(-link "#s-documents" "Notes & documents"))
   ~(p ,(-link "#s-updates" "Updates"))
   ~(p ,(-link "#s-todos" "To-dos"))
   ~(p ,(-link "#s-social" "Social"))])

(def- body
  ['(h1 {:class "big1" :id "s-start"} `Hey there!`)

   '(p
     `Welcome to my personal website. I want to put most of my stuff here.` (br)
     `I am a programmer and musician, currently pursuing a computer science degree.` (br)
     `I'm currently very invested in low-level programming and chiptune, and a bit of game development.`)

   ~(p `You might be interested in ` ,(-link `https://github.com/yohannd1/` `my repositories over on GitHub`)
       ` and my music over ` ,(-link `https://youtube.com/@SwapXFO` `on my YouTube channel`) `.` (br)
       `(Some more related links at the end of the page)`)

   (-h2 `Latest update`)
   (-> all-updates (first) (common/render-update))

   (-h2 `Current projects`)
   ~(p `Here are some of the projects I'm publicly working on.` (br)
       `See the ` ,(-link `projects.html` `full projects page`) ` for other projects I've worked on.`)

   ['table
    ;(as->
       all-projects .x
       (filter |(common/project/has-tag? 'in-progress $) .x)
       (map common/render-project .x))]

   (-fold
     {:open true :id "s-apps"} (-summary 2 `Mini apps`)
     ['p `I'm not the biggest web app enthusiast but there are a lot of upsides (mostly portability and ease of development).`]
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
         `If you want a thorough list, check out the ` ,(-link commits-url `git log`) ` instead.`)

     ;(as->
        all-updates .x
        (map common/render-update .x)
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
     )

   '(h2 {:class "big2" :id "s-social"} `Social`)
   ~(ul
      (li ,(-link `https://swapxfo.bandcamp.com/music` `My music (on Bandcamp - organized + you can pay me if you want!!1)`))
      (li ,(-link `https://archive.org/search?query=creator%3A%22SwapXFO%22`
                 `My music (on Archive.org - inconsistent uploads but I put module/project files over there)`))
      (li ,(-link `https://swapxfo.newgrounds.com/` `Newgrounds page (at the moment it's mostly music as well)`)))

   '(div {:class "little-cards"}
         (a {:href "https://openmpt.org/"} (img {:src "img/button-openmpt.png"}))
         (a {:href "https://pwndrenard.net/"} (img {:src "img/button-pwndrenard.png"})))
   ])

(def root
  (common/make-page
    :head head
    :body body
    :sidebar-items sidebar))
