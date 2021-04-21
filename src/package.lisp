(defpackage histogram
  (:use :cl)
  (:export #:make-hist
           #:bounds
           #:center-of-bins
           #:counts
           #:oob-counts
           #:total-counts
           #:nbins
           #:bin-size
           #:min-bound
           #:max-bound
           #:add))
