(defsystem histogram
  :name "histogram"
  :author "Thomas HOULLIER"
  :components
  ((:module "src"
    :components ((:file "package")
                 (:file "histogram" :depends-on ("package"))))))
