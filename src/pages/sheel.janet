(import ../common)
(import ../utils)

(def -summary common/make-summary)
(def -link common/make-link)
(def -script common/make-script)

(def- head
  [
   '(title `:)`)
   (-script `index.js`)
   ])

(def- sidebar [])

(def- body
  [
   '(img {:src "img/sheel1.jpg"})

   '(p "Borg instructions:")
   '(ul
      (li (code "borg init") ": init repository")
      (li (code "borg create") ": make a backup")
      (li (code "borg list <REPO>::<VER>") ": list files in the specific backup in that repo")
      (li (code "borg check <REPO>") ": integrity check (rather slow)")
      (li (code "borg extract [--stdout] <REPO>::<VER> [FILE...]") ": extract files, by default to the current dir (/home/user/thing.txt becomes $PWD/home/user/thing.txt); if --stdout is passed it prints file contents to stdout")
      )

   ])

(def root
  (common/make-page
    :head head
    :body body
    :sidebar-items sidebar))
