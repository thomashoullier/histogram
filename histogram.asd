(defsystem histogram
  :name "histogram"
  :author "Thomas HOULLIER"
  :components
  ((:module "src"
    :components ((:file "package")
                 (:file "histogram" :depends-on ("package")))))
  :in-order-to ((test-op (test-op "histogram/test"))))

(defsystem histogram/test
  :name "histogram/test"
  :depends-on ("rove" "histogram")
  :components
  ((:module "test"
    :components ((:file "rove-suite"))))
  :perform (test-op (o c) (symbol-call :rove '#:run c)))
