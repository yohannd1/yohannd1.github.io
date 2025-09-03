(defn interpolate [ds sep]
  "Interpolate `ds` with instances of `sep`."

  (def ret @[])
  (loop [[i val] :pairs ds]
    (array/push ret val)
    (unless (-> ds (length) (dec) (= i))
      (array/push ret sep)))
  ret)

(defmacro import-select [mod-name syms]
  (with-syms [pfx]
    (defn make-decl [sym]
      ['def sym (symbol (string pfx "/" sym))])
    ~(do
       (import ,mod-name :as ,pfx)
       ,;(map make-decl syms))
    ))
