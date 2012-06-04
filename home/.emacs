;;;;;;;;;;;;;;;;;;;;;;;;;;; Linux环境下字体设置开始 ;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq current-language-environment "UTF-8")
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-default-font "DejaVu Sans Mono-12")
(set-fontset-font (frame-parameter nil 'font)
				  'han '("WenQuanYi Micro Hei" . "unicode-bmp"))

;;;;;;;;;;;;;;;;;;;;;;;;;;; Linux环境下字体设置结束 ;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;  设置窗口界面开始 ;;;;;;;;;;;;;;;;;;;;;;;;;;;

(set-foreground-color "grey")
(set-background-color "black")
(set-cursor-color "gold1")
(set-mouse-color "gold1")

(set-scroll-bar-mode nil);取消滚动栏

;;(customize-set-variable 'scroll-bar-mode 'right));设置滚动栏在窗口右侧，而默认是在左侧

(tool-bar-mode nil);取消工具栏
(menu-bar-mode nil);关闭菜单

;; 启动时窗口最大化
;(when window-system
;  (my-maximized))

;; 启动窗口大小
(when window-system
  (setq default-frame-alist
		'((height . 42) (width . 120) (menu-bar-lines . 20) (tool-bar-lines . 0))))

;; 设置另外一些颜色：语法高亮显示的背景和主题，区域选择的背景和主题，二次选择的背景和选择
(set-face-foreground 'highlight "white")
(set-face-background 'highlight "blue")
(set-face-foreground 'region "cyan")
(set-face-background 'region "blue")
(set-face-foreground 'secondary-selection "skyblue")
(set-face-background 'secondary-selection "darkblue")

(setq frame-title-format "^_^ @%b");在标题栏提示你目前在什么位置

;; 显示时间，格式如下
(display-time-mode 1)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)

;;全屏
(defun my-fullscreen ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_FULLSCREEN" 0)))

;最大化
(defun my-maximized ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;  设置界面结束  ;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;  emacs功能设置开始  ;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq-default make-backup-files nil);不产生临时文件
(setq inhibit-startup-message t);关闭起动时闪屏
(setq visible-bell nil);关闭出错时的提示声
(setq make-backup-files nil);不产生备份文件
(setq default-major-mode 'text-mode);打开就启用text模式。
(global-font-lock-mode t);语法高亮
;(auto-image-file-mode t);打开图片显示功能
(fset 'yes-or-no-p 'y-or-n-p);y/n means yes/no
(global-linum-mode t);显示行号
(column-number-mode t);显示列号
(show-paren-mode t);显示括号匹配
(setq default-tab-width 4);每次缩进4个空格

;(pc-selection-mode);shift选择
;(mouse-avoidance-mode 'animate);光标靠近鼠标指针时，让鼠标指针自动让开
(setq mouse-yank-at-point t);支持中键粘贴
;(transient-mark-mode t);允许临时设置标记
(setq x-select-enable-clipboard t);支持emacs和外部程序的粘贴
;(setq default-fill-column 120);默认显示120列就换行
(setq suggest-key-bindings t);若命令有组合键，则提示该组合键
;(set-selection-coding-system 'iso-2022-8bit-ss2-dos);网页复制乱码问题

;; 格式化
(dolist (command '(yank yank-pop))
  (eval
   `(defadvice ,command (after indent-region activate)
      (and (not current-prefix-arg)
           (member major-mode
                   '(emacs-lisp-mode
                     lisp-mode
                     clojure-mode
                     scheme-mode
                     haskell-mode
                     ruby-mode
                     rspec-mode
                     python-mode
                     c-mode
                     c++-mode
                     objc-mode
                     latex-mode
                     js-mode
                     plain-tex-mode))
           (let ((mark-even-if-inactive transient-mark-mode))
             (indent-region (region-beginning) (region-end) nil))))))

;; shell,gdb退出后，自动关闭该buffer  
(defun kill-buffer-when-shell-command-exit ()
  "Close current buffer when `shell-command' exit."
  (let ((process (ignore-errors (get-buffer-process (current-buffer)))))
    (when process
      (set-process-sentinel process
                            (lambda (proc change)
                              (when (string-match "\\(finished\\|exited\\)" change)
                                (kill-buffer (process-buffer proc))))))))
  
(add-hook 'gdb-mode-hook 'kill-buffer-when-shell-command-exit);退出gdb时关闭gdb对应的buffer
(add-hook 'term-mode-hook 'kill-buffer-when-shell-command-exit);退出ter时关闭term对应的buffer

;; 编译成功后自动关闭*compilation* 函数
(defun kill-buffer-when-compile-success (process)
  "Close current buffer when `shell-command' exit."
  (set-process-sentinel process
                        (lambda (proc change)
                          (when (string-match "finished" change)
                            (delete-windows-on (process-buffer proc))))))
  
(add-hook 'compilation-start-hook 'kill-buffer-when-compile-success);编译成功后自动关闭*compilation* buffer

;;;;;;;;;;;;;;;;;;;;;;;;;;;  emacs功能设置结束  ;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;  快捷键配置开始  ;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key (kbd "C-SPC") 'nil);注销ctrl_space组合健，已启用输入法

(global-set-key [f2] 'shell);F2进入Shell
(global-set-key [f5] 'gdb);F5调试程序
(setq compile-command "make -f Makefile")
(global-set-key [f7] 'do-compile);F7编译文件
(global-set-key [f8] 'other-window);F8窗口间跳转
(global-set-key [C-return] 'kill-this-buffer);C-return关闭当前buffer
(global-set-key [f10] 'split-window-vertically);F10分割buffer
(global-set-key [f12] 'delete-other-windows);F11 关闭其他buffer
(global-set-key [f12] 'my-fullscreen);F12 全屏

;; 鼠标滚轮缩放字体大小
(global-set-key (kbd "<C-mouse-4>") 'text-scale-increase)
(global-set-key (kbd "<C-mouse-5>") 'text-scale-decrease)

;;;;;;;;;;;;;;;;;;;;;;;;;;;  快捷键配置结束  ;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;; 各类mode使用开始 ;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; mode加载路径
(add-to-list 'load-path "~/emacs.d/elisp")

;; php mode
(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))

;; lua mode
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(setq auto-mode-alist (cons '("\.lua$" . lua-mode) auto-mode-alist))

;; cmake mode
(setq load-path (cons (expand-file-name "/opt/emacs_plugins") load-path))
(require 'cmake-mode)
(setq auto-mode-alist
      (append '(("CMakeLists\\.txt\\'" . cmake-mode)
                ("\\.cmake\\'" . cmake-mode))
              auto-mode-alist))

;; 中文日历
(setq calendar-chinese-all-holidays-flag t)
(setq calendar-mark-holidays-flag t)
;设置日历表的中文天干地支，在日期上按 `p C' 就可以显示农历和干支。
(setq chinese-calendar-celestial-stem
["甲" "乙" "丙" "丁" "戊" "已" "庚" "辛" "壬" "癸"])
(setq chinese-calendar-terrestrial-branch
["子" "丑" "寅" "卯" "辰" "巳" "午" "未" "申" "酉" "戌" "亥"])

(setq calendar-latitude 31.22)
(setq calendar-longitude 121.48)
(setq calendar-location-name "Shanghai")

;;;;;;;;;;;;;;;;;;;;;;;;;;; 各类mode使用结束 ;;;;;;;;;;;;;;;;;;;;;;;;;;;

