(in-package :histogram)

(defun hist (arr min-val max-val nbins)
  "Compute a histogram from data in `arr`. Goes from min-val
   to max-val with nbins bins.
   Returns: * Number of occurence for each bin. (array)
            * Center bin values. (array)
            * Number of values below min-val.
            * Number of values above max-val."
  (let ((bin-size (/ (- max-val min-val) nbins))
        (counts (make-array nbins :initial-element 0))
        (center-of-bins (make-array nbins))
        (n-below 0) (n-above 0)
        (bin-num 0))
    ;; Accumulate into bins.
    (loop for val across arr do
      (setf bin-num (floor (/ (- val min-val) bin-size)))
      (cond ((< bin-num 0) (incf n-below))
            ((> bin-num (1- nbins)) (incf n-above))
            (T (incf (aref counts bin-num)))))
    ;; Create the auxilary center values for bins.
    (loop for i from 0 below nbins do
      (setf (aref center-of-bins i) (+ min-val (* (+ i (/ 1 2)) bin-size))))
    (values counts center-of-bins n-below n-above)))
