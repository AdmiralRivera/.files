
;; This is an operating system configuration generated
;; by the graphical installer.
;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.


;; Indicate which modules to import to access the variables
;; used in this configuration.
(use-modules (gnu) (gnu services xorg) (gnu services base))
(use-service-modules cups desktop networking ssh xorg)

(operating-system
  (locale "en_US.utf8")
  (timezone "America/New_York")
  (keyboard-layout (keyboard-layout "us"))
  (host-name "freebox")

  ;; The list of user accounts ('root' is implicit).
  (users (cons* (user-account
                  (name "Talos")
                  (comment "Ian Rivera")
                  (group "users")
                  (home-directory "/home/Talos")
                  (supplementary-groups '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))

  ;; Packages installed system-wide.  Users can also install packages
  ;; under their own account: use 'guix search KEYWORD' to search
  ;; for packages and 'guix install PACKAGE' to install a package.
  (packages 
   (append ;;(map specification->package 
	   ;;	'("nss-certs"))
                    %base-packages))

  ;; Below is the list of system services.  To search for available
  ;; services, run 'guix system search KEYWORD' in a terminal.
  (services
   (append (list
		 
	         (service slim-service-type
	          (slim-configuration
		      (display ":0")
		      (xorg-configuration (xorg-configuration
		       (keyboard-layout keyboard-layout)))))
                 (service openssh-service-type)
                 (service tor-service-type)
        	 (service network-manager-service-type)
		 ;;(service dhcp-client-service-type)
                 (service wpa-supplicant-service-type)
                 (service ntp-service-type)
                 (service cups-service-type))

           ;; This is the default list of services we
           ;; are appending to.
           %base-services))
  (bootloader (bootloader-configuration
                (bootloader grub-bootloader)
                (targets (list "/dev/sda"))
                (keyboard-layout keyboard-layout)))
  (swap-devices (list (swap-space
                        (target (uuid
                                 "db3d6a26-9d5e-4564-8bf8-a47e4a437acf")))))

  ;; The list of file systems that get "mounted".  The unique
  ;; file system identifiers there ("UUIDs") can be obtained
  ;; by running 'blkid' in a terminal.
  (file-systems (cons* (file-system
                         (mount-point "/")
                         (device (uuid
                         	  "331d3b3a-0a1d-4ea3-9ee8-4bbaa7c1d217"
                                  'ext4))
                         (type "ext4")) %base-file-systems)))
