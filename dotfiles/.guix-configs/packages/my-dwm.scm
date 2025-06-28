;;; GNU Guix --- Functional package management for GNU
;;; Copyright © 2013 Cyril Roelandt <tipecaml@gmail.com>
;;; Copyright © 2015 Amirouche Boubekki <amirouche@hypermove.net>
;;; Copyright © 2016 Al McElrath <hello@yrns.org>
;;; Copyright © 2016, 2017 Nikita <nikita@n0.is>
;;; Copyright © 2015 Dmitry Bogatov <KAction@gnu.org>
;;; Copyright © 2015, 2023 Leo Famulari <leo@famulari.name>
;;; Copyright © 2016 Eric Bavier <bavier@member.fsf.org>
;;; Copyright © 2017 Alex Griffin <a@ajgrf.com>
;;; Copyright © 2018–2021 Tobias Geerinckx-Rice <me@tobias.gr>
;;; Copyright © 2021 Raghav Gururajan <rg@raghavgururajan.name>
;;; Copyright © 2021 Alexandru-Sergiu Marton <brown121407@posteo.ro>
;;; Copyright © 2021 Nikolay Korotkiy <sikmir@disroot.org>
;;; Copyright © 2022 Jai Vetrivelan <jaivetrivelan@gmail.com>
;;; Copyright © 2022 jgart <jgart@dismail.de>
;;; Copyright © 2022 Antero Mejr <antero@mailbox.org>
;;; Copyright © 2022 Ivan Vilata i Balaguer <ivan@selidor.net>
;;; Copyright © 2024 Clément Lassieur <clement@lassieur.org>
;;; Copyright © 2024 Zheng Junjie <873216071@qq.com>
;;; Copyright © 2024 cage <cage-dev@twistfold.it>
;;;
;;; This file is part of GNU Guix.
;;;
;;; GNU Guix is free software; you can redistribute it and/or modify it
;;; under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 3 of the License, or (at
;;; your option) any later version.
;;;
;;; GNU Guix is distributed in the hope that it will be useful, but
;;; WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with GNU Guix.  If not, see <http://www.gnu.org/licenses/>.

(define-module (gnu package my-suckless)
  #:use-module (gnu packages)
  #:use-module (gnu packages base)
  #:use-module (gnu packages crates-io)
  #:use-module (gnu packages crypto)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages cups)
  #:use-module (gnu packages fonts)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages gawk)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages image)
  #:use-module (gnu packages imagemagick)
  #:use-module (gnu packages libbsd)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages mpd)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages shells)
  #:use-module (gnu packages webkit)
  #:use-module (gnu packages xorg)
  #:use-module (guix build-system cargo)
  #:use-module (guix build-system glib-or-gtk)
  #:use-module (guix build-system gnu)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix utils)
  #:use-module (guix packages))

(define-public my-dwm
 (let ((commit "690e6c4ef40cec645d9d3f23ba319b7b0a9d79d8")
	(revision "0"))
  (package
    (name "my-dwm")
    (version (git-version "1.0.1" revision commit))
    (source (origin
	      (method git-fetch)
	      (uri (git-reference
		     (url "https://github.com/AdmiralRivera/my-dwm")
		     (commit commit)))
	      (file-name (git-file-name name version))
	      (sha256	
		(base32 "06mzkaz43s7v6vk6px0c33wa8rc5gsirkaxjcrikwyy0fhs91y54"))))
    (build-system gnu-build-system)
    (arguments
     `(#:tests? #f
       #:make-flags (list (string-append "FREETYPEINC="
                                         (assoc-ref %build-inputs "freetype")
                                         "/include/freetype2"))
       #:phases
       (modify-phases %standard-phases
         (replace 'configure
           (lambda _
             (substitute* "Makefile" (("\\$\\{CC\\}") "gcc"))
             #t))
	 (replace 'install
          (lambda* (#:key outputs #:allow-other-keys)
            (let ((out (assoc-ref outputs "out")))
              (invoke "make" "install"
                      (string-append "DESTDIR=" out) "PREFIX="))))
        (add-after 'build 'install-xsession
          (lambda* (#:key outputs #:allow-other-keys)
            ;; Add a .desktop file to xsessions.
            (let* ((output (assoc-ref outputs "out"))
                   (xsessions (string-append output "/share/xsessions")))
              (mkdir-p xsessions)
              (with-output-to-file
                  (string-append xsessions "/chadmanwm.desktop")
                (lambda _
                  (format #t
                    "[Desktop Entry]
                     Name=chadmanwm
                     Comment=Dynamic Window Manager
                     Exec=/home/Talos/.config/chadmanwm/scripts/run.sh
                     TryExec=/home/Talos/.config/chadmanwm/scripts/run.sh
                     Type=Application"
                    output)))
              #t))))))
    (inputs
     (list freetype libx11 libxft libxinerama imlib2))
    (home-page "https://dwm.suckless.org/")
    (synopsis "Dynamic window manager")
    (description
     "dwm is a dynamic window manager for X.  It manages windows in tiled,
monocle and floating layouts.  All of the layouts can be applied dynamically,
optimising the environment for the application in use and the task performed.") (license license:x11))))

my-dwm
