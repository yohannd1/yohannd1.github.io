(defn- short-message [time msg]
  {:time time :message ~(div (span ,msg))})

(def- sm short-message)

(def all-updates
  [
   (sm "2026/02/13 00:20 -03:00" `Updating some things around here, mostly music related. I got a MIDI keyboard recently, btw! A "M-Audio Keystation 49 MK3", more specifically. Struggling a bit with the velocity curve but otherwise it's a really nice keyboard.`)

   {:time "2026/01/12 13:50 -03:00"
    :message
    ~(div
       `Decided to add a top nav to my website. Why the hell not.` (br)
       `I'm actually thinking of doing an overhaul on this website, but I'm not fully sure what direction I should go with. All I know is it looks dead af.`)}

   (sm "2025/12/31 23:22 -03:00" `Happy 2026!`)

   {:time "2025/10/12 21:42 -03:00"
    :message
    ~(div
       `A few months ago I had to install Vivado 2023.2, and had a library-related issue (missing libtinfo.so.5 or something).` (br)
       `Installed the 2025.1 version today and I am disappointed but not surprised to learn the issue is still there.` (br)
       `What saved me was ` (a {:href "https://gist.github.com/klpx/2e1d8a6a3a8b8d4e8407946a3e4cba3e"} `this gist post`) `. I don't know what I would have done without it.`)}

   (sm "2025/08/01 17:36 -03:00"
       `Spent quite a while working on Acrylic and cuca(sv) this week. I am terribly exhausted but I'm really proud of what I did managed to do :3`)

   {:time "2025/03/25 22:37 -03:00"
    :message
    ~(div
       `Was going to add a QR code generator page here.` (br)
       `But the library I was gonna use was too outdated and I realized that way too late. :(` (br)
       `So have ` (a {:href "https://nuintun.github.io/qrcode/#/encode"} `this instead`) `. It's pretty nice! Will use it myself.`
       )}

   (sm "2025/02/16 17:54 -03:00"
       `Reworked the project tag system. Now I have a strict set of tags, so I can't get lost in them...`)

   (sm "2025/01/16 22:21 -03:00"
       `Hadn't realized I would get so many ideas for my website. Feeling happy lol`)

   {:time "2025/01/15 21:03 -03:00"
    :message
    ~(div
       `Website redesign mostly done!` (br)
       `Kinda broke mobile-friendliness in the process but I'll fix that later.` (br)
       `Design inspired by ` (a {:href "https://msx.horse/"} `em's website`) ` cuz it looked really cool.`
       )}

   (sm "2025/01/15 20:12 -03:00"
       `Trying to make this work`)
   ])
