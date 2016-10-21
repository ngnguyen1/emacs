;;; my-modeline.el --- Customized my mode line 
;; 
;; Filename: my-modeline.el
;; Description: 
;; Author: Duy Nga Nguyen
;; Maintainer: 
;; Created: Thu Oct 20 10:29:35 2016 (+0700)
;; Version: 
;; Package-Requires: ()
;; Last-Updated: 
;;           By: 
;;     Update #: 0
;; URL: 
;; Doc URL: 
;; Keywords: 
;; Compatibility: 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Commentary: 
;; 
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Change Log:
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or (at
;; your option) any later version.
;; 
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;; 
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Code:


(setq-default
  mode-line-format
  '(
     ;; Sticked mode line
     (:eval
       (let* ((window (get-buffer-window (current-buffer)))
               (sticky? (window-dedicated-p window)))
         (cond (sticky?
                 (propertize "  ⚡" 'face 'mode-line-sticky-face))
           (t ""))))
     ;; Position, including warning for 78 columns
     (:propertize "%4l :" face mode-line-position-face)
     (:eval (propertize "%3c " 'face
              (if (> (current-column) 78)
                'mode-line-78col-face
                'mode-line-position-face)))
     ;; emacsclient [default -- keep?]
     mode-line-client
     "  "
     ;; read-only or modified status
     (:eval
       (cond (buffer-read-only
               (propertize " RO " 'face 'mode-line-read-only-face))
         ((buffer-modified-p)
           (propertize " ** " 'face 'mode-line-modified-face))
         (t "      ")))
     "    "
     ;; directory and buffer/file name
     (:propertize (:eval (shorten-directory default-directory 30))
       face mode-line-folder-face)
     (:propertize "%b"
       face mode-line-filename-face)
     ;; narrow [default -- keep?]
     " %n "
     ;; mode indicators: vc, recursive edit, major mode, minor modes, process, global
     (vc-mode vc-mode)
     "  %["
     (:propertize mode-name
       face mode-line-mode-face)
     "%] "
     (:eval (propertize (format-mode-line minor-mode-alist)
              'face 'mode-line-minor-mode-face))
     (:propertize mode-line-process
       face mode-line-process-face)
     (global-mode-string global-mode-string)
     "    "
     ;; nyan-mode uses nyan cat as an alternative to %p
     ;; (:eval (when nyan-mode (list (nyan-create))))
     ))


(provide 'e:my-modeline)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; my-modeline.el ends here