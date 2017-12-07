(use '[clojure.string :only (split)])
(use '[clojure.set :only (difference)])

(if (= *command-line-args* nil)
  (
    (println "No arguments given")
    (System/exit 1)
  )
)

(def inputs (map (fn [line] (split line #",?\s+")) *command-line-args*))
(def names (set (map (fn [line] (nth line 0)) inputs)))
(def heldItems
  (set
    (mapcat identity
      (map
        (fn [line] (drop 3 line))
        (filter (fn [item] (> (count item) 2)) inputs)
      )
    )
  )
)
(println (first (difference names heldItems)))
