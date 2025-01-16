(defn- sm [time msg]
  # sm := short-message
  {:time time :message ~(div (span ,msg))})

(def all-updates
  [
   {:time "2025/01/15 21:03"
    :message
    ~(div
       (span `Website redesign mostly done!` (br)
          `Kinda broke mobile-friendliness in the process but I'll fix that later.` (br)
          `Design inspired by ` (a {:href "https://msx.horse/"} `em's website`) ` cuz it looked really cool.`
          ))
    }

   (sm "2025/01/15 20:12" `Trying to make this work`)
   ])
