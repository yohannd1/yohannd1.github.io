(import ./webgen)
(import ./common)

# common "controls" used here
(def -fold common/make-fold)
(defn -summary [size text]
  ['summary {:class (string "big" size)} text])
(defn -link [href text]
  ['a {:href href} text])
(defn -project-field [name & content]
  ['p {:class (string "project-" name)} ;content])
(defn -project-taglist [& tags]
  ['div {:class "project-taglist"} ;(map |['div $] tags)])
(defn -project-description [& content]
  ['div {:class "project-description"} ;content])

(def body
  [
   (-fold 'open (-summary 1 `Hey there!`)
     ['p `This is one of the places I currently put my stuff.`]
     ['p `I am a mostly-self-taught programmer (loosely studying since 2013, got a hang on 2018), and I also do music!`]

     ['p `If you want to check out my work:`]
     (-fold 'open (-summary 2 `Links`)
       ['p (-link `https://swapxfo.bandcamp.com/music` `My music (on Bandcamp)`)]
       ['p (-link `https://youtube.com/@SwapXFO` `My music (on YouTube - updated more frequently)`)]
       )

     (-fold 'closed (-summary 2 `Projects`)

       ['div {:class "project card"}
        (-project-field "title" `Intertia`)
        (-project-field "url" (-link `https://yohanandiamond.github.io/intertia` `Website`))
        (-project-field "url" (-link `https://github.com/YohananDiamond/intertia` `Github Repo`))
        (-project-description ``A simplistic HTML5 slides tool``)
        (-project-taglist "web-frontend" "library")]

       ['div {:class "project card"}
        (-project-field "title" `Hopeless Keyshift` ['small `(2022)`])
        (-project-field "url" (-link `https://swapxfo.bandcamp.com/album/hopeless-keyshift` `On Bandcamp`))
        (-project-field "url" (-link `https://www.youtube.com/playlist?list=PLs9PG-E1jX2_mE8VgTxBHqLPPCFYauDDz` `On Youtube`))
        (-project-description ``My first released album.``)
        (-project-taglist "music")]

       ['div {:class "project card"}
        (-project-field "title" `Atmospheric Mind` ['small `(2023)`])
        (-project-field "url" (-link `https://swapxfo.bandcamp.com/album/atmospheric-mind` `On Bandcamp`))
        (-project-field "url" (-link `https://www.youtube.com/playlist?list=PLs9PG-E1jX28aVldSTgiHP3Ky7io3U5uJ` `On Youtube`))
        (-project-description
          ['p `My second album! Has a more proper instrumentation and a lengthier duration.`]
          ['p `It began with the idea of trying to replicate low-quality samples, though it kind of lost most of that quality on the latter tracks.`]
          ['p `And, at this point, I also know how to use actual low-quality samples in trackers, so if I really wanna go in that direction I hope I'll have a much better time.`])
        (-project-taglist "music")]

       ['div {:class "project card"}
        (-project-field "title" `Endless Life, Endless Death (ELED)` ['small `(2023)`])
        (-project-field "url" (-link `https://forum.gamemaker.io/index.php?threads/the-springing-gmc-jam-49-games-topic.103727/#post-626100` `GMC 49 Jam URL`))
        (-project-field "url" (-link `https://gx.games/games/5o5585/endless-life-endless-death/` `Play on GX.Games (chromium only, I think)`))
        (-project-field "url" (-link `https://www.youtube.com/playlist?list=PLs9PG-E1jX29Kx_Yqmyn9gglOQi3aAYNH` `Soundtrack (on YouTube, PCMD8+VirtualBoy)`))
        (-project-description
          ['p `My first published game!`]
          ['p `It's a (comically) short entry me and a friend of mine submitted to YoYoGames's 49th GMC Jam.`]
          ['p `It was pretty fun to work on, and I hope to do more of this in the future.`]
          ['p `P.S.: And sorry for not having an executable build... they forgot to give the Jam license lol`])
        (-project-taglist "game" "game-jam" "music")]

       (-fold 'closed (-summary 2 `Small apps`)
         ['p (-link `apps/key_tester.html` `Key tester`) `(uses JS to track key presses)`]
         )

       (-fold 'closed (-summary 2 `Notes and documents`)
         ['p `While I don't have my personal wiki, I guess this suffices?`]
         ['p (-link `docs/c_tutorial.html` `Mini tutorial de C`) `(wip) (pt-br)`]
         ['p (-link `docs/sistema_pa` `Sistema Pa`) `(lógica) (pt-br)`]
         )

       ['p {:style `font-style: italic;`} `I guess this works as a portfolio?`]
     )
   )])

(-> (common/make-page :body body)
    (webgen/gen)
    (print))
