(import ../common)

(def -fold common/make-fold)
(def -summary common/make-summary)
(def -link common/make-link)
(def -script common/make-script)

(defn -project-row [title & content]
  (def title-arr (if (string? title) [title] title))
  ~(tr
     {:class "project-row"}
     (td ,;title-arr)
     (td ,;content)))
(defn -project-field [name & content]
  ['p {:class (string "project-" name)} ;content])
(defn -project-taglist [& tags]
  ['div {:class "project-taglist"} ;(map |['div $] tags)])
(defn -project-description [& content]
  ['div {:class "project-description"} ;content])

(def- head
  [
   ['title `Yohanan's Website`]
   (-script `index.js`)
   ])

(def- body
  [
   (-fold
     {:open true} (-summary 1 `Hey there!`)
     ['p `This is one of the places I currently put my stuff.`]
     ['p `I am a mostly-self-taught programmer (and currently pursuing a CS degree). I also do music!`]

     ['p `If you want to check out my work:`]
     (-fold
       {:open true} (-summary 2 `Links`)

       ['p (-link `https://github.com/yohannd1/` `My GitHub`)]
       ['p (-link `https://swapxfo.bandcamp.com/music` `My music (on Bandcamp - organized + you can pay me if you want!!1)`)]
       ['p (-link `https://youtube.com/@SwapXFO` `My music (on YouTube - updated more frequently)`)]
       ['p (-link `https://archive.org/search?query=creator%3A%22SwapXFO%22`
                  `My music (on Archive.org - inconsistent uploads but I put module/project files over there)`)]
       )

     (-fold
       {:id "projects-list"} (-summary 2 `Projects`)

       ['table
        (-project-row
          `ConquestVM`
          (-project-description ``In-progress 32-bit pseudo-architecture, compiler and emulator, mostly inspired by Uxn.``)
          (-project-field "url" (-link `https://github.com/yohannd1/conquest-vm` `Repo URL`))
          (-project-taglist "fantasy" "in-progress"))

        (-project-row
          `dotcfg`
          (-project-description ``A very lightweight configuration daemon for use with my dotfiles. Works as an alternative to xrdb (Xresources) and can be used even out of graphical displays.``)
          (-project-field "url" (-link `https://github.com/yohannd1/dotcfg` `Repo URL`))
          (-project-taglist "tool"))

        (-project-row
          [`Intrepid Normalization` ~(p (small ` (2024)`))]
          (-project-description ``My third album - a challenge I took upon myself of making a few tracks in pure LMMS (only stock plugins and samples from the app). Smaller in track count, but with longer tracks (~5mins).``)
          (-project-field "url" (-link `https://swapxfo.bandcamp.com/album/intrepid-normalization` `On Bandcamp`))
          (-project-field "url" (-link `https://www.youtube.com/playlist?list=PLs9PG-E1jX28bVXitlj4DaLLTLR9Oy9Lg` `On Youtube`))
          (-project-taglist "music"))

        (-project-row
          [`J.C. Experiment OST` ~(p (small ` (2024)`))]
          (-project-description ``A soundtrack for Ruvyzvat's J.C. Experiment.``)
          (-project-field "url" (-link `https://www.youtube.com/playlist?list=PLs9PG-E1jX281IGlKSImBSwveHi0aRGJd` `On Youtube`))
          (-project-field "url" (-link `https://www.roblox.com/games/14797253047/J-C-Experiment` `Check the game out on Roblox`))
          (-project-taglist "music" "in-progress"))

        (-project-row
          `Acrylic`
          (-project-description ``An... "up-and-coming" file format of mine for plain-text notetaking, trying to combine the convenience of Markdown with the outlining power of org-mode, along with a (somewhat) easy-to understand syntax and (hopefully) consistent rules.``)
          (-project-field "url" (-link `https://github.com/yohannd1/acrylic.vim` `Vim plugin`))
          (-project-field "url" (-link `https://github.com/yohannd1/acrylic_parser` `Parser + HTML exporter`))
          (-project-taglist "format" "library" "tool"))

        (-project-row
          `Intertia`
          (-project-description ``A simplistic HTML5 slides tool``)
          (-project-field "url" (-link `https://yohannd1.github.io/intertia` `Website`))
          (-project-field "url" (-link `https://github.com/yohannd1/intertia` `Github Repo`))
          (-project-taglist "web-frontend" "library"))

        (-project-row
          `This website`
          (-project-description
            ['p `This in itself could be considered a project, I guess!`]
            ['p `Right now it's a static website, generated in Janet in somewhat-of-a-DSL, and it's really cool.`]
            ['p `Adds a lot of convenience to making a website for the tradeoff of a negligible (at least for now) compile time.`])
          (-project-taglist "meta" "website"))

        (-project-row
          [`Atmospheric Mind` ~(p (small ` (2023)`))]
          (-project-field "url" (-link `https://swapxfo.bandcamp.com/album/atmospheric-mind` `On Bandcamp`))
          (-project-field "url" (-link `https://www.youtube.com/playlist?list=PLs9PG-E1jX28aVldSTgiHP3Ky7io3U5uJ` `On Youtube`))
          (-project-description
            ['p `My second album! Has a more proper instrumentation and a lengthier duration.`]
            ['p `It began with the idea of trying to replicate low-quality samples, though it kind of lost most of that quality on the latter tracks.`]
            ['p `And, at this point, I also know how to use actual low-quality samples in trackers, so if I really wanna go in that direction I hope I'll have a much better time.`])
          (-project-taglist "music"))

        (-project-row
          [`Endless Life, Endless Death (ELED)` ~(p (small ` (2023)`))]
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
          [`Hopeless Keyshift` ~(p (small ` (2022)`))]
          (-project-description ``My first released album.``)
          (-project-field "url" (-link `https://swapxfo.bandcamp.com/album/hopeless-keyshift` `On Bandcamp`))
          (-project-field "url" (-link `https://www.youtube.com/playlist?list=PLs9PG-E1jX2_mE8VgTxBHqLPPCFYauDDz` `On Youtube`))
          (-project-taglist "music"))
        ]
       )

     (-fold
       {} (-summary 2 `Web apps`)
       ['p `I'm not the biggest web app enthusiast but I recognize it can be a good tool.`]
       ['p `Here I am putting forth some small tools (only one at the moment) that I think might be useful.`]
       ['p (-link `key-tester.html` `Key tester`) ` (uses JS to track key presses)`]
       )

     (-fold
       {} (-summary 2 `Notes and documents`)
       ['p `While I don't have my personal wiki, I guess this suffices?`]
       ['p (-link `tutorial-c.html` `Mini tutorial de C`) ` (wip) (pt-br)`]
       ['p (-link `sistema-pa.html` `Sistema Pa`) ` (lógica) (pt-br)`]
       )

     ['p ['small ['i `I suppose this works as a portfolio?`]]]
     )]
)

(def root
  (common/make-page
    :head head
    :body body))
