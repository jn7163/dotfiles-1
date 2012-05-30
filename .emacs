;;;;;;;;;;;;;;;;;;;;;;;;;;; Linux环境下字体设置 ;;;;;;;;;;;;;;;;;;;;;;;;;;;

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


;;;;;;;;;;;;;;;;;;;;;;;;;;;  设置窗口界面 ;;;;;;;;;;;;;;;;;;;;;;;;;;;

(set-foreground-color "grey")
(set-background-color "black")
(set-cursor-color "gold1")
(set-mouse-color "gold1")

(set-scroll-bar-mode nil)
;;取消滚动栏

;;(customize-set-variable 'scroll-bar-mode 'right))
;;设置滚动栏在窗口右侧，而默认是在左侧

(tool-bar-mode nil)
;;取消工具栏

(setq default-frame-alist
	'((height . 42) (width . 120) (menu-bar-lines . 20) (tool-bar-lines . 0))) 
               
;; 设置另外一些颜色：语法高亮显示的背景和主题，区域选择的背景和主题，二次选择的背景和选择
(set-face-foreground 'highlight "white")
(set-face-background 'highlight "blue")
(set-face-foreground 'region "cyan")
(set-face-background 'region "blue")
(set-face-foreground 'secondary-selection "skyblue")
(set-face-background 'secondary-selection "darkblue")

;在标题栏提示你目前在什么位置
(setq frame-title-format "^_^ @%b")

(display-time-mode 1);显示时间，格式如下
	(setq display-time-24hr-format t)
	(setq display-time-day-and-date t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;  设置界面结束  ;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;  emacs功能设置  ;;;;;;;;;;;;;;;;;;;;;;;;;;;
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


;(pc-selection-mode);shift选择
;(mouse-avoidance-mode 'animate);光标靠近鼠标指针时，让鼠标指针自动让开
(setq mouse-yank-at-point t);支持中键粘贴
;(transient-mark-mode t);允许临时设置标记
(setq x-select-enable-clipboard t);支持emacs和外部程序的粘贴
;(setq default-fill-column 120);默认显示120列就换行
(setq suggest-key-bindings t);若命令有组合键，则提示该组合键
;(set-selection-coding-system 'iso-2022-8bit-ss2-dos);网页复制乱码问题

;;;;;;;;;;;;;;;;;;;;;;;;;;;  emacs功能设置结束  ;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;  快捷键配置  ;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key (kbd "C-SPC") 'nil);注销ctrl_space组合健，已启用输入法

(global-set-key [f2] 'shell);F2进入Shell
(global-set-key [f5] 'gdb);F5调试程序
(setq compile-command "make -f Makefile")
(global-set-key [f7] 'do-compile);F7编译文件
(global-set-key [f8] 'other-window);F8窗口间跳转
(global-set-key [C-return] 'kill-this-buffer);C-return关闭当前buffer
(global-set-key [f11] 'split-window-vertically);F11分割窗口
(global-set-key [f12] 'delete-other-windows);F12 关闭其它窗口

;;;;;;;;;;;;;;;;;;;;;;;;;;;  快捷键配置结束  ;;;;;;;;;;;;;;;;;;;;;;;;;;;


;(require 'php-mode)
;(add-hook 'php-mode-user-hook 'turn-on-font-lock)

; PKGBUILD
;(autoload 'pkgbuild-mode "pkgbuild-mode.el" "PKGBUILD mode." t)
;(setq auto-mode-alist (append '(("/PKGBUILD$" . pkgbuild-mode)) auto-mode-alist)

;lua
;(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
;(setq auto-mode-alist (cons '("\.lua$" . lua-mode) auto-mode-alist))
