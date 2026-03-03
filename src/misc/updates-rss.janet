(import ../utils)
(import ../webgen/html)
(use ../data/updates)

(defn to-item [u]
  (def {:time u-time :message u-msg} u)

  (def msg-html (html/render-node u-msg))

  ~(item
     (title ,(string/format "Update from %s" u-time))
     (pubDate ,u-time) # TODO: (os/strftime "%A, %d %b %Y %H:%M:%S -0300")
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
