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

(defn array-or-tuple? [x]
  (or (array? x) (tuple? x)))

(defn make-set
  "Turn a data structure into a set of its elements."
  [ds]
  (def ret @{})
  (each x ds
    (set (ret x) true))
  (table/to-struct ret))
