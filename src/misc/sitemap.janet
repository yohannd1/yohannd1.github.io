(import spork/date)
(import ../utils)

# Reference: https://octopus.do/sitemap/blog/how-to-create-an-xml-sitemap-and-put-your-website-on-the-map

(def today (date/to-string (os/date) "yyyy-MM-dd"))

(defn to-url-tag [addr]
  ~(url
     (loc ,addr)
     (lastmod ,today)
     (changefreq "weekly")
     (priority "0.5")))

(defn build-root [base-url page-names]
  (def addrs (map (fn [x] (string/format "%s/%s.html" base-url x)) page-names))
  (def url-tags (map to-url-tag addrs))

  ~(urlset {:xmlns "http://www.sitemaps.org/schemas/sitemap/0.9"} ,;url-tags))
