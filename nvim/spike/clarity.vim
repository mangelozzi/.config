" Examples:
" echo s:c['red']['A100']
" echo s:c['bluegray']['200']
let s:c = {
            \'red'        : { 50:'#FFEBEE', 100:'#FFCDD2', 200:'#EF9A9A', 300:'#E57373', 400:'#EF5350', 500:'#F44336', 600:'#E53935', 700:'#D32F2F', 800:'#C62828', 900:'#B71C1C', 'A100':'#FF8A80', 'A200':'#FF5252', 'A400':'#FF1744', 'A700':'#D50000' },
            \'pink'       : { 50:'#FCE4EC', 100:'#F8BBD0', 200:'#F48FB1', 300:'#F06292', 400:'#EC407A', 500:'#E91E63', 600:'#D81B60', 700:'#C2185B', 800:'#AD1457', 900:'#880E4F', 'A100':'#FF80AB', 'A200':'#FF4081', 'A400':'#F50057', 'A700':'#C51162' },
            \'purple'     : { 50:'#F3E5F5', 100:'#E1BEE7', 200:'#CE93D8', 300:'#BA68C8', 400:'#AB47BC', 500:'#9C27B0', 600:'#8E24AA', 700:'#7B1FA2', 800:'#6A1B9A', 900:'#4A148C', 'A100':'#EA80FC', 'A200':'#E040FB', 'A400':'#D500F9', 'A700':'#AA00FF' },
            \'deeppurple' : { 50:'#EDE7F6', 100:'#D1C4E9', 200:'#B39DDB', 300:'#9575CD', 400:'#7E57C2', 500:'#673AB7', 600:'#5E35B1', 700:'#512DA8', 800:'#4527A0', 900:'#311B92', 'A100':'#B388FF', 'A200':'#7C4DFF', 'A400':'#651FFF', 'A700':'#6200EA' },
            \'indigo'     : { 50:'#E8EAF6', 100:'#C5CAE9', 200:'#9FA8DA', 300:'#7986CB', 400:'#5C6BC0', 500:'#3F51B5', 600:'#3949AB', 700:'#303F9F', 800:'#283593', 900:'#1A237E', 'A100':'#8C9EFF', 'A200':'#536DFE', 'A400':'#3D5AFE', 'A700':'#304FFE' },
            \'blue'       : { 50:'#E3F2FD', 100:'#BBDEFB', 200:'#90CAF9', 300:'#64B5F6', 400:'#42A5F5', 500:'#2196F3', 600:'#1E88E5', 700:'#1976D2', 800:'#1565C0', 900:'#0D47A1', 'A100':'#82B1FF', 'A200':'#448AFF', 'A400':'#2979FF', 'A700':'#2962FF' },
            \'lightblue'  : { 50:'#E1F5FE', 100:'#B3E5FC', 200:'#81D4FA', 300:'#4FC3F7', 400:'#29B6F6', 500:'#03A9F4', 600:'#039BE5', 700:'#0288D1', 800:'#0277BD', 900:'#01579B', 'A100':'#80D8FF', 'A200':'#40C4FF', 'A400':'#00B0FF', 'A700':'#0091EA' },
            \'cyan'       : { 50:'#E0F7FA', 100:'#B2EBF2', 200:'#80DEEA', 300:'#4DD0E1', 400:'#26C6DA', 500:'#00BCD4', 600:'#00ACC1', 700:'#0097A7', 800:'#00838F', 900:'#006064', 'A100':'#84FFFF', 'A200':'#18FFFF', 'A400':'#00E5FF', 'A700':'#00B8D4' },
            \'teal'       : { 50:'#E0F2F1', 100:'#B2DFDB', 200:'#80CBC4', 300:'#4DB6AC', 400:'#26A69A', 500:'#009688', 600:'#00897B', 700:'#00796B', 800:'#00695C', 900:'#004D40', 'A100':'#A7FFEB', 'A200':'#64FFDA', 'A400':'#1DE9B6', 'A700':'#00BFA5' },
            \'green'      : { 50:'#E8F5E9', 100:'#C8E6C9', 200:'#A5D6A7', 300:'#81C784', 400:'#66BB6A', 500:'#4CAF50', 600:'#43A047', 700:'#388E3C', 800:'#2E7D32', 900:'#1B5E20', 'A100':'#B9F6CA', 'A200':'#69F0AE', 'A400':'#00E676', 'A700':'#00C853' },
            \'lightgreen' : { 50:'#F1F8E9', 100:'#DCEDC8', 200:'#C5E1A5', 300:'#AED581', 400:'#9CCC65', 500:'#8BC34A', 600:'#7CB342', 700:'#689F38', 800:'#558B2F', 900:'#33691E', 'A100':'#CCFF90', 'A200':'#B2FF59', 'A400':'#76FF03', 'A700':'#64DD17' },
            \'lime'       : { 50:'#F9FBE7', 100:'#F0F4C3', 200:'#E6EE9C', 300:'#DCE775', 400:'#D4E157', 500:'#CDDC39', 600:'#C0CA33', 700:'#AFB42B', 800:'#9E9D24', 900:'#827717', 'A100':'#F4FF81', 'A200':'#EEFF41', 'A400':'#C6FF00', 'A700':'#AEEA00' },
            \'yellow'     : { 50:'#FFFDE7', 100:'#FFF9C4', 200:'#FFF59D', 300:'#FFF176', 400:'#FFEE58', 500:'#FFEB3B', 600:'#FDD835', 700:'#FBC02D', 800:'#F9A825', 900:'#F57F17', 'A100':'#FFFF8D', 'A200':'#FFFF00', 'A400':'#FFEA00', 'A700':'#FFD600' },
            \'amber'      : { 50:'#FFF8E1', 100:'#FFECB3', 200:'#FFE082', 300:'#FFD54F', 400:'#FFCA28', 500:'#FFC107', 600:'#FFB300', 700:'#FFA000', 800:'#FF8F00', 900:'#FF6F00', 'A100':'#FFE57F', 'A200':'#FFD740', 'A400':'#FFC400', 'A700':'#FFAB00' },
            \'orange'     : { 50:'#FFF3E0', 100:'#FFE0B2', 200:'#FFCC80', 300:'#FFB74D', 400:'#FFA726', 500:'#FF9800', 600:'#FB8C00', 700:'#F57C00', 800:'#EF6C00', 900:'#E65100', 'A100':'#FFD180', 'A200':'#FFAB40', 'A400':'#FF9100', 'A700':'#FF6D00' },
            \'deeporange' : { 50:'#FBE9E7', 100:'#FFCCBC', 200:'#FFAB91', 300:'#FF8A65', 400:'#FF7043', 500:'#FF5722', 600:'#F4511E', 700:'#E64A19', 800:'#D84315', 900:'#BF360C', 'A100':'#FF9E80', 'A200':'#FF6E40', 'A400':'#FF3D00', 'A700':'#DD2C00' },
            \'brown'      : { 50:'#EFEBE9', 100:'#D7CCC8', 200:'#BCAAA4', 300:'#A1887F', 400:'#8D6E63', 500:'#795548', 600:'#6D4C41', 700:'#5D4037', 800:'#4E342E', 900:'#3E2723', },
            \'gray'       : { 50:'#FAFAFA', 100:'#F5F5F5', 200:'#EEEEEE', 300:'#E0E0E0', 400:'#BDBDBD', 500:'#9E9E9E', 600:'#757575', 700:'#616161', 800:'#424242', 900:'#212121', },
            \'bluegray'   : { 50:'#ECEFF1', 100:'#CFD8DC', 200:'#B0BEC5', 300:'#90A4AE', 400:'#78909C', 500:'#607D8B', 600:'#546E7A', 700:'#455A64', 800:'#37474F', 900:'#263238', },
            \}

function! s:getColor(str)
    " e.g. GetColor("red 500") returns '#F44336'
    let name_code = split(a:str)
    if len(name_code) > 1
        let name = name_code[0]
        let code = name_code[1]
        let hex_code = s:c[name][code]
    else
        " If there is no space in the str, probably meant to use it as is.
        let hex_code = a:str
    endif
    return hex_code
endfun



function! s:HI(group, fg, ...)
    let str = 'hi ' . a:group

    " Forground
    if strlen(a:fg)
        if a:fg == 'fg'
            let str .= ' guifg=fg'
        else
            let hex_code = s:getColor(a:fg)
            let str .=  ' guifg='.hex_code
        endif
    endif

    " Background
    " a:0 stores the number of optional args passed in
    if a:0 >= 1
        let bg = a:1
        if strlen(bg)
            if bg == 'bg'
                let str .= ' guibg=bg'
            else
                let hex_code = s:getColor(bg)
                let str .= ' guibg='.hex_code
            endif
        endif
    endif

    " Font format
    if a:0 >= 2
        let style = a:2
        if strlen(style)
            let str .= ' gui=' . style
        endif
    endif
    exe str
endfun
call s:HI('Normal',         'gray 400', 'bluegray 900')
call s:HI('Normal',       'gray 400', '#000F08', 'bold')
call s:HI('NormalNC',       'gray 400', '#353A47', 'bold')
call s:HI('NormalNC',       'gray 400', '#2E0219', 'bold')
call s:HI('Normal',       'gray 400', 'bluegray 900')
call s:HI('NormalNC',       'gray 400', '#000F08', 'bold')

call s:HI('EndOfBuffer',    '', 'black', '')

" {{{1 Programming
" call s:HI('Statement',      'orange 400')       " if not local return for in then
" call s:HI('Comment',        'teal 500')
" call s:HI('Include',        'red 300')         " import in python
" call s:HI('Identifier',     'red A700')         " function, print, end
" call s:HI('Type',           'pink 500')    " {}
" call s:HI('PreProc',        'green 500')        " bold
" call s:HI('Special',        'yellow 600')         " <leader> <C-U> etc
" call s:HI('Title',          'brown 800')        " <leader> <C-U> etc
" call s:HI('Function',       'lime 500')
" call s:HI('Error',          'white', 'red 500')
" call s:HI('String',         'green 300')
" call s:HI('Operator',       'red 300')
" call s:HI('Constant',       'orange 500')       " 1 'Hello'
" call s:HI('Number',         'amber 100')
" call s:HI('Label',          'bluegray 300')
" call s:HI('Delimiter',      'amber 400')
" call s:HI('Exception',      'red 400')
" call s:HI('Conditional',    'orange 200')
" call s:HI('Structure',      'teal 200')

" {{{1 Python

call s:HI('pythonComment',      '#009000')
call s:HI('pythonIdentifier',   'red A700')         " function, print, end
call s:HI('pythonType',         'pink 500')    " {}
call s:HI('pythonPreProc',      'green 500')        " bold
call s:HI('pythonSpecial',      'yellow 600')         " <leader> <C-U> etc
call s:HI('pythonTitle',        'brown 800')        " <leader> <C-U> etc
call s:HI('pythonBuiltin',      '#FFc835')
call s:HI('pythonFunction',     '#FFEE58')
call s:HI('pythonError',        'white', 'red 500')
call s:HI('pythonQuotes',       '#9ad8AF')
call s:HI('pythonString',       '#a8df96')
call s:HI('pythonOperator',     '#fafac4')
call s:HI('pythonRepeat',       '#fafac4')
call s:HI('pythonStatement',    '#f0724C')       " if not local return for in then
call s:HI('pythonInclude',      '#CA85dF')         " import in python
call s:HI('pythonConstant',     'orange 500')       " 1 'Hello'
call s:HI('pythonNumber',       '#edc565')
call s:HI('pythonLabel',        'bluegray 300')
call s:HI('pythonDelimiter',    'amber 400')
call s:HI('pythonConditional',  '#DE6E8B')
call s:HI('pythonException',    '#E37DC3')
call s:HI('pythonExceptions',   '#ff6060')
call s:HI('pythonEscape',       '#00b000')
call s:HI('pythonAttribute',    '#ffFFFF')

call s:HI('htmlTag', 'red 800')          " <tag> angled brackets of start tag
call s:HI('htmlEndTag', 'deeporange 900')   " </tag> angeld brackets of end tag
call s:HI('htmlTagName', 'red 500')      " <TagName>
call s:HI('htmlArg', 'purple 300')      " <TagName Arg="String">

call s:HI('NormalNC', '#e4f8ff')      " <TagName Arg="String">
call s:HI('pythonInclude', '#F4E4FC')      " <TagName Arg="String">
call s:HI('pythonInclude', '#f07d2e')      " <TagName Arg="String">

" Comment
" Identifier
" Constant
" Statement
" Type
" PreProc
" Special
" Title
