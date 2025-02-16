(import ../common)

# common "controls" used here
(def -fold common/make-fold)
(def -summary common/make-summary)
(def -link common/make-link)
(def -script common/make-script)

(def- head
  [
   ['title `Key Tester`]
   (-script `key-tester.js`)
   ])

(def- body
  [
   (-fold {:open true} (-summary 1 `Key Tester`)
     ['p `This is a small keyboard "polyphony" tester - useful for checking which keys are pressed (and their names).`]
     ['p `Just press any key and it should appear on the list below; when released, it'll disappear.`]

     (-fold {:open true :id "pressed-keys-list"} (-summary nil `Pressed keys:`)
       ['noscript `Sorry, but this page is useless without javascript.`]))
   ])

(def root
  (common/make-page
    :head head
    :body body))
