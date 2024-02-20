(import ../common)

(def -link common/make-link)

(def body
  [
   ['h1 `Whoops!`]
   ['p `This page doesn't seem to exist. Sorry.`]
   ['p `Maybe go back to the ` (-link `index.html` `Index page?`)]
   ])

(def root (common/make-page :body body))
