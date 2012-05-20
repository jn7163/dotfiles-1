(setq current-language-environment "UTF-8")
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-default-font "DejaVu Sans-10")
(set-fontset-font (frame-parameter nil 'font)
	'han '("WenQuanYi Micro Hei" . "unicode-bmp"))
(setq-default make-backup-files nil);不产生临时文件
(setq inhibit-startup-message t);关闭起动时闪屏
(setq visible-bell nil);关闭出错时的提示声
(setq make-backup-files nil);不产生备份文件
(setq default-major-mode 'text-mode);打开就启用text模式。
(global-font-lock-mode t);语法高亮
(global-set-key (kbd "C-SPC") 'nil);注销ctrl_space组合健，已启用输入法
;(auto-image-file-mode t);打开图片显示功能
(fset 'yes-or-no-p 'y-or-n-p);y/n means yes/no
(global-linum-mode t);显示行号
(column-number-mode t);显示列号
(show-paren-mode t);显示括号匹配
(display-time-mode 1);显示时间，格式如下
	(setq display-time-24hr-format t)
	(setq display-time-day-and-date t)
(tool-bar-mode nil);去掉那个大大的工具栏
(scroll-bar-mode nil);去掉滚动条
;(pc-selection-mode);shift选择
;(mouse-avoidance-mode 'animate);光标靠近鼠标指针时，让鼠标指针自动让开
(setq mouse-yank-at-point t);支持中键粘贴
;(transient-mark-mode t);允许临时设置标记
(setq x-select-enable-clipboard t);支持emacs和外部程序的粘贴
(setq frame-title-format "^_^ @%b");在标题栏提示你目前在什么位置
;(setq default-fill-column 80);默认显示80列就换行
(setq suggest-key-bindings t);若命令有组合键，则提示该组合键
;(set-selection-coding-system 'iso-2022-8bit-ss2-dos);网页复制乱码问题

;(global-set-key [f2] 'shell);F1进入Shell
;(global-set-key [f5] 'gdb);F5调试程序
;(setq compile-command "make -f Makefile")
;(global-set-key [f7] 'do-compile);F7编译文件
;(global-set-key [f8] 'other-window);F8窗口间跳转
;(global-set-key [C-return] 'kill-this-buffer);C-return关闭当前buffer
;(global-set-key [f11] 'split-window-vertically);F11分割窗口
;(global-set-key [f12] 'delete-other-windows);F12 关闭其它窗口

;(require 'php-mode)
;(add-hook 'php-mode-user-hook 'turn-on-font-lock)
