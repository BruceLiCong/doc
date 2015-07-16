; AutoComplete
;--------------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

(setq ac-dwim t)
(setq ac-fuzzy-enable t)

; GDB and Make
;--------------------------------------------------------------------
(setq gud-gdb-command-name "gdb --annotate=3 -cd ~/source/")
(setq compile-command "make -C ~/gnumake/ test PLATFORM=linux_x86 CONF=debug LOG_LEVEL=0")
                                                                                                                                                    
;
; font and text
;--------------------------------------------------------------------
;(set-frame-font "Consolas")
;(set-frame-font "Monaco")
;(set-face-attribute 'default nil :height 120) ;Font size ubuntu
(set-face-attribute 'default nil :height 150) ;Font size mac
(line-number-mode 1)
;(global-linum-mode t ) ;line num in left side
(show-paren-mode t);显示括号匹配
(column-number-mode t);显示列号
(global-font-lock-mode t);语法高亮
;(global-hl-line-mode 1);highlight current line

               
;; display the full path to the current file.
(setq frame-title-format '("%b    (%f)"))
(setq icon-title-format '("Emacs: %b"))


;
; Shell-mode encoding
;--------------------------------------------------------------------
;(ansi-color-for-comint-mode-on)
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)


;
; Normal set-up
;--------------------------------------------------------------------
;; Only scroll one line when reaching end of page
(setq scroll-step 1)

(setq inhibit-startup-message t);关闭起动时闪屏
(setq visible-bell t);关闭出错时的提示声

(setq frame-title-format "%n%F/%b");在窗口的标题栏上显示文件名称
(mouse-avoidance-mode 'animate);光标靠近鼠标指针时，让鼠标指针自动让开

(setq-default make-backup-files nil);;不要生成临时文件
(setq x-select-enable-clipboard t);;允许emacs和外部其他程序的粘贴

(fset 'yes-or-no-p 'y-or-n-p);以 y/n代表 yes/no
(display-time-mode 1);显示时间，格式如下
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)

;鼠标滚轮，默认的滚动太快，这里改为3行
(defun up-slightly () (interactive) (scroll-up 1))
(defun down-slightly () (interactive) (scroll-down 1))
(global-set-key [mouse4-4] 'down-slightly)
(global-set-key [mouse-5] 'up-slightly)

;
; Cscope
;--------------------------------------------------------------------
(load-file "~/.emacs.d/xcscope.el") 
;;(load-file "/usr/share/emacs/site-lisp/xcscope.el") ;xcscope.el
;;(add-hook 'c-mode-common-hook
;;'(lambda()
;;(require 'xcscope)
;;)
;;)
(require 'xcscope)
;(cscope-setup)
;
; Ido
;--------------------------------------------------------------------
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t) ;; enable fuzzy matching


;
; Bars
;--------------------------------------------------------------------
(tool-bar-mode nil)
(set-scroll-bar-mode nil) 


;
; theme
;--------------------------------------------------------------------
;(set-cursor-color "red")
;(add-to-list 'load-path "~/.emacs.d/")
(load-file "~/.emacs.d/color-theme.el") 
(require 'color-theme)
;(color-theme-initialize) ;need in old version
(setq color-theme-is-global t)
;---use the system color theme or set up your own color them
(color-theme-midnight)
;(load-file "~/.emacs.d/themes/color-theme-tango.el")
;(color-theme-tango)

;
; tex
;--------------------------------------------------------------------
;load “auctex.el” nil t t)
;(load “preview-latex.el” nil t t)


;
; Muse
;--------------------------------------------------------------------
;(add-to-list 'load-path "/usr/share/emacs23/site-lisp/muse-el/")


;
; Key-binding
;--------------------------------------------------------------------
(global-set-key [f1] 'goto-line);设置M-g为goto-line
(global-set-key [f2] 'shell);F2 切换到shell模式
(global-set-key [f3] 'split-window-horizontally);F3分割窗口

;(setq compile-command "make -f Makefile")
(global-set-key [f4] 'gdb-many-windows);启动窗口gdb
(global-set-key [f5] 'gdb);启动gdb
(global-set-key [f7] 'compile);编译


(global-set-key [f8] 'other-window);F8窗口间跳转
(global-set-key [f9] 'delete-window);F9 关闭d当前窗口

(global-set-key [f10] 'rename-buffer)
(global-set-key [f11] 'my-fullscreen);F11 全屏
;;(global-set-key [f12] 'speedbar);打开speedbar

(global-set-key [C-return] 'kill-this-buffer);C-return关闭当前buffer
(global-set-key (kbd "C-,") 'backward-page);文件首
(global-set-key (kbd "C-.") 'forward-page);文件尾

;; Disable Ctrl-Z minimization/suspension of emacs.
(global-set-key (kbd "C-z") nil)

;; Temporary cscope key binding for 
(define-key global-map [(ctrl f)] 'cscope-find-global-definition)

; remove annoying poped-up buffer  
(defun rm-popup-buffer ()
   (interactive)
   (other-window 1)
   (kill-this-buffer)
   (other-window 1)
) 
(global-set-key (kbd "C-'") 'rm-popup-buffer)
                  
;; Wheel mouse +  Control change buffer we are looking at
(defun next-buffer () 
  "Go to the buffer which is at the end of the buffer-list. 
   This is the symmetric of burry-buffer." 
  (interactive)
  (switch-to-buffer (nth (- (length (buffer-list)) 1) (buffer-list))))

(define-key global-map [(control mouse-4)] 'next-buffer)
(define-key global-map [(control mouse-5)] 'bury-buffer)


;; Home and End selects buffer
(global-set-key [home] 'next-buffer)
(global-set-key [end]  'bury-buffer)

;; Meta-up/down to do Page Up and Page Down, as the regular Page Up and 
;; Page down does not repeat, making it tedious to scroll large documents.
(global-set-key [M-up] 'scroll-down)
(global-set-key [M-down] 'scroll-up)

;全屏
;(defun my-fullscreen ()
;  (interactive)
;  (x-send-client-message
;   nil 0 nil "_NET_WM_STATE" 32
;   '(2 "_NET_WM_STATE_FULLSCREEN" 0))
;)
 
;最大化
;(defun my-maximized ()
;(interactive)
;(x-send-client-message
;nil 0 nil "_NET_WM_STATE" 32
;'(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
;(x-send-client-message
;nil 0 nil "_NET_WM_STATE" 32
;'(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
;)

; 启动时最大化
;(my-maximized)

                                      
; Set window properties...
;--------------------------------------------------------------------
;(set-frame-height (selected-frame) 58) 
;(set-frame-position (selected-frame) 418 1) 



; 启动窗口大小
(setq default-frame-alist
      '((height . 100)(width . 180) (menu-bar-lines . 0) (tool-bar-lines . 0)));PC
      ;'((height . 34) (width . 140) (menu-bar-lines . 0) (tool-bar-lines . 0)));NB


;scroll other window
(global-set-key (kbd "C-c C-v") 'scroll-other-window)
(global-set-key (kbd "C-c C-b") 'scroll-other-window-down)


;
; Java
;--------------------------------------------------------------------
(add-hook 'java-mode-hook (function cscope:hook))


;
; C/C++
;--------------------------------------------------------------------
(setq c-default-style "BSD")
(setq c-basic-offset 8)
(setq c-tab-width 8)
(setq c-indent-level 8)


;shell,gdb退出后，自动关闭该buffer
(add-hook 'shell-mode-hook 'mode-hook-func)
(add-hook 'gdb-mode-hook 'mode-hook-func)
(defun mode-hook-func  ()
  (set-process-sentinel (get-buffer-process (current-buffer))
         #'kill-buffer-on-exit))
(defun kill-buffer-on-exit (process state)
  (message "%s" state)
  (if (or
       (string-match "exited abnormally with code.*" state)
       (string-match "finished" state))
      (kill-buffer (current-buffer))))


;
; Completion apps and funcs
;--------------------------------------------------------------------
;; Define a -hook for all modes where we want tab completion.
(add-hook 'c-mode-common-hook
          (function (lambda ()
                    (local-set-key (kbd "") 'indent-or-complete)
                     )))

(defun indent-or-complete ()
  "Complete if point is at end of a word, otherwise indent line."
  (interactive)
  (if (looking-at "\\>")
    (dabbrev-expand nil)
  (indent-for-tab-command)
   ))

;; The order that different completes are tested.
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev-visible
	try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        ; try-expand-all-abbrevs
        ; try-expand-line 
        ; try-expand-line-all-buffers
        ; try-expand-whole-kill
        ; try-expand-list
        ; try-expand-list-all-buffers
        ; try-complete-file-name-partially
        ; try-complete-file-name 
        ; try-complete-lisp-symbol-partially
        ; try-complete-lisp-symbol 
	))

;; TAB expands even during isearch (Ctrl-S)
(define-key isearch-mode-map [tab] 'isearch-yank-word)



;;;; PLATFORM DEPENDENT
