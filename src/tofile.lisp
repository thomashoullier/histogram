;;;; File output for histogram.

(in-package :histogram)

(defvar *header* "# center of bin ; count")

(defmethod tofile ((hist hist) filename)
  "Output the histogram to a file."
  (with-open-file (str-out filename :direction :output
                                    :if-exists :supersede
                                    :if-does-not-exist :create)
    (format str-out "~A~%" *header*)
    (with-slots ((center-of-bins center-of-bins)
                 (counts counts) (oob-counts oob-counts)
                 (bin-size bin-size)) hist
      (let ((oob-below-center (- (aref center-of-bins 0) bin-size))
            (oob-above-center (+ (aref center-of-bins
                                       (1- (length center-of-bins)))
                                 bin-size)))
        ;; OOB count below histogram
        (format str-out "~A~%" (make-line oob-below-center (car oob-counts)))
        ;; Histogram
        (loop for count across counts
              for center-val across center-of-bins do
                (format str-out "~A~%" (make-line center-val count)))
        ;; OOB count above histogram
        (format str-out "~A~%"
                (make-line oob-above-center (cadr oob-counts)))))))

(defun make-line (val1 val2)
  "Create a string 'val1 ; val2'"
  (format nil "~F ; ~F" val1 val2))
