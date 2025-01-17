(defn interpolate [ds sep]
  "Interpolate `ds` with instances of `sep`."

  (def ret @[])
  (loop [[i val] :pairs ds]
    (array/push ret val)
    (unless (-> ds (length) (dec) (= i))
      (array/push ret sep))
    )
  ret)
