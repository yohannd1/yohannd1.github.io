(import ../common)
(import ../data/updates)
(import ../utils)

(def -fold common/make-fold)
(def -summary common/make-summary)
(def -link common/make-link)
(def -script common/make-script)

(def- commits-url `https://github.com/yohannd1/yohannd1.github.io/commits/main/`)

(defn format-update [u]
  ~(table
     (tr (td (i ,(in u :time))))
     (tr (td ,(in u :message)))
     ))

(defn -project-title [title &opt year]
  (assert (string? title) (-> "Expected string, got %j" (string/format title)))

  (def year-arr
    (cond
      (nil? year) []

      (or (string? year) (number? year))
      [['small (string/format " (%s)" (string year))]]

      (-> "Expected string or number, got %j" (string/format year) (error))
      ))

  ['span title ;year-arr]
  )

(defn -project-row [title & content]
  ~(tr
     {:class "project-row"}
     (td ,title)
     (td ,;content)))

(defn -project-field [name & content]
  ['p {:class (string "project-" name)} ;content])

(def valid-project-tags
  (do
    (def arr
      ["music" "tool" "library" "game" "game-jam"
       "in-progress" "discarded"
       # not sure about these:
       "standard" "website"
       ])
    (def ret @{})
    (each x arr
      (set (ret x) true))
    (table/to-struct ret)
    ))

(defn valid-project-tag? [t]
  (-> valid-project-tags (in t) (= true)))

(defn -project-taglist [& tags]
  (def arr @[])
  (loop [[i tag] :pairs tags]
    (unless (valid-project-tag? tag)
      (-> "Invalid project tag: %j" (string/format tag) (error)))
    (array/push arr ~(span {:class "project-tag-clickable"} ,tag))
    (unless (= i (-> tags (length) (- 1)))
      (array/push arr '(:raw "&nbsp;")))
    )
  ~(div {:class "project-taglist"} ,;arr))

(defn -project-description [& content]
  ['div {:class "project-description"} ;content])

(defn -h1 [& content] ['h1 {:class "big1"} ;content])
(defn -h2 [& content] ['h2 {:class "big2"} ;content])

(def- head
  [
   '(title `yohannd1 :)`)
   (-script `index.js`)
   ])

(def- sidebar
  [
   ~(p ,(-link "#s-start" "Start"))
   ~(p ,(-link "#s-links" "Links"))
   ~(p ,(-link "#projects-list" "Projects"))
   ~(p ,(-link "#s-apps" "Mini apps"))
   ~(p ,(-link "#s-documents" "Notes & documents"))
   ~(p ,(-link "#s-updates" "Updates"))
   ~(p ,(-link "#s-todos" "To-dos"))
   ])

(def- body
  [
   '(h1 {:class "big1" :id "s-start"} `hey there!`)

   ~(p
     `This is one of the places I currently put my stuff.` (br)
     `I am an aspiring programmer, currently pursuing a CS degree, and also a musician.` (br)
     (small (i `psst: I'm still organizing this, but I hope to make it in a portfolio of some kind later. Partially, I mean.`))
     )

  (-> updates/all-updates (in 0) (format-update))

  (-fold
    {:open true :id "s-links"} (-summary 2 `Links`)

    ['p (-link `https://github.com/yohannd1/` `My GitHub`)]
    ['p (-link `https://swapxfo.bandcamp.com/music` `My music (on Bandcamp - organized + you can pay me if you want!!1)`)]
    ['p (-link `https://youtube.com/@SwapXFO` `My music (on YouTube - updated more frequently)`)]
    ['p (-link `https://archive.org/search?query=creator%3A%22SwapXFO%22`
               `My music (on Archive.org - inconsistent uploads but I put module/project files over there)`)]
    ['p (-link `https://swapxfo.newgrounds.com/` `Newgrounds page (at the moment it's mostly music as well)`)]
    )

 (-fold
   {:open true :id "projects-list"} (-summary 2 `Projects`)

   ~(p `Here is an attempt at a somewhat comprehensible list of projects I've worked on.` (br)
       `As I've already worked in many, there will probably a lot of them not included here.` (br)
       `But I'll be trying to put the most important ones.`)

   ['div {:id "search-bar-div"}]

   ['table
    (-project-row
      (-project-title `ConquestVM`)
      (-project-description ``32-bit fantasy computer, mostly inspired by Uxn. Includes a compiler and emulator.``)
      (-project-field "url" (-link `https://github.com/yohannd1/conquest-vm` `Repo URL`))
      (-project-taglist "in-progress"))

    (-project-row
      (-project-title `dotcfg`)
      (-project-description ``A very lightweight configuration daemon for use with my dotfiles. Works as an alternative to xrdb (Xresources) and can be used even out of graphical displays.``)
      (-project-field "url" (-link `https://github.com/yohannd1/dotcfg` `Repo URL`))
      (-project-taglist "tool"))

    (-project-row
      (-project-title `Intrepid Normalization` 2024)
      (-project-description ``My third album - a challenge I took upon myself of making a few tracks in pure LMMS (only stock plugins and samples from the app). Smaller in track count, but with longer tracks (~5mins).``)
      (-project-field "url" (-link `https://swapxfo.bandcamp.com/album/intrepid-normalization` `On Bandcamp`))
      (-project-field "url" (-link `https://www.youtube.com/playlist?list=PLs9PG-E1jX28bVXitlj4DaLLTLR9Oy9Lg` `On Youtube`))
      (-project-taglist "music"))

    (-project-row
      (-project-title `J.C. Experiment OST` `2024-2025`)
      (-project-description ``A soundtrack for Ruvyzvat's J.C. Experiment.``)
      (-project-field "url" (-link `https://www.youtube.com/playlist?list=PLs9PG-E1jX281IGlKSImBSwveHi0aRGJd` `On Youtube`))
      (-project-field "url" (-link `https://www.roblox.com/games/14797253047/J-C-Experiment` `Check the game out on Roblox`))
      (-project-taglist "music" "in-progress"))

    (-project-row
      (-project-title `Acrylic`)
      (-project-description ``An... "up-and-coming" file format of mine for plain-text notetaking, trying to combine the convenience of Markdown with the outlining power of org-mode, along with a (somewhat) easy-to understand syntax and (hopefully) consistent rules.``)
      (-project-field "url" (-link `https://github.com/yohannd1/acrylic.vim` `Vim plugin`))
      (-project-field "url" (-link `https://github.com/yohannd1/acrylic_parser` `Parser + HTML exporter`))
      (-project-taglist "standard" "library" "tool"))

    (-project-row
      (-project-title `Intertia`)
      (-project-description ``A simplistic HTML5 slides tool``)
      (-project-field "url" (-link `https://yohannd1.github.io/intertia` `Website`))
      (-project-field "url" (-link `https://github.com/yohannd1/intertia` `Github Repo`))
      (-project-taglist "library"))

    (-project-row
      (-project-title `This website`)
      (-project-description
        ['p `This in itself could be considered a project, I guess!`]
        ['p `Right now it's a static website, generated in Janet in somewhat-of-a-DSL, and it's really cool.`]
        ['p `Adds a lot of convenience to making a website for the tradeoff of a negligible (at least for now) compile time.`])
      (-project-taglist "website"))

    (-project-row
      (-project-title `Atmospheric Mind` 2023)
      (-project-field "url" (-link `https://swapxfo.bandcamp.com/album/atmospheric-mind` `On Bandcamp`))
      (-project-field "url" (-link `https://www.youtube.com/playlist?list=PLs9PG-E1jX28aVldSTgiHP3Ky7io3U5uJ` `On Youtube`))
      (-project-description
        ['p `My second album! Has a more proper instrumentation and a lengthier duration.`]
        ['p `It began with the idea of trying to replicate low-quality samples, though it kind of lost most of that quality on the latter tracks.`]
        ['p `And, at this point, I also know how to use actual low-quality samples in trackers, so if I really wanna go in that direction I hope I'll have a much better time.`])
      (-project-taglist "music"))

    (-project-row
      (-project-title `Endless Life, Endless Death (ELED)` 2023)
      (-project-field "url" (-link `https://forum.gamemaker.io/index.php?threads/the-springing-gmc-jam-49-games-topic.103727/#post-626100` `GMC 49 Jam URL`))
      (-project-field "url" (-link `https://gx.games/games/5o5585/endless-life-endless-death/` `Play on GX.Games (chromium only, I think)`))
      (-project-field "url" (-link `https://www.youtube.com/playlist?list=PLs9PG-E1jX29Kx_Yqmyn9gglOQi3aAYNH` `Soundtrack (on YouTube, PCMD8+VirtualBoy)`))
      (-project-description
        ['p `My first published game!`]
        ['p `It's a (comically) short entry me and a friend of mine submitted to YoYoGames's 49th GMC Jam.`]
        ['p `It was pretty fun to work on, and I hope to do more of this in the future.`]
        ['p `P.S.: And sorry for not having an executable build... they forgot to give the Jam license lol`])
      (-project-taglist "game" "game-jam" "music"))

    (-project-row
      (-project-title `Hopeless Keyshift` 2022)
      (-project-description ``My first released album.``)
      (-project-field "url" (-link `https://swapxfo.bandcamp.com/album/hopeless-keyshift` `On Bandcamp`))
      (-project-field "url" (-link `https://www.youtube.com/playlist?list=PLs9PG-E1jX2_mE8VgTxBHqLPPCFYauDDz` `On Youtube`))
      (-project-taglist "music"))

    (-project-row
      (-project-title `tq` 2019)
      (-project-description ``A small task format I was tinkering with, mostly inspired by todo.txt and sjl's t. Somewhat of a precursor to acrylic, I think, and one of my first successful parsing projects. TODO: add link to tq.vim and perhaps tq.rs here too!``)
      (-project-field "url" (-link `https://github.com/yohannd1/tq` `Main code`))
      (-project-taglist "tool" "discarded"))
    ]
   )

   (-fold
     {:open true :id "s-apps"} (-summary 2 `Mini apps`)
     ['p `I'm not the biggest web app enthusiast but I recognize it can be a good tool.`]
     ['p `Here I am putting forth some small tools (only one at the moment) that I think might be useful.`]
     ['p (-link `key-tester.html` `Key tester`) ` (uses JS to track key presses)`]
     )

   (-fold
     {:open true :id "s-documents"} (-summary 2 `Notes and documents`)
     ['p `While I don't have my personal wiki, I guess this suffices?`]
     ['p (-link `tutorial-c.html` `Mini tutorial de C`) ` (wip) (pt-br)`]
     ['p (-link `sistema-pa.html` `Sistema Pa`) ` (lógica) (pt-br)`]
     )

  (-fold
    {:id "s-updates"} (-summary 2 `Updates`)

    ~(p `A short update log. I'm lazy so I probably won't update this always.` (br)
        `If you want a thorough list, check out the `
        ,(-link commits-url `git log`)
        ` instead.`
        )

    ;(as->
       updates/all-updates .x
       (map format-update .x)
       (utils/interpolate .x ~(br))
       ))

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
       (li `TODO: figure out a better way to place the small website cards (maybe make what friend did @ https://www.pwndrenard.net/about/liens.htm)`)
       )

    '(p `And here's also a list of more codebase-related to-dos I guess...`)

    '(ul
       (li `TODO: restructure the page code so each page exposes a single function that takes some export info and returns the contents`)
       (li `TODO: make the page list a map with the name and its info. Would help with page titles and automatic sidebar.`)
       (li `TODO: figure a simple way to batch-import functions in each page (I'm lazy).`)
       (li `TODO: fetch some font from the internet at build time (PLEASE CACHE IT WHEN DOING IT LOCALLY)`)
       (li `TODO: tag system: make each word some sort of command. Must be easy to parse though ffs`)
       (li `TODO: integrate acrylic wiki here... somehow`)
       )
    )
  ])

(def root
  (common/make-page
    :head head
    :body body
    :sidebar-items sidebar))
