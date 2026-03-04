(import spork/date)

(import ../utils)
(import ../webgen/html)
(use ../data/updates)

(def- weekdays (string/split " " "Sun Mon Tue Wed Thu Fri Sat"))
(def- months (string/split " " "Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec"))

(defn- correct-date-format [x]
  (def dt (date/from-string x "yyyy/MM/dd HH:mm -03:00"))
  (string
    (in weekdays (in dt :week-day)) ", "
    (in months (in dt :month)) " "
    (date/to-string dt "dd yyyy HH:mm:ss") " -0300"))

(defn to-item [u]
  (def {:time u-time :message u-msg} u)

  (def msg-html (html/render-node u-msg))
  (def correct-date (correct-date-format u-time))

  ~(item
     (title ,(string/format "Update from %s" correct-date))
     (pubDate ,correct-date)
     (description (:cdata-raw ,msg-html))))

(def- items
  (map to-item all-updates))

(def root
  # structure heavily referenced from https://www.pwndrenard.net/nouvelles.xml
  ~(rss {:version "2.0"}
     (channel
       (title "yohannd1 - updates")
       (link "https://yohannd1.github.io/updates.html")
       (description "Updates for yohannd1's website")
       (language "en-us")
       ,;items)))
