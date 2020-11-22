if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

"左側に使用されるセパレータ
let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
"右側に使用されるセパレータ
let g:airline_right_sep = "\ue0b2"
let g:airline_right_alt_sep = "\ue0b3"
"let g:airline_symbols.crypt = '🔒'		"暗号化されたファイル
let g:airline_symbols.crypt = "\ue0a2"		"暗号化されたファイル
"let g:airline_symbols.linenr = '¶'			"行
let g:airline_symbols.linenr = ''			"行
"let g:airline_symbols.maxlinenr = '㏑'		"最大行
let g:airline_symbols.maxlinenr = "\u0a1"		"最大行
"let g:airline_symbols.branch = '⭠'		"gitブランチ
let g:airline_symbols.branch = "\ue0a0"		"gitブランチ
let g:airline_symbols.paste = 'ρ'			"ペーストモード
let g:airline_symbols.spell = 'Ꞩ'			"スペルチェック
let g:airline_symbols.notexists = '∄'		"gitで管理されていない場合
let g:airline_symbols.whitespace = 'Ξ'	"空白の警告(余分な空白など)
