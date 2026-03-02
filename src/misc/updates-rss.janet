(import ../common)
(import ../utils)
(use ../data/updates)

# (def- body
#   ['(h1 {:class "big1" :id "s-start"} `updates`)
#    ~(p `A short update log. I'm lazy so I probably won't update this always.` (br)
#        `If you want a thorough list, check out the ` ,(-link commits-url `git log`) ` instead.`)
#    ;(as->
#       all-updates .x
#       (map common/render-update .x)
#       (utils/interpolate .x ~(br)))])

(def root
  # structure heavily referenced from https://www.pwndrenard.net/nouvelles.xml
  ~(rss {:version "2.0"}
     (channel
       (title "yohannd1 - updates")
       (link "https://yohannd1.github.io/updates.html")
       (description "Updates for yohannd1's website")
       (language "en-us"))))
