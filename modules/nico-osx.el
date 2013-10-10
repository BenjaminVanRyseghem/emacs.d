(defvar nico/messages-default-away-message "Pomodoro"
  "Default status message when away")

(defvar nico/messages-default-available-message "Available"
  "Default status message when available")


(defun nico/messages-set-status-away (&optional message)
  (interactive "sMessage: ")
  (let ((message (or message nico/messages-default-away-message)))
    (setq nico/messages-last-status
	  (do-applescript 
	   (concat 
	    "tell application \"Messages\"\n"
	    "set status to away\n"
	    "set status message to \"" message "\"\n"
	    "end tell\n")))))

(defun nico/messages-set-status-available (&optional message)
  (interactive "sMessage: ")
  (let ((message (or message nico/messages-default-available-message)))
    (do-applescript 
     (concat
      "tell application \"Messages\"\n"
      "set status to available\n"
      "set status message to \"" message "\"\n"
      "end tell"))))

(defun nico/messages-set-pomodoro-status ()
  (let* ((end-time (time-add
		    (current-time)
		    (seconds-to-time (* 60 org-pomodoro-length))))
	 (end-time-string (format-time-string "%H:%M" end-time)))
    (nico/messages-set-status-away
     (concat
      "Pomodoro until "
      end-time-string))))


(defun nico/notification-center-disable ()
  (interactive)
  (shell-command "launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist"))

(defun nico/notification-center-enable ()
  (interactive)
  (shell-command "launchctl load -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist"))

(defun nico/notify (message)
  (shell-command (concat "terminal-notifier -title Emacs -message '" message "'")))

(defun nico/notify-pomodoro-started ()
  (nico/notify "Pomodoro started"))

(defun nico/notify-pomodoro-break ()
  (nico/notify "Pomodoro break"))


(provide 'nico-osx)
