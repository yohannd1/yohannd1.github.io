(defn- short-message [time msg]
  # TODO: split by \n, and trim each line; use interpolate function to insert <br/> tags
  {:time time :message ~(div (span ,msg))})
(def- sm short-message)

(def all-updates
  [
   (sm "2025/01/16 22:21 -03:00"
       `Hadn't realized I would get so many ideas for my website. Feeling happy lol`)

   {:time "2025/01/15 21:03 -03:00"
    :message
    ~(div
       (span `Website redesign mostly done!` (br)
          `Kinda broke mobile-friendliness in the process but I'll fix that later.` (br)
          `Design inspired by ` (a {:href "https://msx.horse/"} `em's website`) ` cuz it looked really cool.`
          ))
    }

   (sm "2025/01/15 20:12 -03:00"
       `Trying to make this work`)
   ])
