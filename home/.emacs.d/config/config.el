;;;;;;;;;;;;;;;;;;;;;;;;;;;  emacs功能设置开始  ;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 格式化
(dolist (command '(yank yank-pop))
	(eval
		`(defadvice ,command (after indent-region activate)
								(and (not current-prefix-arg)
										 (member major-mode
														 '(emacs-lisp-mode
																1
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
;(setq load-path (cons (expand-file-name "/opt/emacs_plugins") load-path))
;(require 'cmake-mode)
;(setq auto-mode-alist
;      (append '(("CMakeLists\\.txt\\'" . cmake-mode)
;                ("\\.cmake\\'" . cmake-mode))
;              auto-mode-alist))

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

 
