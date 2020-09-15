" {{{1 THEME SETTINGS
if !has("gui_running") && &t_Co != 88 && &t_Co != 256
    finish
endif

hi clear TODO enable when done
if exists("syntax_on")
    syntax reset
endif

let g:colors_name = "capesky"
set background=dark
set t_Co=256

let s:TERM_COLOURS = ['black', 'blue', 'brown', 'cyan', 'darkblue', 'darkcyan', 'darkgray', 'darkgreen', 'darkgrey', 'darkmagenta', 'darkred', 'darkyellow', 'gray', 'green', 'grey', 'lightblue', 'lightcyan', 'lightgray', 'lightgreen', 'lightgrey', 'lightmagenta', 'lightred', 'lightyellow', 'magenta', 'red', 'white', 'yellow']
let s:c = {} " So can place the definition below the functions

set background=dark

" Examples:
" echo s:c['red']['A100']
" echo s:c['bluegray']['200']
"let s:c = {}
" \'python'     : { '':'#FFEBEE', 100:'#FFCDD2', 200:'#EF9A9A', 300:'#E57373', 400:'#EF5350', 500:'#F44336', 600:'#E53935', 700:'#D32F2F', 800:'#C62828', 900:'#B71C1C', 'A100':'#FF8A80', 'A200':'#FF5252', 'A400':'#FF1744', 'A700':'#D50000' },
" \'pink'       : { 50:'#FCE4EC', 100:'#F8BBD0', 200:'#F48FB1', 300:'#F06292', 400:'#EC407A', 500:'#E91E63', 600:'#D81B60', 700:'#C2185B', 800:'#AD1457', 900:'#880E4F', 'A100':'#FF80AB', 'A200':'#FF4081', 'A400':'#F50057', 'A700':'#C51162' },
" \}
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

function! s:getColorStr2(ground, colour)
    " ground = 'fg' or 'bg'
    " colour = '#123456' or 123 or ['#123456',123]
    echom "type: ".type(a:colour)." ".a:colour
    if type(a:colour) == v:t_string
        return ' gui'.a:ground.'='.a:colour
    elseif type(a:colour) == v:t_number
        return ' cterm='.a:colour
    elseif type(a:colour) == v:t_list
        let c = s:c[colour]
        return ' gui'.a:ground.'='.c[0].' ctermfg='.c[1]
    endif
endfun


function! s:getColorStr(ground, colour)
    " ground = 'fg' or 'bg'
    " colour = 'Red' or '#123456' or 123 or ['#123456',123]
    if (a:ground == a:colour) || (tolower(a:colour) == 'none')
        " Example: ground='fg' or 'bg'
        return ' gui'.a:ground.'='.a:ground.' cterm'.a:ground.'='.a:ground
    elseif has_key(s:c, a:colour)
        return ' gui'.a:ground.'='.s:c[a:colour][0].' cterm'.a:ground.'='.s:c[a:colour][1]
    else
        if type(a:colour) == v:t_string
            if a:colour[0] == "#"
                " Example: a:colour='#123456'
                return ' gui'.a:ground.'='.a:colour
            else
                if index(s:TERM_COLOURS, tolower(a:colour)) >= 0
                    " Example: a:colour='Red'
                    return ' gui'.a:ground.'='.a:colour.' cterm'.a:ground.'='.a:colour
                else
                    " Example: a:colour='Fuchsia'
                    " If the string is not a term colour, raises an error if
                    " try to set it, e.g. 'fuchsia'
                    return ' gui'.a:ground.'='.a:colour
                endif
            endif
        elseif type(a:colour) == v:t_number
            " Example a:colour=123
            return ' gui'.a:ground.'='.a:colour
        endif
    endif
endfunction

function! s:HI(group, fg, ...)
    let str = 'hi ' . a:group

    " Forground
    if strlen(a:fg)
        let str .= s:getColorStr('fg', a:fg)
    endif

    " Background
    " a:0 stores the number of optional args passed in
    if a:0 >= 1
        let bg = a:1
        if strlen(bg)
            let str .= s:getColorStr('bg', bg)
        endif
    endif

    " Font format
    if a:0 >= 2
        let style = a:2
        if strlen(style)
            let str .= ' gui='.style.' cterm='.style
        endif
    endif
    exe str
endfun
call s:HI('Normal',         '#ecddd5', '#140f0c')
call s:HI('NormalNC',       'red', '#140f0c') " TEMP!!!
hi! link NormalNC Normal
call s:HI('EndOfBuffer',    'black', '#131903')
let s:c.py = {
            \'pathorange'       :'#f07d2e',
            \'skywhite'         :'#e4f8ff',
            \'skypurple'        :'#F4E4FC',
            \'mountainbeige'    :'#ffcf97',
            \'include'          :'#F4E4FC',
            \'comments'         :'#6f850e',
            \}

let s:sunset = {
            \'darkcloud'        :'#140f0c',
            \'brightskywhite'   :'#ecddd5',
            \'sunsetred'        :'#df5821',
            \'sunsorange '      :'#fd8246',
            \'sunsetamber'      :'#febb78',
            \'sunsetpeach'      :'#f6d0ab',
            \'skygray'          :'#a2979f',
            \'skylightpurple'   :'#d5c9db',
            \'skypurple'        :'#a49ab5',
            \'skybrown'         :'#a6866f',
            \}

let s:c.js = {
            \'darkcloud'        :'#140f0c',
            \'brightskywhite'   :'#ECDDD5',
            \'skydarkblue'      :'#c3d9f1',
            \'skylightblue'     :'#d8edff',
            \'grassyellow'      :'#ffff8c',
            \'grasssand'        :'#ecb743',
            \'grassorange'      :'#d8c700',
            \'grassgreen'       :'#97a533',
            \'brightbark'       :'#ffc56b',
            \'bark'             :'#e7a954',
            \'darkbark'         :'#ac7d25',
            \'mountainbrown'    :'#a29487',
            \'mountainblue'     :'#c5c5cd',
            \'brightsoil'       :'#d27d3c',
            \'fleshsoil'        :'#ffb890',
            \}

let s:c = {
            \'darkcloud'        :['#010300',234],
            \'brightsky'        :['#ecddd5',188],
            \'brown'            :['#c07a4d',130],
            \'red'              :['#df5821',166],
            \'orange'           :['#df9515',172],
            \'amber'            :['#dbb94e',178],
            \'bushgreen'        :['#92be68',107],
            \'green'            :['#00b000', 34],
            \'grassgreen'       :['#8fe43f',112],
            \'lime'             :['#BFFF00',1],
            \'neonlime'         :['#00FF00',1],
            \'mustard'          :['#c3c92d',142],
            \'yellow'           :['#d8e020',184],
            \'paleyellow'       :['#d8e080',184],
            \'stone'            :['#e4c5ac',223],
            \'skygray'          :['#c3b6b9',145],
            \'skybright'        :['#c3d9f1',153],
            \'skypale'          :['#d8edff',195],
            \'gray'             :['#a39397',102],
            \'indigo'           :['#CcB3D8',103],
            \'bluegray'         :['#9c93a9',103],
            \'purple'           :['#c07cad',172],
            \'peach'            :['#e17f93',210],
            \'skydark04'        :['#a38573',  1],
            \'skydark06'        :['#82777a',  1],
            \'skydark03'        :['#787690',  1],
            \'darkred'          :['#97310e',  1],
            \'skydark07'        :['#5f4b3f',  1],
            \'skydark08'        :['#615b62',  1],
            \'skydark09'        :['#494554',  1],
            \'skydark10'        :['#4a2010',  1],
            \'errorred'         :['#ff0000',  1],
            \'nordred'          :['#BF616A',  1],
            \'nordorange'       :['#D08770',  1],
            \'nordyellow'       :['#EBCB8B',  1],
            \'nordgreen'        :['#A3BE8C',  1],
            \'nordpurple'       :['#B48EAD',  1],
            \}
" {{{1 GENERIC CODE
call s:HI('Boolean',                 'yellow')
call s:HI('Character',               'yellow')
call s:HI('Comment',                 'gray')
call s:HI('Conditional',             'yellow')
call s:HI('Constant',                'grassgreen')
call s:HI('Float',                   'green')
call s:HI('Debug',                   'fuchsia')
call s:HI('Define',                  'fuchsia')
call s:HI('Exception',               'brown')
call s:HI('Function',                'orange')
call s:HI('Identifier',              'orange')         " print', end
call s:HI('Ignore',                  'fuchsia')
call s:HI('Include',                 'purple')         " import in python
call s:HI('Keyword',                 'indigo')         " print', end
call s:HI('Label',                   'orange')
call s:HI('Macro',                   'peach')
call s:HI('PreCondit',               'purple')
call s:HI('PreProc',                 'peach')        " bold
call s:HI('Repeat',                  'yellow')
call s:HI('Special',                 'amber')         " <leader> <C-U> etc
call s:HI('SpecialComment',          'fuchsia')
call s:HI('Statement',               'red')       " if not local return for in then
call s:HI('StorageClass',            'amber')
call s:HI('Structure',               'fuchsia')
call s:HI('Tag',                     'fuchsia')
call s:HI('Todo',                    'black', 'skybright')
call s:HI('Type',                    'brown')
call s:HI('Typedef',                 'fuchsia')
call s:HI('Underlined',              'fuchsia')
call s:HI('Noise',                  'bluegray')
" Unoffical Commonly used groups

" {{{1 HTML
call s:HI('htmlTagName',            'orange')
call s:HI('htmlTag',                'stone')
call s:HI('htmlTagN',               'red')
call s:HI('htmlScriptTag',          'stone')
call s:HI('htmlEndTag',             'gray')
call s:HI('htmlArg',                'mustard')
call s:HI('htmlString',             'grassgreen')
call s:HI('htmlSpecialChar',        'yellow')
call s:HI('htmlSpecialTagName',     'red')
call s:HI('htmlError',              'white', 'errorred')
call s:HI('htmlValue',              'green')
call s:HI('htmlTagError',           'fuchsia')
call s:HI('htmlEvent',              'purple')
call s:HI('htmlEventSQ',            'fuchsia')
call s:HI('htmlEventDQ',            'peach')
call s:HI('htmlCssDefinition',      'fuchsia')
call s:HI('htmlCommentPart',        'gray')
call s:HI('htmlCommentError',       'fuchsia')
call s:HI('htmlComment',            'skygray')
call s:HI('htmlPreStmt',            'fuchsia')
call s:HI('htmlPreError',           'fuchsia')
call s:HI('htmlPreAttr',            'fuchsia')
call s:HI('htmlPreProc',            'fuchsia')
call s:HI('htmlPreProcAttrError',   'fuchsia')
call s:HI('htmlPreProcAttrName',    'fuchsia')
call s:HI('htmlLink',               '', '', 'underline')
" font style groups don't need to be redefined
" call s:HI('htmlBold',               '', '', 'bold')
" call s:HI('htmlUnderline',          '', '', 'underline')
" call s:HI('htmlStrike',             '', '', 'strikethrough')
" call s:HI('htmlItalic',             '', '', 'italic')
" call s:HI('htmlBoldUnderline',      '', '', 'bold,underline')
" call s:HI('htmlBoldItalic',         '', '', 'bold,italic')
" call s:HI('htmlBoldUnderlineItalic','', '', 'bold,underline,italic')
" call s:HI('htmlBoldItalicUnderline','', '', 'bold,underline,italic')
" call s:HI('htmlUnderlineBold',      '', '', 'bold,underline,italic')
" call s:HI('htmlUnderlineItalic',    '', '', 'underline,italic')
" call s:HI('htmlUnderlineBoldItalic','', '', 'bold,underline,italic')
" call s:HI('htmlUnderlineItalicBold','', '', 'bold,underline,italic')
" call s:HI('htmlItalicUnderline',    '', '', 'italic,underline')
" call s:HI('htmlItalicBold',         '', '', 'italic,bold')
" call s:HI('htmlItalicBoldUnderline','', '', 'bold,underline,italic')
" call s:HI('htmlItalicUnderlineBold','', '', 'bold,underline,italic')
call s:HI('htmlLeadingSpace',       'fuchsia')
call s:HI('htmlH2',                 'white')
call s:HI('htmlH1',                 'white')
call s:HI('htmlH3',                 'white')
call s:HI('htmlH4',                 'white')
call s:HI('htmlH5',                 'white')
call s:HI('htmlH6',                 'white')
call s:HI('htmlTitle',              'white')
call s:HI('htmlHead',               'errorred')
call s:HI('htmlCssStyleComment',    'fuchsia')
call s:HI('htmlStyleArg',           'fuchsia')
call s:HI('htmlHighlight',          'fuchsia')
call s:HI('htmlHighlightSkip',      'fuchsia')
call s:HI('htmlStatement',          'fuchsia')
call s:HI('htmlSpecial',            'fuchsia')

" {{{1 CSS
" Chars
call s:HI('cssBraces',                  'stone')
call s:HI('cssNoise',                   'stone')
call s:HI('cssAttrComma',               'brightsky')
call s:HI('cssFunctionComma',           'brightsky')
call s:HI('cssSelectorOp',              'brightsky')
call s:HI('cssFunction',                'brightsky')
call s:HI('cssSelectorOp2',             'green')
call s:HI('cssUnicodeEscape',           'yellow')

" Main
call s:HI('cssProp',                    'amber')
call s:HI('cssVendor',                  'orange')
call s:HI('cssAttr',                    'yellow')
call s:HI('cssAttrRegion',              'mustard')
call s:HI('cssDefinition',              'red') " Doesnt seem to work
call s:HI('cssPseudoClass',             'peach')
call s:HI('cssPseudoClassId',           'peach')
call s:HI('cssPseudoClassFn',           'peach')
call s:HI('cssStringQ',                 'grassgreen')
call s:HI('cssStringQQ',                'grassgreen')
call s:HI('cssImportant',               'red')
call s:HI('cssFunctionName',            'purple')
call s:HI('cssAtRule',                  'skybright')

" Selectors
call s:HI('cssTagName',                 'red')
call s:HI('cssIdentifier',              'purple', 'skydark09')
call s:HI('cssClassNameDot',            '#00ff00', '#405000')
call s:HI('cssClassName',               'grassgreen', '#405000')
call s:HI('cssAttributeSelector',       'grassgreen')

" Values
call s:HI('cssValueInteger',            'brightsky')
call s:HI('cssValueNumber',             'brightsky')
call s:HI('cssValueLength',             'brightsky')
call s:HI('cssValueAngle',              'brightsky')
call s:HI('cssValueTime',               'brightsky')
call s:HI('cssUnitDecorators',          'skygray')
call s:HI('cssComment',                 'gray')
call s:HI('cssColor',                   '#BFFF00')
call s:HI('cssValueFrequency',          'fuchsia')
call s:HI('htmlCssDefinition',          'fuchsia')
call s:HI('cssStyle',                   'fuchsia')
call s:HI('htmlCssStyleComment',        'fuchsia')
call s:HI('cssCustomProp',              'fuchsia')
call s:HI('cssURL',                     'fuchsia')
" call s:HI('cssGradientAttr',            'fuchsia')
" call s:HI('cssCommonAttr',              'fuchsia')
" call s:HI('cssAnimationProp',           'fuchsia')
" call s:HI('cssAnimationAttr',           'fuchsia')
" call s:HI('cssBackgroundProp',          'fuchsia')
" call s:HI('cssBackgroundAttr',          'fuchsia')
" call s:HI('cssBorderProp',              'fuchsia')
" call s:HI('cssBorderAttr',              'fuchsia')
" call s:HI('cssBoxProp',                 'fuchsia')
" call s:HI('cssBoxAttr',                 'fuchsia')
" call s:HI('cssCascadeProp',             'fuchsia')
" call s:HI('cssCascadeAttr',             'fuchsia')
" call s:HI('cssColorProp',               'fuchsia')
" call s:HI('cssDimensionProp',           'fuchsia')
" call s:HI('cssFlexibleBoxProp',         'fuchsia')
" call s:HI('cssFlexibleBoxAttr',         'fuchsia')
" call s:HI('cssFontProp',                'fuchsia')
" call s:HI('cssFontAttr',                'fuchsia')
" call s:HI('cssMultiColumnProp',         'fuchsia')
" call s:HI('cssMultiColumnAttr',         'fuchsia')
" call s:HI('cssInteractProp',            'fuchsia')
" call s:HI('cssInteractAttr',            'fuchsia')
" call s:HI('cssGeneratedContentProp',    'fuchsia')
" call s:HI('cssGeneratedContentAttr',    'fuchsia')
" call s:HI('cssGridProp',                'fuchsia')
" call s:HI('cssHyerlinkProp',            'fuchsia')
" call s:HI('cssListProp',                'fuchsia')
" call s:HI('cssListAttr',                'fuchsia')
" call s:HI('cssPositioningProp',         'fuchsia')
" call s:HI('cssPositioningAttr',         'fuchsia')
" call s:HI('cssPrintAttr',               'fuchsia')
" call s:HI('cssTableProp',               'fuchsia')
" call s:HI('cssTableAttr',               'fuchsia')
" call s:HI('cssTextProp',                'fuchsia')
" call s:HI('cssTextAttr',                'fuchsia')
" call s:HI('cssTransformProp',           'fuchsia')
" call s:HI('cssTransitionProp',          'fuchsia')
" call s:HI('cssTransitionAttr',          'fuchsia')
" call s:HI('cssUIProp',                  'fuchsia')
" call s:HI('cssUIAttr',                  'fuchsia')
" call s:HI('cssIEUIAttr',                'fuchsia')
" call s:HI('cssIEUIProp',                'fuchsia')
" call s:HI('cssAuralProp',               'fuchsia')
" call s:HI('cssAuralAttr',               'fuchsia')
" call s:HI('cssMobileTextProp',          'fuchsia')
" call s:HI('cssMediaProp',               'fuchsia')
" call s:HI('cssMediaAttr',               'fuchsia')
" call s:HI('cssKeyFrameProp',            'fuchsia')
" call s:HI('cssPageMarginProp',          'fuchsia')
" call s:HI('cssPageProp',                'fuchsia')
" call s:HI('cssFontDescriptorProp',      'fuchsia')
" call s:HI('cssFontDescriptorAttr',      'fuchsia')
call s:HI('cssError',                   'fuchsia')
call s:HI('cssHacks',                   'fuchsia')
call s:HI('cssBraceError',              'fuchsia')
call s:HI('cssSpecialCharQQ',           'fuchsia')
call s:HI('cssSpecialCharQ',            'fuchsia')
call s:HI('cssAtKeyword',               'skybright')
call s:HI('cssAtRuleLogical',           'skypale')
call s:HI('cssMediaType',               'skypale')
call s:HI('cssPagePseudo',              'fuchsia')
call s:HI('cssDeprecated',              'fuchsia')
" call s:HI('cssContentForPagedMediaProp','fuchsia')
" call s:HI('cssLineboxProp',             'fuchsia')
" call s:HI('cssMarqueeProp',             'fuchsia')
" call s:HI('cssPagedMediaProp',          'fuchsia')
" call s:HI('cssPrintProp',               'fuchsia')
" call s:HI('cssRubyProp',                'fuchsia')
" call s:HI('cssSpeechProp',              'fuchsia')
" call s:HI('cssRenderProp',              'fuchsia')
" call s:HI('cssContentForPagedMediaAttr','fuchsia')
" call s:HI('cssDimensionAttr',           'fuchsia')
" call s:HI('cssGridAttr',                'fuchsia')
" call s:HI('cssHyerlinkAttr',            'fuchsia')
" call s:HI('cssLineboxAttr',             'fuchsia')
" call s:HI('cssMarginAttr',              'fuchsia')
" call s:HI('cssMarqueeAttr',             'fuchsia')
" call s:HI('cssPaddingAttr',             'fuchsia')
" call s:HI('cssPagedMediaAttr',          'fuchsia')
" call s:HI('cssRubyAttr',                'fuchsia')
" call s:HI('cssSpeechAttr',              'fuchsia')
" call s:HI('cssTransformAttr',           'fuchsia')
" call s:HI('cssRenderAttr',              'fuchsia')
call s:HI('cssPseudoClassLang',         'fuchsia')
call s:HI('cssMediaComma',              'fuchsia')
call s:HI('cssFontDescriptor',          'fuchsia')
call s:HI('cssUnicodeRange',            'fuchsia')
call s:HI('cssLength',                  'fuchsia')
call s:HI('cssString',                  'fuchsia')
" call s:HI('cssPagingProp',              'fuchsia')
call s:HI('scssComment',                'gray')
call s:HI('sassDefault',                'fuchsia')
call s:HI('sassCssAttribute',           'fuchsia')
call s:HI('sassCssComment',             'gray')

" {{{1 JavaScript
call s:HI('javaScriptStringS',              'grassgreen')
call s:HI('javaScriptGlobal',               'yellow')
call s:HI('javaScriptFunction',             'red')
" call s:HI('javaScriptExpression',           'fuchsia')
" call s:HI('javaScript',                     'purple')
" call s:HI('javaScriptCommentTodo',          'fuchsia')
" call s:HI('javaScriptLineComment',          'gray')
" call s:HI('javaScriptCommentSkip',          'fuchsia')
" call s:HI('javaScriptComment',              'bluegray')
" call s:HI('javaScriptSpecial',              'fuchsia')
" call s:HI('javaScriptStringD',              'fuchsia')
" call s:HI('javaScriptEmbed',                'fuchsia')
" call s:HI('javaScriptStringT',              'fuchsia')
" call s:HI('javaScriptSpecialCharacter',     'fuchsia')
" call s:HI('javaScriptNumber',               'green')
" call s:HI('javaScriptRegexpString',         'fuchsia')
" call s:HI('javaScriptConditional',          'yellow')
" call s:HI('javaScriptRepeat',               'fuchsia')
" call s:HI('javaScriptBranch',               'fuchsia')
" call s:HI('javaScriptOperator',             'fuchsia')
" call s:HI('javaScriptType',                 'fuchsia')
" call s:HI('javaScriptStatement',            'fuchsia')
" call s:HI('javaScriptBoolean',              'fuchsia')
" call s:HI('javaScriptNull',                 'fuchsia')
" call s:HI('javaScriptIdentifier',           'fuchsia')
" call s:HI('javaScriptLabel',                'fuchsia')
" call s:HI('javaScriptException',            'fuchsia')
" call s:HI('javaScriptMessage',              'fuchsia')
" call s:HI('javaScriptMember',               'orange')
" call s:HI('javaScriptDeprecated',           'fuchsia')
" call s:HI('javaScriptReserved',             'fuchsia')
" " hi! link javaScriptFunction Function
" call s:HI('javaScriptBraces',               'lime')
" call s:HI('javaScriptParens',               'stone')
" call s:HI('javaScriptCharacter',            'fuchsia')
" call s:HI('javaScriptValue',                'fuchsia')
" call s:HI('javaScriptError',                'fuchsia')
" call s:HI('javaScrParenError',              'fuchsia')
" call s:HI('javaScriptDebug',                'fuchsia')
" call s:HI('javaScriptConstant',             'fuchsia')

" {{{1 Vim-Javascript
" jsNoise        xxx links to Noise
call s:HI('jsObjectProp',           'paleyellow')
" jsObjectProp   xxx cleared
call s:HI('jsFuncCall',           'mustard')
" jsFuncCall     xxx links to Function
" jsPrototype    xxx links to Special
" jsTaggedTemplate xxx links to StorageClass
" jsDot          xxx links to Noise
" jsParensError  xxx links to Error
" jsStorageClass xxx links to StorageClass
" jsDestructuringBlock xxx cleared
" jsDestructuringArray xxx cleared
" jsVariableDef  xxx cleared
" jsFlowDefinition xxx cleared
" jsOperatorKeyword xxx links to jsOperator
call s:HI('jsOperator',           'stone')
" jsOperator     xxx links to Operator
" jsBooleanTrue  xxx links to Boolean
" jsBooleanFalse xxx links to Boolean
" jsImport       xxx links to Include
" jsModuleAsterisk xxx links to Noise
" jsModuleKeyword xxx cleared
" jsModuleGroup  xxx cleared
" jsFlowImportType xxx cleared
" jsExport       xxx links to Include
" jsExportDefault xxx links to StorageClass
" jsFlowTypeStatement xxx cleared
" jsModuleAs     xxx links to Include
" jsFrom         xxx links to Include
" jsModuleComma  xxx links to jsNoise
" jsExportDefaultGroup xxx links to jsExportDefault
" jsString       xxx links to String
" jsFlowTypeKeyword xxx cleared
" jsSpecial      xxx links to Special
" jsTemplateExpression xxx cleared
" jsTemplateString xxx links to String
" jsNumber       xxx links to Number
" jsFloat        xxx links to Float
" jsTemplateBraces xxx links to Noise
" jsRegexpCharClass xxx links to Character
" jsRegexpBoundary xxx links to SpecialChar
" jsRegexpBackRef xxx links to SpecialChar
" jsRegexpQuantifier xxx links to SpecialChar
" jsRegexpOr     xxx links to Conditional
" jsRegexpMod    xxx links to SpecialChar
" jsRegexpGroup  xxx links to jsRegexpString
" jsRegexpString xxx links to String
" jsObjectSeparator xxx links to Noise
" jsObjectShorthandProp xxx links to jsObjectKey
" jsFunctionKey  xxx cleared
" jsObjectValue  xxx cleared
" jsObjectKey    xxx cleared
" jsObjectKeyString xxx links to String
" jsBrackets     xxx links to Noise
" jsFuncArgs     xxx cleared
" jsObjectKeyComputed xxx cleared
" jsObjectColon  xxx links to jsNoise
" jsObjectFuncName xxx links to Function
" jsObjectMethodType xxx links to Type
" jsObjectStringKey xxx links to String
" jsNull         xxx links to Type
" jsReturn       xxx links to Statement
" jsUndefined    xxx links to Type
" jsNan          xxx links to Number
" jsThis         xxx links to Special
" jsSuper        xxx links to Constant
" jsBlock        xxx cleared
" jsBlockLabel   xxx links to Identifier
" jsBlockLabelKey xxx links to jsBlockLabel
" jsStatement    xxx links to Statement
" jsConditional  xxx links to Conditional
" jsParenIfElse  xxx cleared
" jsCommentIfElse xxx links to jsComment
" jsIfElseBlock  xxx cleared
" jsParenSwitch  xxx cleared
" jsRepeat       xxx links to Repeat
call s:HI('jsRepeat',           'peach')
" jsParenRepeat  xxx cleared
" jsForAwait     xxx links to Keyword
" jsDo           xxx links to Repeat
" jsRepeatBlock  xxx cleared
" jsLabel        xxx links to Label
" jsSwitchColon  xxx links to Noise
" jsSwitchCase   xxx cleared
" jsTry          xxx links to Exception
" jsTryCatchBlock xxx cleared
" jsFinally      xxx links to Exception
" jsFinallyBlock xxx cleared
" jsCatch        xxx links to Exception
" jsParenCatch   xxx cleared
" jsException    xxx links to Exception
" jsAsyncKeyword xxx links to Keyword
" jsSwitchBlock  xxx cleared
call s:HI('jsGlobalObjects',           'indigo')
" jsGlobalObjects xxx links to Constant
" jsGlobalNodeObjects xxx links to Constant
" jsExceptions   xxx links to Constant
" jsBuiltins     xxx links to Constant
" jsFutureKeys   xxx cleared
" jsDomErrNo     xxx links to Constant
" jsDomNodeConsts xxx links to Constant
" jsHtmlEvents   xxx links to Special
" jsSpreadExpression xxx cleared
" jsBracket      xxx cleared
" jsParens       xxx links to Noise
" jsParen        xxx cleared
" jsParensDecorator xxx links to jsParens
" jsParenDecorator xxx cleared
" jsParensIfElse xxx links to jsParens
" jsParensRepeat xxx links to jsParens
" jsCommentRepeat xxx links to jsComment
" jsParensSwitch xxx links to jsParens
" jsParensCatch  xxx links to jsParens
" jsFuncParens   xxx links to Noise
" jsFuncArgCommas xxx cleared
" jsComment      xxx links to Comment
" jsFuncArgExpression xxx cleared
" jsRestExpression xxx links to jsFuncArgs
" jsFlowArgumentDef xxx cleared
" jsCommentFunction xxx links to jsComment
" call s:HI('jsFuncBlock',           'purple')
" jsFuncBlock    xxx cleared
" jsFlowReturn   xxx cleared
" jsClassBraces  xxx links to Noise
" jsClassFuncName xxx links to jsFuncName
" jsClassMethodType xxx links to Type
call s:HI('jsArrowFunction',           'peach')
" jsArrowFunction xxx links to Type
" jsArrowFuncArgs xxx links to jsFuncArgs
" jsGenerator    xxx links to jsFunction
" jsDecorator    xxx links to Special
" jsClassProperty xxx links to jsObjectKey
" jsClassPropertyComputed xxx cleared
" jsClassStringKey xxx links to String
" jsClassBlock   xxx cleared
call s:HI('jsFuncBraces',           'red')
" jsFuncBraces   xxx links to Noise
call s:HI('jsIfElseBraces',           'yellow')
" jsTryCatchBraces xxx links to Noise
" jsFinallyBraces xxx links to Noise
" jsIfElseBraces xxx links to Noise
" jsSwitchBraces xxx links to Noise
call s:HI('jsRepeatBraces',           'peach')
" jsRepeatBraces xxx links to Noise
" jsDestructuringBraces xxx links to Noise
" jsDestructuringProperty xxx links to jsFuncArgs
" jsDestructuringAssignment xxx links to jsObjectKey
" jsDestructuringNoise xxx links to Noise
" jsDestructuringPropertyComputed xxx cleared
" jsDestructuringPropertyValue xxx cleared
" jsObjectBraces xxx links to Noise
" jsObject       xxx cleared
" jsBraces       xxx links to Noise
" jsModuleBraces xxx links to Noise
" jsSpreadOperator xxx links to Operator
" jsRestOperator xxx links to Operator
" jsTernaryIfOperator xxx links to Operator
" jsTernaryIf    xxx cleared
call s:HI('jsfuncname',           'orange')
" jsFuncName     xxx links to Function
" jsFlowFunctionGroup xxx cleared
" jsFuncArgOperator xxx links to jsFuncArgs
" jsArguments    xxx links to Special
call s:HI('jsFunction',           'red')
" jsFunction     xxx links to Type
" jsClassKeyword xxx links to Keyword
" jsExtendsKeyword xxx links to Keyword
" jsClassNoise   xxx links to Noise
" jsFlowClassFunctionGroup xxx cleared
" jsFlowClassGroup xxx cleared
" jsCommentClass xxx links to jsComment
" jsClassDefinition xxx links to jsFuncName
" jsClassValue   xxx cleared
" jsFlowClassDef xxx cleared
" jsDestructuringValue xxx cleared
" jsDestructuringValueAssignment xxx cleared
" jsCommentTodo  xxx links to Todo
" jsEnvComment   xxx links to PreProc
" jsDecoratorFunction xxx links to Function
" jsCharacter    xxx links to Character
" jsBranch       xxx links to Conditional
" jsError        xxx links to Error
" jsOf           xxx links to Operator
" jsDomElemAttrs xxx links to Label
" jsDomElemFuncs xxx links to PreProc
" jsHtmlElemAttrs xxx links to Label
" jsHtmlElemFuncs xxx links to PreProc
" jsCssStyles    xxx links to Label

" {{{1 Python
" These hi groups retain original links to generic coding scheme
" Comment call s:" links to Comment HI('pythonComment',          'gray')
" Include call s:HI('pythonInclude',          'purple')         " import in python
" Statement call s:HI('pythonStatement',        'red')       " if not local return for in then
" Function call s:HI('pythonFunction',         'orange')
" Conditional call s:HI('pythonConditional',      'yellow')
" Repeat call s:HI('pythonRepeat',           'yellow')
" Exception call s:HI('pythonException',        'brown')
" Todo - call s:HI('pythonTodo',             'black', 'skybright')
" Type - call s:HI('pythonType',             'fuchsia')    " {}
call s:HI('pythonString',           'grassgreen')
call s:HI('pythonQuotes',           'green')
call s:HI('pythonTripleQuotes',     'green')
call s:HI('pythonOperator',         'mustard')
call s:HI('pythonExceptions',       'red')
call s:HI('pythonEscape',           'yellow')
call s:HI('pythonNumber',           'green')
call s:HI('pythonBuiltin',          'bluegray')
call s:HI('pythonDecorator',        'purple')
call s:HI('pythonDecoratorName',    'peach')
call s:HI('pythonRawString',        'bushgreen')
call s:HI('pythonSpaceError',       'white', 'errorred')
" Dont know what these are for
call s:HI('pythonSpecial',          'fuchsia')         " <leader> <C-U> etc
call s:HI('pythonIdentifier',       'fuchsia')         " print, end
call s:HI('pythonPreProc',          'fuchsia')        " bold
call s:HI('pythonTitle',            'fuchsia')        " <leader> <C-U> etc
call s:HI('pythonError',            'fuchsia')
call s:HI('pythonAsync',            'fuchsia')
call s:HI('pythonAttribute',        'fuchsia')
call s:HI('pythonDoctest',          'fuchsia')
call s:HI('pythonDoctestValue',     'fuchsia')
call s:HI('pythonMatrixMultiply',   'fuchsia')
call s:HI('pythonSync',             'fuchsia')

" {{{1 Django
call s:HI('djangoError',            'fuchsia'   ,'#404050')
call s:HI('djangoTagBlock',         'brightsky' ,'#404050')
call s:HI('djangoFilter',           'brightsky' ,'#404050')
call s:HI('djangoStatement',        'peach'     ,'#404050')
call s:HI('djangoArgument',         'purple'    ,'#404050')
call s:HI('djangoVarBlock',         'purple'    ,'#404050')
call s:HI('djangoTodo',             'fuchsia'   ,'#404050')
call s:HI('djangoTagError',         'fuchsia'   ,'#404050')
call s:HI('djangoVarError',         'fuchsia'   ,'#404050')
call s:HI('djangoComment',          'fuchsia'   ,'#404050')
call s:HI('djangoComBlock',         'gray'      ,'#404050')

" {{{1 JSON
call s:HI('jsonKeyword',           'nordpurple')
call s:HI('jsonQuote',           'skygray')

" {{{1 VIML
" call s:HI('vimTodo',                'fuchsia')
call s:HI('vimCommand',             'red')
" call s:HI('vimOnlyCommand',         'fuchsia')
" call s:HI('vimStdPlugin',           'fuchsia')
" call s:HI('vimOnlyOption',          'fuchsia')
" call s:HI('vimTermOption',          'fuchsia')
" call s:HI('vimErrSetting',          'fuchsia')
call s:HI('vimGroup',               'lime')
call s:HI('vimHLGroup',             'skybright')
" call s:HI('vimOnlyHLGroup',         'fuchsia')
" call s:HI('vimGlobal',              'fuchsia')
" call s:HI('vimSubst',               'fuchsia')
call s:HI('vimComment',             'gray')
call s:HI('vimNumber',              'green')
call s:HI('vimAddress',             'brightsky')
call s:HI('vimAutoCmd',             'orange')
call s:HI('vimEcho',                'gray')
call s:HI('vimIsCommand',           'yellow')
" call s:HI('vimExtCmd',              'fuchsia')
" call s:HI('vimFilter',              'fuchsia')
call s:HI('vimLet',                 'purple')
call s:HI('vimMap',                 'red')
" call s:HI('vimMark',                'fuchsia')
call s:HI('vimSet',                 'brightsky')
" call s:HI('vimSyntax',              'fuchsia')
call s:HI('vimUserCmd',             'grau')
call s:HI('vimCmdSep',              'stone')
call s:HI('vimVar',                 'stone')
call s:HI('vimFBVar',               'purple')
" call s:HI('vimInsert',              'fuchsia')
call s:HI('vimBehaveModel',         'brightsky')
" call s:HI('vimBehaveError',         'fuchsia')
call s:HI('vimBehave',              'red')
call s:HI('vimFTCmd',               'peach')
call s:HI('vimFTOption',            'purple')
" call s:HI('vimFTError',             'fuchsia')
" call s:HI('vimFiletype',            'fuchsia')
call s:HI('vimAugroup',             'brightsky')
" call s:HI('vimExecute',             'fuchsia')
call s:HI('vimNotFunc',             'yellow')
call s:HI('vimFuncName',            'stone')
call s:HI('vimFunction',            'orange')
" call s:HI('vimFunctionError',       'fuchsia')
call s:HI('vimLineComment',         'gray')
call s:HI('vimSpecFile',            'mustard')
call s:HI('vimOper',                'stone')
call s:HI('vimOperParen',           'brightsky')
call s:HI('vimString',              'grassgreen')
" call s:HI('vimRegister',            'fuchsia')
" call s:HI('vimCmplxRepeat',         'fuchsia')
" call s:HI('vimRegion',              'fuchsia')
" call s:HI('vimSynLine',             'fuchsia')
call s:HI('vimNotation',            'mustard')
" call s:HI('vimCtrlChar',            'fuchsia')
call s:HI('vimFuncVar',             'skypale')
call s:HI('vimContinue',            'gray')
call s:HI('vimSetEqual',            'brightsky')
call s:HI('vimOption',              'amber')
call s:HI('vimAugroupKey',          'red')
" call s:HI('vimAugroupError',        'fuchsia')
" call s:HI('vimEnvvar',              'fuchsia')
" call s:HI('vimFunc',                'fuchsia')
call s:HI('vimParenSep',            'gray')
call s:HI('vimSep',                 'lime')
" call s:HI('vimOperError',           'fuchsia')
" call s:HI('vimFuncKey',             'fuchsia')
" call s:HI('vimFuncSID',             'fuchsia')
" call s:HI('vimAbb',                 'fuchsia')
call s:HI('vimEchoHL',              'amber')
call s:HI('vimHighlight',           'peach')
call s:HI('vimNorm',                'red')
" call s:HI('vimSearch',              'fuchsia')
" call s:HI('vimUnmap',               'fuchsia')
call s:HI('vimUserCommand',         'red')
call s:HI('vimFuncBody',            'purple')
" call s:HI('vimFuncBlank',           'fuchsia')
" call s:HI('vimPattern',             'fuchsia')
" call s:HI('vimSpecFileMod',         'fuchsia')
" call s:HI('vimEscapeBrace',         'fuchsia')
" call s:HI('vimSetString',           'fuchsia')
" call s:HI('vimSubstRep',            'fuchsia')
" call s:HI('vimSubstRange',          'fuchsia')
" call s:HI('vimUserAttrb',           'fuchsia')
" call s:HI('vimUserAttrbError',      'fuchsia')
" call s:HI('vimUserAttrbKey',        'fuchsia')
" call s:HI('vimUserAttrbCmplt',      'fuchsia')
" call s:HI('vimUserCmdError',        'fuchsia')
" call s:HI('vimUserAttrbCmpltFunc',  'fuchsia')
call s:HI('vimCommentString',       'bluegray')
" call s:HI('vimPatSepErr',           'fuchsia')
" call s:HI('vimPatSep',              'fuchsia')
" call s:HI('vimPatSepZ',             'fuchsia')
" call s:HI('vimPatSepZone',          'fuchsia')
" call s:HI('vimPatSepR',             'fuchsia')
" call s:HI('vimPatRegion',           'fuchsia')
" call s:HI('vimNotPatSep',           'fuchsia')
call s:HI('vimStringEnd',           'grassgreen')
" call s:HI('vimStringCont',          'fuchsia')
" call s:HI('vimSubstTwoBS',          'fuchsia')
" call s:HI('vimSubstSubstr',         'fuchsia')
" call s:HI('vimCollection',          'fuchsia')
call s:HI('vimSubstPat',            'yellow')
call s:HI('vimSubst1',              'brightsky')
" call s:HI('vimSubst2',              'fuchsia')
call s:HI('vimSubstDelim',          'neonlime')
call s:HI('vimSubstRep4',           'brightsky')
" call s:HI('vimSubstFlagErr',        'fuchsia')
" call s:HI('vimCollClass',           'fuchsia')
" call s:HI('vimCollClassErr',        'fuchsia')
call s:HI('vimSubstFlags',          'bushgreen')
" call s:HI('vimMarkNumber',          'fuchsia')
" call s:HI('vimPlainMark',           'fuchsia')
" call s:HI('vimRange',               'fuchsia')
" call s:HI('vimPlainRegister',       'fuchsia')
" call s:HI('vimSetMod',              'fuchsia')
call s:HI('vimSetSep',              'stone')
call s:HI('vimMapMod',              'lime')
call s:HI('vimMapLhs',              'orange')
call s:HI('vimAutoEvent',           'yellow')
" call s:HI('vimAutoCmdSpace',        'fuchsia')
" call s:HI('vimAutoEventList',       'fuchsia')
call s:HI('vimAutoCmdSfxList',      'brightwhite')
call s:HI('vimEchoHLNone',          'bluegray')
call s:HI('vimMapBang',             'orange')
call s:HI('vimMapRhs',              'yellow')
" call s:HI('vimMapModErr',           'fuchsia')
call s:HI('vimMapModKey',           'lime')
" call s:HI('vimMapRhsExtend',        'fuchsia')
" call s:HI('vimMenuBang',            'fuchsia')
" call s:HI('vimMenuPriority',        'fuchsia')
" call s:HI('vimMenuName',            'fuchsia')
" call s:HI('vimMenuMod',             'fuchsia')
" call s:HI('vimMenuNameMore',        'fuchsia')
" call s:HI('vimMenuMap',             'fuchsia')
" call s:HI('vimMenuRhs',             'fuchsia')
" call s:HI('vimBracket',             'stone')
" call s:HI('vimUserFunc',            'peach')
" call s:HI('vimElseIfErr',           'fuchsia')
" call s:HI('vimBufnrWarn',           'fuchsia')
call s:HI('vimNormCmds',            'brightsky')
" call s:HI('vimGroupSpecial',        'fuchsia')
" call s:HI('vimGroupList',           'fuchsia')
" call s:HI('vimSynError',            'fuchsia')
" call s:HI('vimSynContains',         'fuchsia')
" call s:HI('vimSynKeyContainedin',   'fuchsia')
" call s:HI('vimSynNextgroup',        'fuchsia')
call s:HI('vimSynType',             'brightsky')
" call s:HI('vimAuSyntax',            'fuchsia')
" call s:HI('vimSynCase',             'fuchsia')
" call s:HI('vimSynCaseError',        'fuchsia')
" call s:HI('vimClusterName',         'fuchsia')
" call s:HI('vimGroupName',           'fuchsia')
" call s:HI('vimGroupAdd',            'fuchsia')
" call s:HI('vimGroupRem',            'fuchsia')
" call s:HI('vimIskList',             'fuchsia')
" call s:HI('vimIskSep',              'fuchsia')
" call s:HI('vimSynKeyOpt',           'fuchsia')
" call s:HI('vimSynKeyRegion',        'fuchsia')
" call s:HI('vimMtchComment',         'fuchsia')
" call s:HI('vimSynMtchOpt',          'fuchsia')
" call s:HI('vimSynRegPat',           'fuchsia')
" call s:HI('vimSynMatchRegion',      'fuchsia')
" call s:HI('vimSynMtchCchar',        'fuchsia')
" call s:HI('vimSynMtchGroup',        'fuchsia')
" call s:HI('vimSynPatRange',         'fuchsia')
" call s:HI('vimSynNotPatRange',      'fuchsia')
" call s:HI('vimSynRegOpt',           'fuchsia')
" call s:HI('vimSynReg',              'fuchsia')
" call s:HI('vimSynMtchGrp',          'fuchsia')
" call s:HI('vimSynRegion',           'fuchsia')
" call s:HI('vimSynPatMod',           'fuchsia')
" call s:HI('vimSyncC',               'fuchsia')
" call s:HI('vimSyncLines',           'fuchsia')
" call s:HI('vimSyncMatch',           'fuchsia')
" call s:HI('vimSyncError',           'fuchsia')
" call s:HI('vimSyncLinebreak',       'fuchsia')
" call s:HI('vimSyncLinecont',        'fuchsia')
" call s:HI('vimSyncRegion',          'fuchsia')
" call s:HI('vimSyncGroupName',       'fuchsia')
" call s:HI('vimSyncKey',             'fuchsia')
" call s:HI('vimSyncGroup',           'fuchsia')
" call s:HI('vimSyncNone',            'fuchsia')
" call s:HI('vimHiLink',              'fuchsia')
call s:HI('vimHiClear',             'brightwhite')
call s:HI('vimHiKeyList',           'stone')
" call s:HI('vimHiCtermError',        'fuchsia')
call s:HI('vimHiBang',              'orange')
call s:HI('vimHiGroup',             'lime')
call s:HI('vimHiAttrib',            'peach')
call s:HI('vimFgBgAttrib',          'lightpink')
" call s:HI('vimHiAttribList',        'fuchsia')
" call s:HI('vimHiCtermColor',        'fuchsia')
" call s:HI('vimHiFontname',          'fuchsia')
" call s:HI('vimHiGuiFontname',       'fuchsia')
call s:HI('vimHiGuiRgb',            'brightsky')
" call s:HI('vimHiBlend',             'fuchsia')
" call s:HI('vimHiTerm',              'fuchsia')
call s:HI('vimHiCTerm',             'amber')
" call s:HI('vimHiStartStop',         'fuchsia')
call s:HI('vimHiCtermFgBg',         'amber')
call s:HI('vimHiGui',               'orange')
" call s:HI('vimHiGuiFont',           'fuchsia')
call s:HI('vimHiGuiFgBg',           'orange')
" call s:HI('vimHiTermcap',           'fuchsia')
" call s:HI('vimHiKeyError',          'fuchsia')
call s:HI('vimHiNmbr',              'green')
call s:HI('vimCommentTitle',        'brightsky')
" call s:HI('vimCommentTitleLeader',  'fuchsia')
" call s:HI('vimSearchDelim',         'fuchsia')
" call s:HI('vimEmbedError',          'fuchsia')
" call s:HI('vimAugroupSyncA',        'fuchsia')
" call s:HI('vimError',               'fuchsia')
" call s:HI('vimKeyCodeError',        'fuchsia')
" call s:HI('vimWarn',                'fuchsia')
" call s:HI('vimAuHighlight',         'fuchsia')
" call s:HI('vimAutoCmdOpt',          'fuchsia')
" call s:HI('vimAutoSet',             'fuchsia')
" call s:HI('vimCondHL',              'fuchsia')
" call s:HI('vimElseif',              'fuchsia')
" call s:HI('vimFold',                'fuchsia')
" call s:HI('vimSynOption',           'fuchsia')
" call s:HI('vimHLMod',               'fuchsia')
" call s:HI('vimKeyCode',             'fuchsia')
" call s:HI('vimKeyword',             'fuchsia')
" call s:HI('vimScriptDelim',         'fuchsia')
" call s:HI('vimSpecial',             'fuchsia')
" call s:HI('vimStatement',           'fuchsia')
