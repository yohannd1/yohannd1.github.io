(import ../utils)
(use ../data/updates)

(defn to-item [u]
  (def {:time u-time :message u-msg} u)

  ~(item
     (title ,(string/format "Update from %s" u-time))
     (pubDate ,u-time)
     (description ,(string/format "SORRY, I NEED TO UPDATE THIS:\n\n%j" u-msg))))

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
