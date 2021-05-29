;;; $DOOMDIR/email.el -*- lexical-binding: t; -*-

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Fistname Lastname"
      user-mail-address "user@gmail.com")

;;;;;;;;;;
;; mu4e ;;
;;;;;;;;;;

(after! mu4e

  ;; This is set to 't' to avoid mail syncing issues when using mbsync
  (setq mu4e-change-filenames-when-moving t)

  ;; Doom "+gmail" module flag disables this.
  ;; If this is disabled, recently moved messages will dissapear (out of sync).
  ;; But enabling this has some performance penalty.
  (setq mu4e-index-cleanup t)

  (set-email-account! "gmail"
                      '(
                        (user-mail-address      . "user@gmail.com")
                        (user-full-name         . "Firstname Lastname")
                        (mu4e-get-mail-command  . "mbsync gmail")
                        (smtpmail-smtp-server   . "smtp.gmail.com")
                        (smtpmail-smtp-service  . 465)
                        (smtpmail-stream-type   . ssl)
                        (smtpmail-smtp-user     . "user@gmail.com")
                        ;;(mu4e-compose-signature . "---\nFirstname Lastname")
                        ;;(mu4e-compose-signature . (get-string-from-file "~/signature.txt"))
                        (mu4e-sent-folder       . "/gmail/[Gmail]/Sent Mail")
                        (mu4e-trash-folder      . "/gmail/[Gmail]/Trash")
                        (mu4e-drafts-folder     . "/gmail/[Gmail]/Drafts")
                        (mu4e-refile-folder     . "/gmail/[Gmail]/All Mail")
                        (mu4e-maildir-shortcuts
                         ("/gmail/INBOX" . ?i)
                         ("/gmail/[Gmail]/Sent Mail" . ?s)
                         ("/gmail/[Gmail]/Trash" . ?t)
                         ("/gmail/[Gmail]/Drafts" . ?d)
                         ("/gmail/[Gmail]/All Mail" . ?a)
                         )
                        )
                      nil)

  (set-email-account! "user2 gmail"
                      '(
                        (user-mail-address      . "user2@gmail.com")
                        (user-full-name         . "Firstname Lastname")
                        (mu4e-get-mail-command  . "mbsync gmail-user2")
                        (smtpmail-smtp-server   . "smtp.gmail.com")
                        (smtpmail-smtp-service  . 465)
                        (smtpmail-stream-type   . ssl)
                        (smtpmail-smtp-user     . "user2@gmail.com")
                        (mu4e-sent-folder       . "/gmail-user2/[Gmail]/Sent Mail")
                        (mu4e-trash-folder      . "/gmail-user2/[Gmail]/Trash")
                        (mu4e-drafts-folder     . "/gmail-user2/[Gmail]/Drafts")
                        (mu4e-refile-folder     . "/gmail-user2/[Gmail]/All Mail")
                        (mu4e-maildir-shortcuts
                         ("/gmail-user2/INBOX" . ?i)
                         ("/gmail-user2/[Gmail]/Sent Mail" . ?s)
                         ("/gmail-user2/[Gmail]/Trash" . ?t)
                         ("/gmail-user2/[Gmail]/Drafts" . ?d)
                         ("/gmail-user2/[Gmail]/All Mail" . ?a)
                         )
                        )
                      nil)

  (set-email-account! "hotmail"
                      '(
                        (user-mail-address      . "user@hotmail.com")
                        (user-full-name         . "Firstname Lastname")
                        (mu4e-get-mail-command  . "mbsync hotmail")
                        (smtpmail-smtp-server   . "smtp.office365.com")
                        (smtpmail-smtp-service  . 587)
                        (smtpmail-stream-type   . starttls)
                        (smtpmail-smtp-user     . "user@hotmail.com")
                        (mu4e-sent-folder       . "/hotmail/Sent")
                        (mu4e-drafts-folder     . "/hotmail/Drafts")
                        (mu4e-trash-folder      . "/hotmail/Deleted")
                        (mu4e-refile-folder     . "/hotmail/Archive")
                        (mu4e-maildir-shortcuts
                         ("/hotmail/INBOX" . ?i)
                         ("/hotmail/Sent" . ?s)
                         ("/hotmail/Deleted" . ?t)
                         ("/hotmail/Drafts" . ?d)
                         ("/hotmail/Archive" . ?a)
                         ("/hotmail/1" . ?1)
                         )
                        )
                      t)
  )
