;; guile-cdata/guix.scm

;; Copyright (C) 2026 Matthew Wette
;;
;; This library is free software; you can redistribute it and/or
;; modify it under the terms of the GNU Lesser General Public
;; License as published by the Free Software Foundation; either
;; version 3 of the License, or (at your option) any later version.
;;
;; This library is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; Lesser General Public License for more details.
;;
;; You should have received a copy of the GNU Lesser General Public License
;; along with this library; if not, see <http://www.gnu.org/licenses/>

(define-module (guile-cdata-package)
  #:use-module (guix)
  #:use-module (guix packages)
  #:use-module (guix git)
  #:use-module (guix git-download)
  #:use-module (guix build-system gnu)
  #:use-module (guix licenses)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages guile))

(define vcs-file?
  (or (git-predicate (dirname (current-source-directory))) (const #t)))

(define guile-cdata-package
  (package
   (name "guile-cdata")
   (version "local")
   (source
    (local-file "." "guile-cdata-local" #:recursive? #t #:select? vcs-file?))
   (build-system gnu-build-system)
   (arguments (list #:strip-binaries? #f))
   (native-inputs (list guile-3.0))
   (inputs (list gcc))
   (home-page "https://github.com/mwette/guile-cdata")
   (synopsis "guile modules for handling C data structures")
   (license lgpl3+)
   (description
    "The _cdata_ module (‘(foreign cdata)’ and its partner _arch-info_
(‘(foreign arch-info)’ provide a way to work with data originating from
C libraries.  Size and alignment is tracked for all types.  The procedures
‘cbase’, ‘cstruct’, ‘cunion’, ‘cpointer’, ‘carray’, ‘cenum’ and ‘cfunction’
 generate _ctype_ objects, and the procedure ‘make-cdata’ will generate data
 objects based on these.  The underlying bits of data are stored in Scheme
 bytevectors.  Access to component data is provided by the ‘cdata-ref’
procedure and mutation is accomplished via the ‘cdata-set!’ procedure.
The modules support non-native machine architectures via the global
parameter ‘*arch*’.")))

guile-cdata-package

;; --- last line ---
