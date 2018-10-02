;;; faker --- Genuine files to be fake, fake files to be genuine

;; Copyright (C) 2018- blue0513

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA

;; Author: blue0513
;; URL: https://github.com/blue0513
;; Version: 0.0.1

;; Load this script and set a directory to save fake files.
;;
;;   (require 'faker)
;;   (setq faker-directory "/Users/blue0513/.faker/")
;;

;;; Code:

(defgroup faker nil
  "fake to genuine, genuine to fake"
  :group 'emacs)

(defcustom faker-directory "/path/to/save/dir/"
  "directory used to store fake files"
  :group 'faker)

(define-minor-mode faker-minor-mode
  "minor mode for faker"
  :init-value nil
  :global nil
  :lighter " Faker")

(defun faker--fake-file-name (name)
  "get the fake file path for this buffer"
  (concat faker-directory
	  (replace-regexp-in-string "[/:]" "!" name)))

(defun faker--genuine-file-name (name)
  "get the genuine file path for this buffer"
  (replace-regexp-in-string
   "[!:]" "/"
   (string-remove-prefix faker-directory name)))

(defun genuine-to-fake()
  (interactive)
  (let* ((old-file-path (buffer-file-name))
	 (new-file-path (faker--fake-file-name buffer-file-name)))
    (write-file new-file-path t)
    (rename-buffer "*Fake*")
    (faker-minor-mode 1)))

(defun find-fake()
  (interactive)
  (let* ((maybe-fake-file-path (faker--fake-file-name buffer-file-name)))
    (when (file-exists-p maybe-fake-file-path)
      (find-file maybe-fake-file-path)
      (rename-buffer "*Fake*")
      (faker-minor-mode 1)
      (message "Found fake file!")
      (sit-for 0.5))))

(defun find-genuine()
  (interactive)
  (let* ((maybe-genuine-file-path (faker--genuine-file-name buffer-file-name)))
    (when (file-exists-p maybe-genuine-file-path)
      (find-file maybe-genuine-file-path)
      (message "Found genuine file!")
      (faker-minor-mode 0)
      (sit-for 0.5))))

(defun fake-to-genuine()
  (interactive)
  (let* ((current-file-path (buffer-file-name))
	 (genuine-file-path (faker--genuine-file-name current-file-path)))
    (write-file genuine-file-path t)
    (faker-minor-mode 0)
    (delete-file current-file-path)))

;; * provide

(provide 'faker)

;;; faker.el ends here
