(in-package :histogram)

(defclass hist ()
  ((bounds :documentation "Min/Max bounds."
           :reader bounds :initarg :bounds)
   (center-of-bins :documentation "Center values for the bins."
                   :reader center-of-bins :initarg :center-of-bins)
   (counts :documentation "Number of occurences in each bin."
           :reader counts :initarg :counts)
   (oob-counts :documentation "Counts below/above bounds."
               :reader oob-counts :initarg :oob-counts)
   (total-counts :documentation "Total number of occurences."
                 :reader counts :initarg :total-counts)
   (nbins :documentation "Number of bins."
          :reader nbins :initarg :nbins)
   (bin-size :documentation "Size of bins."
             :reader bin-size :initarg :bin-size)))

(defun make-hist (bounds nbins &key (data nil data-supplied-p))
  "Create a hist instance."
  (let* ((center-of-bins (make-array nbins))
         (min-val (car bounds)) (max-val (cadr bounds))
         (bin-size (/ (- max-val min-val) nbins))
         (hist))
    ;; Create the auxilary center values for bins.
    (loop for i from 0 below nbins do
      (setf (aref center-of-bins i) (+ min-val (* (+ i (/ 1 2)) bin-size))))
    ;; Instantiate.
    (setf hist (make-instance
                'hist :bounds bounds
                :counts (make-array nbins :initial-element 0)
                :center-of-bins center-of-bins :oob-counts (list 0 0)
                :total-counts 0
                :nbins nbins :bin-size bin-size))
    ;; Treat the eventual initial data.
    (when data-supplied-p (add hist data))
    hist))

(defmethod add ((hist hist) data)
  "Add data to the histogram."
  (with-slots ((counts counts)
               (oob-counts oob-counts)
               (total-counts total-counts)) hist
    (let ((min-val (min-val hist))
          (bin-num) (bin-size (bin-size hist)) (nbins (nbins hist)))
      (loop for val across data do
        (setf bin-num (floor (/ (- val min-val) bin-size)))
        (cond ((< bin-num 0) (incf (car oob-counts)))
              ((> bin-num (1- nbins)) (incf (cadr oob-counts)))
              (T (incf (aref counts bin-num))))
        (incf total-counts)))))

;;; Additional information about histogram.
(defmethod min-val ((hist hist)) (car (bounds hist)))
(defmethod max-val ((hist hist)) (cadr (bounds hist)))
