;; cdata-package.scm

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

(define-module (cdata-package)
  #:use-module (guix)
  #:use-module (guix packages)
  #:use-module (guix git)
  #:use-module (guix git-download)
  #:use-module (guix build-system gnu)
  #:use-module (guix licenses)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages guile))

(define cdata-sha256-base32-map
  '(("99.9.9" . "marker - do not delete")
    ("0.0.0" . "marker - do not delete")))

(define cdata-base
  (package
   (name "cdata-base")
   (version "1.0.8")
   (source 
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/mwette/guile-cdata/")
           (commit (string-append "v" version))))
     (file-name (string-append "cdata-" version))
     (sha256 (base32 (assoc-ref cdata-sha256-base32-map version)))))
   (build-system gnu-build-system)
   (arguments '(#:strip-binaries? #f #:parallel-build? #f))
   (native-inputs (list guile-3.0))
   (home-page "https://github.com/mwette/guile-cdata")
   (synopsis "procedures for handling C data types in Guile")
   (license lgpl3+)
   (description
    "The cdata package for Guile provides a wayt to work with data originating
from C libraries.  It handles base, struct, union, array, pointer, enum
and function types.  The underlying bits of data are stored in Scheme
bytevectors.")))

(define-public cdata-next
  (package
   (inherit cdata-base)
   (name "cdata-next")
   (version (caadr cdata-sha256-base32-map))
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/mwette/nyacc/")
           (commit (string-append "v" version))))
     (file-name (string-append "cdata-" version))
     (sha256 (base32 (assoc-ref cdata-sha256-base32-map version)))))))

;; -- development versions

(define cdata-dev-sha256-base32-map
  '(("99.9.9" . "marker - do not delete")
    ("0.0.0" . "marker - do not delete")))

(define-public cdata-dev
  (package
   (inherit cdata-base)
   (name "cdata-dev")
   (version "1.1.0")
   (source 
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/mwette/guile-cdata")
           (commit (string-append "dev-" version))))
     (file-name (string-append "cdata-dev-" version))
     (sha256 (base32 (assoc-ref cdata-dev-sha256-base32-map version)))))))

;; -- local package 

(define vcs-file?
  (or (git-predicate (dirname (current-source-directory))) (const #t)))

;not in a Git checkout
(define-public cdata-local
  (package
   (inherit cdata-base)
   (name "cdata")
   (version "local")
   (source
    (local-file ".." "cdata-local" #:recursive? #t #:select? vcs-file?))))

cdata-local
;;nyacc-next

;; --- last line ---
