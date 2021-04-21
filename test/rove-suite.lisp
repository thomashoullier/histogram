;;;; Rove test suite for histogram.
(defpackage histogram/test
  (:use :cl :rove :histogram))

(in-package :histogram/test)

(deftest validation
  (let* ((hist1)
         (bounds '(0 10))
         (nbins 4)
         (center-of-bins-val #(5/4 15/4 25/4 35/4))
         (empty-counts-val (make-array nbins :initial-element 0))
         (empty-oob-counts-val (list 0 0))
         (bin-size-val (/ (- (cadr bounds) (car bounds)) nbins))
         (data #(1 1 1 9 11 6 0.1 -2 -3))
         (counts-val #(4 0 1 1))
         (total-counts-val 9)
         (oob-counts-val (list 2 1)))
    (testing "Empty histogram instantiation."
      (setf hist1 (make-hist bounds nbins))
      (pass "created")
      (ok (and (equal (bounds hist1) bounds)
               (equalp (center-of-bins hist1) center-of-bins-val)
               (equalp (counts hist1) empty-counts-val)
               (equal (oob-counts hist1) empty-oob-counts-val)
               (= (total-counts hist1) 0)
               (= (nbins hist1) nbins)
               (= (bin-size hist1) bin-size-val)
               (= (min-bound hist1) (car bounds))
               (= (max-bound hist1) (cadr bounds)))
          "valid"))
    (testing "Adding data."
      (add hist1 data)
      (ok (and (equalp (counts hist1) counts-val)
               (= (total-counts hist1) total-counts-val)
               (equal (oob-counts hist1) oob-counts-val))
          "valid"))))
