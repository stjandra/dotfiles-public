;;; $DOOMDIR/email.el -*- lexical-binding: t; -*-

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Firstname Lastname"
      user-mail-address "firstname_lastname@hotmail.com")

;;;;;;;;;;
;; mu4e ;;
;;;;;;;;;;

(after! mu4e

  ;; This is set to 't' to avoid mail syncing issues when using mbsync
  (setq mu4e-change-filenames-when-moving t)

  ;; Doom "+gmail" module flag disables this.
  ;; If this is disabled, recently moved messages will disappear (out of sync).
  ;; But enabling this has some performance penalty.
  (setq mu4e-index-cleanup t)

  (set-email-account! "second gmail"
                      '(
                        (user-mail-address      . "second@gmail.com")
                        (user-full-name         . "second")
                        (mu4e-get-mail-command  . "mbsync second@gmail.com")
                        (smtpmail-smtp-server   . "smtp.gmail.com")
                        (smtpmail-smtp-service  . 465)
                        (smtpmail-stream-type   . ssl)
                        (smtpmail-smtp-user     . "second@gmail.com")
                        (mu4e-sent-folder       . "/second@gmail.com/[Gmail]/Sent Mail")
                        (mu4e-trash-folder      . "/second@gmail.com/[Gmail]/Trash")
                        (mu4e-drafts-folder     . "/second@gmail.com/[Gmail]/Drafts")
                        (mu4e-refile-folder     . "/second@gmail.com/[Gmail]/All Mail")
                        (mu4e-maildir-shortcuts
                         ("/second@gmail.com/INBOX" . ?i)
                         ("/second@gmail.com/[Gmail]/Sent Mail" . ?s)
                         ("/second@gmail.com/[Gmail]/Trash" . ?t)
                         ("/second@gmail.com/[Gmail]/Drafts" . ?d)
                         ("/second@gmail.com/[Gmail]/All Mail" . ?a)
                         )
                        )
                      nil)

  (set-email-account! "gmail"
                      '(
                        (user-mail-address      . "firsname_lastname@gmail.com")
                        (user-full-name         . "Firstname Lastname")
                        (mu4e-get-mail-command  . "mbsync firsname_lastname@gmail.com")
                        (smtpmail-smtp-server   . "smtp.gmail.com")
                        (smtpmail-smtp-service  . 465)
                        (smtpmail-stream-type   . ssl)
                        (smtpmail-smtp-user     . "firsname_lastname@gmail.com")
                        ;;(mu4e-compose-signature . "---\nFirstname Lastname")
                        ;;(mu4e-compose-signature . (get-string-from-file "~/signature.txt"))
                        (mu4e-sent-folder       . "/firsname_lastname@gmail.com/[Gmail]/Sent Mail")
                        (mu4e-trash-folder      . "/firsname_lastname@gmail.com/[Gmail]/Trash")
                        (mu4e-drafts-folder     . "/firsname_lastname@gmail.com/[Gmail]/Drafts")
                        (mu4e-refile-folder     . "/firsname_lastname@gmail.com/[Gmail]/All Mail")
                        (mu4e-maildir-shortcuts
                         ("/firsname_lastname@gmail.com/INBOX" . ?i)
                         ("/firsname_lastname@gmail.com/[Gmail]/Sent Mail" . ?s)
                         ("/firsname_lastname@gmail.com/[Gmail]/Trash" . ?t)
                         ("/firsname_lastname@gmail.com/[Gmail]/Drafts" . ?d)
                         ("/firsname_lastname@gmail.com/[Gmail]/All Mail" . ?a)
                         )
                        )
                      nil)

  (set-email-account! "hotmail"
                      '(
                        (user-mail-address      . "firstname_lastname@hotmail.com")
                        (user-full-name         . "Firstname Lastname")
                        (mu4e-get-mail-command  . "mbsync firstname_lastname@hotmail.com")
                        (smtpmail-smtp-server   . "smtp.office365.com")
                        (smtpmail-smtp-service  . 587)
                        (smtpmail-stream-type   . starttls)
                        (smtpmail-smtp-user     . "firstname_lastname@hotmail.com")
                        (mu4e-sent-folder       . "/firstname_lastname@hotmail.com/Sent")
                        (mu4e-drafts-folder     . "/firstname_lastname@hotmail.com/Drafts")
                        (mu4e-trash-folder      . "/firstname_lastname@hotmail.com/Deleted")
                        (mu4e-refile-folder     . "/firstname_lastname@hotmail.com/Archive")
                        (mu4e-maildir-shortcuts
                         ("/firstname_lastname@hotmail.com/INBOX" . ?i)
                         ("/firstname_lastname@hotmail.com/Sent" . ?s)
                         ("/firstname_lastname@hotmail.com/Deleted" . ?t)
                         ("/firstname_lastname@hotmail.com/Drafts" . ?d)
                         ("/firstname_lastname@hotmail.com/Archive" . ?a)
                         )
                        )
                      t)
  )
