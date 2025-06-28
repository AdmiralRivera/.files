;; This "home-environment" file can be passed to 'guix home reconfigure
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(use-modules (gnu home)
             (gnu packages)
             (gnu services)
             (guix gexp)
             (gnu home services shells)
	     (gnu home services desktop))

(home-environment
  ;; Below is the list of packages that will show up in your
  ;; Home profile, under ~/.guix-home/profile.
  (packages (specifications->packages (list "maim"
                                            "xclip"
                                            "xset"
                                            "xrdb"
                                            "xorriso"
                                            "qmk"
                                            "qmk-udev-rules"
                                            "qbittorrent-enhanced"
                                            "network-manager"
                                            "man-pages"
                                            "man-pages-posix"
                                            "python-pywal"
                                            "lukesmithxyz-st"
                                            "qutebrowser"
                                            "neovim-packer"
                                            "vim-guix-vim"
                                            "vim-fugitive"
                                            "vim-paredit"
                                            "mpv"
                                            "rsync"
                                            "curl"
                                            "sx"
                                            "elogind"
                                            "xpdf"
                                            "unzip"
                                            "zip"
                                            "ncurses"
                                            "util-linux"
                                            "xorg-server"
                                            "xinitrc-xsession"
                                            "fontconfig"
                                            "pkg-config"
                                            "git"
                                            "harfbuzz"
                                            "xsetroot"
                                            "imlib2"
                                            "dash"
                                            "rofi"
                                            "fastfetch"
                                            "nicotine+"
                                            "neovim"
                                            "alsa-utils"
                                            "brightnessctl"
                                            "acpi"
                                            "htop"
                                            "mcron"
                                            "python"
                                            "dmenu"
                                            "xbindkeys"
                                            "slim"
                                            "libx11"
                                            "libxinerama"
                                            "libxft"
                                            "freetype"
                                            "gnupg"
                                            "picom"
                                            "gcc-toolchain@11"
                                            "make"
                                            "feh")))

  ;; Below is the list of Home services.  To search for available
  ;; services, run 'guix home search KEYWORD' in a terminal.
  (services
   (append (list (service home-bash-service-type
                          (home-bash-configuration
                           (aliases '(("grep" . "grep --color=auto")
                                      ("ll" . "ls -l")
                                      ("ls" . "ls -p --color=auto")))
                           (bashrc (list (local-file
                                          "/home/Talos/src/guix-config/.bashrc"
                                          "bashrc")))
                           (bash-profile (list (local-file
                                                "/home/Talos/src/guix-config/.bash_profile"
                                                "bash_profile")))))
		 (service home-redshift-service-type
			  (home-redshift-configuration
			    (daytime-temperature 6500)
			    (nighttime-temperature 4000)
			    (dawn-time "06:30")
			    (dusk-time "20:20"))))
           %base-home-services)))
