" {{{1 theme settings
if !has("gui_running") && &t_co != 88 && &t_co != 256
    finish
endif

hi clear todo enable when done
if exists("syntax_on")
    syntax reset
endif

let g:colors_name = "capesky"
set background=dark
set t_co=256

let s:term_colours = ['black', 'blue', 'brown', 'cyan', 'darkblue', 'darkcyan', 'darkgray', 'darkgreen', 'darkgrey', 'darkmagenta', 'darkred', 'darkyellow', 'gray', 'green', 'grey', 'lightblue', 'lightcyan', 'lightgray', 'lightgreen', 'lightgrey', 'lightmagenta', 'lightred', 'lightyellow', 'magenta', 'red', 'white', 'yellow']
let s:c = {} " so can place the definition below the functions

set background=dark

let g:capesky_high_contrast = 1
let g:capesky_high_contrast = get(g:, 'capesky_high_contrast', 0)

" examples:
" echo s:c['red']['a100']
" echo s:c['bluegray']['200']
"let s:c = {}
" \'python'     : { '':'#ffebee', 100:'#ffcdd2', 200:'#ef9a9a', 300:'#e57373', 400:'#ef5350', 500:'#f44336', 600:'#e53935', 700:'#d32f2f', 800:'#c62828', 900:'#b71c1c', 'a100':'#ff8a80', 'a200':'#ff5252', 'a400':'#ff1744', 'a700':'#d50000' },
" \'pink'       : { 50:'#fce4ec', 100:'#f8bbd0', 200:'#f48fb1', 300:'#f06292', 400:'#ec407a', 500:'#e91e63', 600:'#d81b60', 700:'#c2185b', 800:'#ad1457', 900:'#880e4f', 'a100':'#ff80ab', 'a200':'#ff4081', 'a400':'#f50057', 'a700':'#c51162' },
" \}
function! s:getcolor(str)
    " e.g. getcolor("red 500") returns '#f44336'
    let name_code = split(a:str)
    if len(name_code) > 1
        let name = name_code[0]
        let code = name_code[1]
        let hex_code = s:c[name][code]
    else
        " if there is no space in the str, probably meant to use it as is.
        let hex_code = a:str
    endif
    return hex_code
endfun

function! s:getcolorstr2(ground, colour)
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


function! s:getcolorstr(ground, colour)
    " ground = 'fg' or 'bg'
    " colour = 'red' or '#123456' or 123 or ['#123456',123]
    if (a:ground == a:colour) || (tolower(a:colour) == 'none')
        " example: ground='fg' or 'bg'
        return ' gui'.a:ground.'='.a:ground.' cterm'.a:ground.'='.a:ground
    elseif has_key(s:c, a:colour)
        " normal gui index = 0, normal cterm index = 1
        " high_contrast gui index = 2, high_contrast cterm index = 3
        let index = g:capesky_high_contrast ? 0 : 1
        return ' gui'.a:ground.'='.s:c[a:colour][index].' cterm'.a:ground.'='.s:c[a:colour][index+1]
    else
        if type(a:colour) == v:t_string
            if a:colour[0] == "#"
                " example: a:colour='#123456'
                return ' gui'.a:ground.'='.a:colour
            else
                if index(s:term_colours, tolower(a:colour)) >= 0
                    " example: a:colour='red'
                    return ' gui'.a:ground.'='.a:colour.' cterm'.a:ground.'='.a:colour
                else
                    " example: a:colour='fuchsia'
                    " if the string is not a term colour, raises an error if
                    " try to set it, e.g. 'fuchsia'
                    return ' gui'.a:ground.'='.a:colour
                endif
            endif
        elseif type(a:colour) == v:t_number
            " example a:colour=123
            return ' gui'.a:ground.'='.a:colour
        endif
    endif
endfunction

function! s:hi(group, fg, ...)
    let str = 'hi ' . a:group

    " forground
    if strlen(a:fg)
        let str .= s:getcolorstr('fg', a:fg)
    endif

    " background
    " a:0 stores the number of optional args passed in
    if a:0 >= 1
        let bg = a:1
        if strlen(bg)
            let str .= s:getcolorstr('bg', bg)
        endif
    endif

    " font format
    if a:0 >= 2
        let style = a:2
        if strlen(style)
            let str .= ' gui='.style.' cterm='.style
        endif
    endif
    exe str
endfun
call s:hi('normal',         '#ecddd5', '#140f0c')
call s:hi('normalnc',       'red', '#140f0c') " temp!!!
hi! link normalnc normal
call s:hi('endofbuffer',    'black', '#131903')
let s:c.py = {
            \'pathorange'       :'#f07d2e',
            \'skywhite'         :'#e4f8ff',
            \'skypurple'        :'#f4e4fc',
            \'mountainbeige'    :'#ffcf97',
            \'include'          :'#f4e4fc',
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
            \'brightskywhite'   :'#ecddd5',
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

let s:c2 = {
            \'darkcloud'        :['#010300',234],
            \'brightsky'        :['#ecddd5',188],
            \'brown'            :['#c07a4d',130],
            \'red'              :['#df5821',166],
            \'orange'           :['#df9515',172],
            \'amber'            :['#dbb94e',178],
            \'yellow'           :['#d8e020',184],
            \'paleyellow'       :['#d8e080',184],
            \'bushgreen'        :['#92be68',107],
            \'green'            :['#00b000', 34],
            \'grassgreen'       :['#8fe43f',112],
            \'lime'             :['#bfff00',1],
            \'neonlime'         :['#00ff00',1],
            \'mustard'          :['#c3c92d',142],
            \'stone'            :['#e4c5ac',223],
            \'skygray'          :['#c3b6b9',145],
            \'skybright'        :['#c3d9f1',153],
            \'skypale'          :['#d8edff',195],
            \'gray'             :['#a39397',102],
            \'indigo'           :['#ccb3d8',103],
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
            \'nordred'          :['#bf616a',  1],
            \'nordorange'       :['#d08770',  1],
            \'nordyellow'       :['#ebcb8b',  1],
            \'nordgreen'        :['#a3be8c',  1],
            \'nordpurple'       :['#b48ead',  1],
            \}
let s:c = {
    \'bg'               :['#010300', 234, '#000000', 1],
    \'brown'            :['#c07a4d', 130, '#888888', 1],
    \'main1'            :['#df5821', 166, '#ff4434', 1],
    \'main2'            :['#df9515', 172, '#ff8300', 1],
    \'main3'            :['#dbb94e', 178, '#ffb300', 1],
    \'nb1'              :['#d8e020', 184, '#ffed00', 1],
    \'nb2'              :['#d8e020', 184, '#ffe000', 1],
    \'nb2'              :['#d8e080', 184, '#d0d000', 1],
    \'bushgreen'        :['#92be68', 107, '#c0c000', 1],
    \'stringh'          :['#888888', 112, '#88ff18', 1],
    \'string'           :['#888888', 112, '#86e929', 1],
    \'stringl'          :['#888888', 112, '#71c423', 1],
    \'numberh'          :['#888888', 112, '#00f000', 1],
    \'number'           :['#888888', 112, '#00d000', 1],
    \'numberl'          :['#888888', 112, '#00b000', 1],
    \'constanth'        :['#888888', 112, '#bdff2d', 1],
    \'constant'         :['#888888', 112, '#ade929', 1],
    \'constantl'        :['#888888', 112, '#8aba21', 1],
    \'normalh'          :['#888888', 112, '#ffefe6', 1],
    \'normal'           :['#888888', 112, '#ecddd5', 1],
    \'normall'          :['#888888', 112, '#cabeb7', 1],
    \'noiseh'           :['#888888', 112, '#f7d6d6', 1],
    \'noise'            :['#888888', 112, '#dbbdbd', 1],
    \'noisel'           :['#888888', 112, '#c1a7a7', 1],
    \'commenth'         :['#888888', 112, '#dadada', 1],
    \'comment'          :['#888888', 112, '#c0c0c0', 1],
    \'commentl'         :['#888888', 112, '#a0a0a0', 1],
    \'alth'             :['#888888', 112, '#e0d3f3', 1],
    \'alt'              :['#888888', 112, '#cdc2df', 1],
    \'altl'             :['#888888', 112, '#b1a7c0', 1],
    \'brownh'           :['#888888', 112, '#f5af8a', 1],
    \'brown'            :['#888888', 112, '#d09576', 1],
    \'brownl'           :['#888888', 112, '#b07e63', 1],
    \'blueh'            :['#d8edff', 112, '#9edaff', 1],
    \'blue'             :['#c3d9f1', 112, '#7eceff', 1],
    \'bluel'            :['#888888', 112, '#70b7e3', 1],
    \'pinkh'            :['#888888', 112, '#ff6b8a', 1],
    \'pink'             :['#888888', 112, '#ff90a7', 1],
    \'pinkl'            :['#888888', 112, '#e17f93', 1],
    \'purpleh'          :['#888888', 112, '#ff82dc', 1],
    \'purple'           :['#c07cad', 112, '#ffa5e6', 1],
    \'purplel'          :['#888888', 112, '#e392cc', 1],
    \'lime'             :['#bfff00',   1, '#8aba21', 1],
    \'neonlime'         :['#00ff00',   1, '#888888', 1],
    \'mustard'          :['#c3c92d', 142, '#888888', 1],
    \'stone'            :['#e4c5ac', 223, '#888888', 1],
    \'skygray'          :['#c3b6b9', 145, '#888888', 1],
    \'skybright'        :['#c3d9f1', 153, '#888888', 1],
    \'skypale'          :['#d8edff', 195, '#888888', 1],
    \'gray'             :['#a39397', 102, '#888888', 1],
    \'indigo'           :['#ccb3d8', 103, '#888888', 1],
    \'bluegray'         :['#9c93a9', 103, '#888888', 1],
    \'purple'           :['#c07cad', 172, '#888888', 1],
    \'peach'            :['#e17f93', 210, '#888888', 1],
    \'isoerrorred'      :['#ff4434',   1, '#ff4434', 1],
    \'isowarningorange' :['#ff8300',   1, '#ff8300', 1],
    \'isocautionyellow' :['#ffed00',   1, '#ffed00', 1],
    \}
" {{{1 generic code
call s:hi('Boolean',                 'yellow')
call s:hi('Character',               'yellow')
call s:hi('Comment',                 'gray')
call s:hi('Conditional',             'yellow')
call s:hi('Constant',                'grassgreen')
call s:hi('Float',                   'green')
call s:hi('Debug',                   'fuchsia')
call s:hi('Define',                  'fuchsia')
call s:hi('Exception',               'brown')
call s:hi('Function',                'red')
call s:hi('Identifier',              'orange')         " print', end
call s:hi('Ignore',                  'fuchsia')
call s:hi('Include',                 'purple')         " import in python
call s:hi('Keyword',                 'indigo')         " print', end
call s:hi('Label',                   'orange')
call s:hi('Macro',                   'peach')
call s:hi('PreCondit',               'purple')
call s:hi('PreProc',                 'peach')        " bold
call s:hi('Repeat',                  'yellow')
call s:hi('Special',                 'comment')         " <leader> <c-u> etc
call s:hi('SpecialComment',          'fuchsia')
call s:hi('Statement',               'red')       " if not local return for in then
call s:hi('StorageClass',            'amber')
call s:hi('Structure',               'fuchsia')
call s:hi('Tag',                     'fuchsia')
call s:hi('Todo',                    'black', 'skybright')
call s:hi('Type',                    'brown')
call s:hi('Typedef',                 'fuchsia')
call s:hi('Underlined',              'fuchsia')
call s:hi('Noise',                   'noise')
" unoffical commonly used groups

" {{{1 html
call s:hi('htmltagname',            'orange')
call s:hi('htmltag',                'stone')
call s:hi('htmltagn',               'red')
call s:hi('htmlscripttag',          'stone')
call s:hi('htmlendtag',             'gray')
call s:hi('htmlarg',                'mustard')
call s:hi('htmlstring',             'grassgreen')
call s:hi('htmlspecialchar',        'yellow')
call s:hi('htmlspecialtagname',     'red')
call s:hi('htmlerror',              'white', 'errorred')
call s:hi('htmlvalue',              'green')
call s:hi('htmltagerror',           'fuchsia')
call s:hi('htmlevent',              'purple')
call s:hi('htmleventsq',            'fuchsia')
call s:hi('htmleventdq',            'peach')
call s:hi('htmlcssdefinition',      'fuchsia')
call s:hi('htmlcommentpart',        'gray')
call s:hi('htmlcommenterror',       'fuchsia')
call s:hi('htmlcomment',            'skygray')
call s:hi('htmlprestmt',            'fuchsia')
call s:hi('htmlpreerror',           'fuchsia')
call s:hi('htmlpreattr',            'fuchsia')
call s:hi('htmlpreproc',            'fuchsia')
call s:hi('htmlpreprocattrerror',   'fuchsia')
call s:hi('htmlpreprocattrname',    'fuchsia')
call s:hi('htmllink',               '', '', 'underline')
" font style groups don't need to be redefined
" call s:hi('htmlbold',               '', '', 'bold')
" call s:hi('htmlunderline',          '', '', 'underline')
" call s:hi('htmlstrike',             '', '', 'strikethrough')
" call s:hi('htmlitalic',             '', '', 'italic')
" call s:hi('htmlboldunderline',      '', '', 'bold,underline')
" call s:hi('htmlbolditalic',         '', '', 'bold,italic')
" call s:hi('htmlboldunderlineitalic','', '', 'bold,underline,italic')
" call s:hi('htmlbolditalicunderline','', '', 'bold,underline,italic')
" call s:hi('htmlunderlinebold',      '', '', 'bold,underline,italic')
" call s:hi('htmlunderlineitalic',    '', '', 'underline,italic')
" call s:hi('htmlunderlinebolditalic','', '', 'bold,underline,italic')
" call s:hi('htmlunderlineitalicbold','', '', 'bold,underline,italic')
" call s:hi('htmlitalicunderline',    '', '', 'italic,underline')
" call s:hi('htmlitalicbold',         '', '', 'italic,bold')
" call s:hi('htmlitalicboldunderline','', '', 'bold,underline,italic')
" call s:hi('htmlitalicunderlinebold','', '', 'bold,underline,italic')
call s:hi('htmlleadingspace',       'fuchsia')
call s:hi('htmlh2',                 'white')
call s:hi('htmlh1',                 'white')
call s:hi('htmlh3',                 'white')
call s:hi('htmlh4',                 'white')
call s:hi('htmlh5',                 'white')
call s:hi('htmlh6',                 'white')
call s:hi('htmltitle',              'white')
call s:hi('htmlhead',               'errorred')
call s:hi('htmlcssstylecomment',    'fuchsia')
call s:hi('htmlstylearg',           'fuchsia')
call s:hi('htmlhighlight',          'fuchsia')
call s:hi('htmlhighlightskip',      'fuchsia')
call s:hi('htmlstatement',          'fuchsia')
call s:hi('htmlspecial',            'fuchsia')

" {{{1 css
" chars
call s:hi('cssbraces',                  'stone')
call s:hi('cssnoise',                   'stone')
call s:hi('cssattrcomma',               'brightsky')
call s:hi('cssfunctioncomma',           'brightsky')
call s:hi('cssselectorop',              'brightsky')
call s:hi('cssfunction',                'brightsky')
call s:hi('cssselectorop2',             'green')
call s:hi('cssunicodeescape',           'yellow')

" main
call s:hi('cssprop',                    'amber')
call s:hi('cssvendor',                  'orange')
call s:hi('cssattr',                    'yellow')
call s:hi('cssattrregion',              'mustard')
call s:hi('cssdefinition',              'red') " doesnt seem to work
call s:hi('csspseudoclass',             'peach')
call s:hi('csspseudoclassid',           'peach')
call s:hi('csspseudoclassfn',           'peach')
call s:hi('cssstringq',                 'grassgreen')
call s:hi('cssstringqq',                'grassgreen')
call s:hi('cssimportant',               'red')
call s:hi('cssfunctionname',            'purple')
call s:hi('cssatrule',                  'skybright')

" selectors
call s:hi('csstagname',                 'red')
call s:hi('cssidentifier',              'purple', 'skydark09')
call s:hi('cssclassnamedot',            '#00ff00', '#405000')
call s:hi('cssclassname',               'grassgreen', '#405000')
call s:hi('cssattributeselector',       'grassgreen')

" values
call s:hi('cssvalueinteger',            'brightsky')
call s:hi('cssvaluenumber',             'brightsky')
call s:hi('cssvaluelength',             'brightsky')
call s:hi('cssvalueangle',              'brightsky')
call s:hi('cssvaluetime',               'brightsky')
call s:hi('cssunitdecorators',          'skygray')
call s:hi('csscomment',                 'gray')
call s:hi('csscolor',                   '#bfff00')
call s:hi('cssvaluefrequency',          'fuchsia')
call s:hi('htmlcssdefinition',          'fuchsia')
call s:hi('cssstyle',                   'fuchsia')
call s:hi('htmlcssstylecomment',        'fuchsia')
call s:hi('csscustomprop',              'fuchsia')
call s:hi('cssurl',                     'fuchsia')
" call s:hi('cssgradientattr',            'fuchsia')
" call s:hi('csscommonattr',              'fuchsia')
" call s:hi('cssanimationprop',           'fuchsia')
" call s:hi('cssanimationattr',           'fuchsia')
" call s:hi('cssbackgroundprop',          'fuchsia')
" call s:hi('cssbackgroundattr',          'fuchsia')
" call s:hi('cssborderprop',              'fuchsia')
" call s:hi('cssborderattr',              'fuchsia')
" call s:hi('cssboxprop',                 'fuchsia')
" call s:hi('cssboxattr',                 'fuchsia')
" call s:hi('csscascadeprop',             'fuchsia')
" call s:hi('csscascadeattr',             'fuchsia')
" call s:hi('csscolorprop',               'fuchsia')
" call s:hi('cssdimensionprop',           'fuchsia')
" call s:hi('cssflexibleboxprop',         'fuchsia')
" call s:hi('cssflexibleboxattr',         'fuchsia')
" call s:hi('cssfontprop',                'fuchsia')
" call s:hi('cssfontattr',                'fuchsia')
" call s:hi('cssmulticolumnprop',         'fuchsia')
" call s:hi('cssmulticolumnattr',         'fuchsia')
" call s:hi('cssinteractprop',            'fuchsia')
" call s:hi('cssinteractattr',            'fuchsia')
" call s:hi('cssgeneratedcontentprop',    'fuchsia')
" call s:hi('cssgeneratedcontentattr',    'fuchsia')
" call s:hi('cssgridprop',                'fuchsia')
" call s:hi('csshyerlinkprop',            'fuchsia')
" call s:hi('csslistprop',                'fuchsia')
" call s:hi('csslistattr',                'fuchsia')
" call s:hi('csspositioningprop',         'fuchsia')
" call s:hi('csspositioningattr',         'fuchsia')
" call s:hi('cssprintattr',               'fuchsia')
" call s:hi('csstableprop',               'fuchsia')
" call s:hi('csstableattr',               'fuchsia')
" call s:hi('csstextprop',                'fuchsia')
" call s:hi('csstextattr',                'fuchsia')
" call s:hi('csstransformprop',           'fuchsia')
" call s:hi('csstransitionprop',          'fuchsia')
" call s:hi('csstransitionattr',          'fuchsia')
" call s:hi('cssuiprop',                  'fuchsia')
" call s:hi('cssuiattr',                  'fuchsia')
" call s:hi('cssieuiattr',                'fuchsia')
" call s:hi('cssieuiprop',                'fuchsia')
" call s:hi('cssauralprop',               'fuchsia')
" call s:hi('cssauralattr',               'fuchsia')
" call s:hi('cssmobiletextprop',          'fuchsia')
" call s:hi('cssmediaprop',               'fuchsia')
" call s:hi('cssmediaattr',               'fuchsia')
" call s:hi('csskeyframeprop',            'fuchsia')
" call s:hi('csspagemarginprop',          'fuchsia')
" call s:hi('csspageprop',                'fuchsia')
" call s:hi('cssfontdescriptorprop',      'fuchsia')
" call s:hi('cssfontdescriptorattr',      'fuchsia')
call s:hi('csserror',                   'fuchsia')
call s:hi('csshacks',                   'fuchsia')
call s:hi('cssbraceerror',              'fuchsia')
call s:hi('cssspecialcharqq',           'fuchsia')
call s:hi('cssspecialcharq',            'fuchsia')
call s:hi('cssatkeyword',               'skybright')
call s:hi('cssatrulelogical',           'skypale')
call s:hi('cssmediatype',               'skypale')
call s:hi('csspagepseudo',              'fuchsia')
call s:hi('cssdeprecated',              'fuchsia')
" call s:hi('csscontentforpagedmediaprop','fuchsia')
" call s:hi('csslineboxprop',             'fuchsia')
" call s:hi('cssmarqueeprop',             'fuchsia')
" call s:hi('csspagedmediaprop',          'fuchsia')
" call s:hi('cssprintprop',               'fuchsia')
" call s:hi('cssrubyprop',                'fuchsia')
" call s:hi('cssspeechprop',              'fuchsia')
" call s:hi('cssrenderprop',              'fuchsia')
" call s:hi('csscontentforpagedmediaattr','fuchsia')
" call s:hi('cssdimensionattr',           'fuchsia')
" call s:hi('cssgridattr',                'fuchsia')
" call s:hi('csshyerlinkattr',            'fuchsia')
" call s:hi('csslineboxattr',             'fuchsia')
" call s:hi('cssmarginattr',              'fuchsia')
" call s:hi('cssmarqueeattr',             'fuchsia')
" call s:hi('csspaddingattr',             'fuchsia')
" call s:hi('csspagedmediaattr',          'fuchsia')
" call s:hi('cssrubyattr',                'fuchsia')
" call s:hi('cssspeechattr',              'fuchsia')
" call s:hi('csstransformattr',           'fuchsia')
" call s:hi('cssrenderattr',              'fuchsia')
call s:hi('csspseudoclasslang',         'fuchsia')
call s:hi('cssmediacomma',              'fuchsia')
call s:hi('cssfontdescriptor',          'fuchsia')
call s:hi('cssunicoderange',            'fuchsia')
call s:hi('csslength',                  'fuchsia')
call s:hi('cssstring',                  'fuchsia')
" call s:hi('csspagingprop',              'fuchsia')
call s:hi('scsscomment',                'gray')
call s:hi('sassdefault',                'fuchsia')
call s:hi('sasscssattribute',           'fuchsia')
call s:hi('sasscsscomment',             'gray')

" {{{1 javascript
call s:hi('javascriptstrings',              'grassgreen')
call s:hi('javascriptglobal',               'yellow')
call s:hi('javascriptfunction',             'red')
" call s:hi('javascriptexpression',           'fuchsia')
" call s:hi('javascript',                     'purple')
" call s:hi('javascriptcommenttodo',          'fuchsia')
" call s:hi('javascriptlinecomment',          'gray')
" call s:hi('javascriptcommentskip',          'fuchsia')
" call s:hi('javascriptcomment',              'bluegray')
" call s:hi('javascriptspecial',              'fuchsia')
" call s:hi('javascriptstringd',              'fuchsia')
" call s:hi('javascriptembed',                'fuchsia')
" call s:hi('javascriptstringt',              'fuchsia')
" call s:hi('javascriptspecialcharacter',     'fuchsia')
" call s:hi('javascriptnumber',               'green')
" call s:hi('javascriptregexpstring',         'fuchsia')
" call s:hi('javascriptconditional',          'yellow')
" call s:hi('javascriptrepeat',               'fuchsia')
" call s:hi('javascriptbranch',               'fuchsia')
" call s:hi('javascriptoperator',             'fuchsia')
" call s:hi('javascripttype',                 'fuchsia')
" call s:hi('javascriptstatement',            'fuchsia')
" call s:hi('javascriptboolean',              'fuchsia')
" call s:hi('javascriptnull',                 'fuchsia')
" call s:hi('javascriptidentifier',           'fuchsia')
" call s:hi('javascriptlabel',                'fuchsia')
" call s:hi('javascriptexception',            'fuchsia')
" call s:hi('javascriptmessage',              'fuchsia')
" call s:hi('javascriptmember',               'orange')
" call s:hi('javascriptdeprecated',           'fuchsia')
" call s:hi('javascriptreserved',             'fuchsia')
" " hi! link javascriptfunction function
" call s:hi('javascriptbraces',               'lime')
" call s:hi('javascriptparens',               'stone')
" call s:hi('javascriptcharacter',            'fuchsia')
" call s:hi('javascriptvalue',                'fuchsia')
" call s:hi('javascripterror',                'fuchsia')
" call s:hi('javascrparenerror',              'fuchsia')
" call s:hi('javascriptdebug',                'fuchsia')
" call s:hi('javascriptconstant',             'fuchsia')

" {{{1 vim-javascript
" jsnoise        xxx links to noise
call s:hi('jsobjectprop',           'paleyellow')
" jsobjectprop   xxx cleared
call s:hi('jsfunccall',           'mustard')
" jsfunccall     xxx links to function
" jsprototype    xxx links to special
" jstaggedtemplate xxx links to storageclass
" jsdot          xxx links to noise
" jsparenserror  xxx links to error
" jsstorageclass xxx links to storageclass
" jsdestructuringblock xxx cleared
" jsdestructuringarray xxx cleared
" jsvariabledef  xxx cleared
" jsflowdefinition xxx cleared
" jsoperatorkeyword xxx links to jsoperator
call s:hi('jsoperator',           'stone')
" jsoperator     xxx links to operator
" jsbooleantrue  xxx links to boolean
" jsbooleanfalse xxx links to boolean
" jsimport       xxx links to include
" jsmoduleasterisk xxx links to noise
" jsmodulekeyword xxx cleared
" jsmodulegroup  xxx cleared
" jsflowimporttype xxx cleared
" jsexport       xxx links to include
" jsexportdefault xxx links to storageclass
" jsflowtypestatement xxx cleared
" jsmoduleas     xxx links to include
" jsfrom         xxx links to include
" jsmodulecomma  xxx links to jsnoise
" jsexportdefaultgroup xxx links to jsexportdefault
" jsstring       xxx links to string
" jsflowtypekeyword xxx cleared
" jsspecial      xxx links to special
" jstemplateexpression xxx cleared
" jstemplatestring xxx links to string
" jsnumber       xxx links to number
" jsfloat        xxx links to float
" jstemplatebraces xxx links to noise
" jsregexpcharclass xxx links to character
" jsregexpboundary xxx links to specialchar
" jsregexpbackref xxx links to specialchar
" jsregexpquantifier xxx links to specialchar
" jsregexpor     xxx links to conditional
" jsregexpmod    xxx links to specialchar
" jsregexpgroup  xxx links to jsregexpstring
" jsregexpstring xxx links to string
" jsobjectseparator xxx links to noise
" jsobjectshorthandprop xxx links to jsobjectkey
" jsfunctionkey  xxx cleared
" jsobjectvalue  xxx cleared
" jsobjectkey    xxx cleared
" jsobjectkeystring xxx links to string
" jsbrackets     xxx links to noise
" jsfuncargs     xxx cleared
" jsobjectkeycomputed xxx cleared
" jsobjectcolon  xxx links to jsnoise
" jsobjectfuncname xxx links to function
" jsobjectmethodtype xxx links to type
" jsobjectstringkey xxx links to string
" jsnull         xxx links to type
" jsreturn       xxx links to statement
" jsundefined    xxx links to type
" jsnan          xxx links to number
" jsthis         xxx links to special
" jssuper        xxx links to constant
" jsblock        xxx cleared
" jsblocklabel   xxx links to identifier
" jsblocklabelkey xxx links to jsblocklabel
" jsstatement    xxx links to statement
" jsconditional  xxx links to conditional
" jsparenifelse  xxx cleared
" jscommentifelse xxx links to jscomment
" jsifelseblock  xxx cleared
" jsparenswitch  xxx cleared
" jsrepeat       xxx links to repeat
call s:hi('jsrepeat',           'peach')
" jsparenrepeat  xxx cleared
" jsforawait     xxx links to keyword
" jsdo           xxx links to repeat
" jsrepeatblock  xxx cleared
" jslabel        xxx links to label
" jsswitchcolon  xxx links to noise
" jsswitchcase   xxx cleared
" jstry          xxx links to exception
" jstrycatchblock xxx cleared
" jsfinally      xxx links to exception
" jsfinallyblock xxx cleared
" jscatch        xxx links to exception
" jsparencatch   xxx cleared
" jsexception    xxx links to exception
" jsasynckeyword xxx links to keyword
" jsswitchblock  xxx cleared
call s:hi('jsglobalobjects',           'indigo')
" jsglobalobjects xxx links to constant
" jsglobalnodeobjects xxx links to constant
" jsexceptions   xxx links to constant
" jsbuiltins     xxx links to constant
" jsfuturekeys   xxx cleared
" jsdomerrno     xxx links to constant
" jsdomnodeconsts xxx links to constant
" jshtmlevents   xxx links to special
" jsspreadexpression xxx cleared
" jsbracket      xxx cleared
" jsparens       xxx links to noise
" jsparen        xxx cleared
" jsparensdecorator xxx links to jsparens
" jsparendecorator xxx cleared
" jsparensifelse xxx links to jsparens
" jsparensrepeat xxx links to jsparens
" jscommentrepeat xxx links to jscomment
" jsparensswitch xxx links to jsparens
" jsparenscatch  xxx links to jsparens
" jsfuncparens   xxx links to noise
" jsfuncargcommas xxx cleared
" jscomment      xxx links to comment
" jsfuncargexpression xxx cleared
" jsrestexpression xxx links to jsfuncargs
" jsflowargumentdef xxx cleared
" jscommentfunction xxx links to jscomment
" call s:hi('jsfuncblock',           'purple')
" jsfuncblock    xxx cleared
" jsflowreturn   xxx cleared
" jsclassbraces  xxx links to noise
" jsclassfuncname xxx links to jsfuncname
" jsclassmethodtype xxx links to type
call s:hi('jsarrowfunction',           'peach')
" jsarrowfunction xxx links to type
" jsarrowfuncargs xxx links to jsfuncargs
" jsgenerator    xxx links to jsfunction
" jsdecorator    xxx links to special
" jsclassproperty xxx links to jsobjectkey
" jsclasspropertycomputed xxx cleared
" jsclassstringkey xxx links to string
" jsclassblock   xxx cleared
call s:hi('jsfuncbraces',           'red')
" jsfuncbraces   xxx links to noise
call s:hi('jsifelsebraces',           'yellow')
" jstrycatchbraces xxx links to noise
" jsfinallybraces xxx links to noise
" jsifelsebraces xxx links to noise
" jsswitchbraces xxx links to noise
call s:hi('jsrepeatbraces',           'peach')
" jsrepeatbraces xxx links to noise
" jsdestructuringbraces xxx links to noise
" jsdestructuringproperty xxx links to jsfuncargs
" jsdestructuringassignment xxx links to jsobjectkey
" jsdestructuringnoise xxx links to noise
" jsdestructuringpropertycomputed xxx cleared
" jsdestructuringpropertyvalue xxx cleared
" jsobjectbraces xxx links to noise
" jsobject       xxx cleared
" jsbraces       xxx links to noise
" jsmodulebraces xxx links to noise
" jsspreadoperator xxx links to operator
" jsrestoperator xxx links to operator
" jsternaryifoperator xxx links to operator
" jsternaryif    xxx cleared
call s:hi('jsfuncname',           'orange')
" jsfuncname     xxx links to function
" jsflowfunctiongroup xxx cleared
" jsfuncargoperator xxx links to jsfuncargs
" jsarguments    xxx links to special
call s:hi('jsfunction',           'red')
" jsfunction     xxx links to type
" jsclasskeyword xxx links to keyword
" jsextendskeyword xxx links to keyword
" jsclassnoise   xxx links to noise
" jsflowclassfunctiongroup xxx cleared
" jsflowclassgroup xxx cleared
" jscommentclass xxx links to jscomment
" jsclassdefinition xxx links to jsfuncname
" jsclassvalue   xxx cleared
" jsflowclassdef xxx cleared
" jsdestructuringvalue xxx cleared
" jsdestructuringvalueassignment xxx cleared
" jscommenttodo  xxx links to todo
" jsenvcomment   xxx links to preproc
" jsdecoratorfunction xxx links to function
" jscharacter    xxx links to character
" jsbranch       xxx links to conditional
" jserror        xxx links to error
" jsof           xxx links to operator
" jsdomelemattrs xxx links to label
" jsdomelemfuncs xxx links to preproc
" jshtmlelemattrs xxx links to label
" jshtmlelemfuncs xxx links to preproc
" jscssstyles    xxx links to label

" {{{1 python
" these hi groups retain original links to generic coding scheme
" comment call s:" links to comment hi('pythoncomment',          'gray')
" include call s:hi('pythoninclude',          'purple')         " import in python
" statement call s:hi('pythonstatement',        'red')       " if not local return for in then
" function call s:hi('pythonfunction',         'orange')
" conditional call s:hi('pythonconditional',      'yellow')
" repeat call s:hi('pythonrepeat',           'yellow')
" exception call s:hi('pythonexception',        'brown')
" todo - call s:hi('pythontodo',             'black', 'skybright')
" type - call s:hi('pythontype',             'fuchsia')    " {}
call s:hi('pythonstring',           'grassgreen')
call s:hi('pythonquotes',           'green')
call s:hi('pythontriplequotes',     'green')
call s:hi('pythonoperator',         'mustard')
call s:hi('pythonexceptions',       'red')
call s:hi('pythonescape',           'yellow')
call s:hi('pythonnumber',           'green')
call s:hi('pythonbuiltin',          'bluegray')
call s:hi('pythondecorator',        'purple')
call s:hi('pythondecoratorname',    'peach')
call s:hi('pythonrawstring',        'bushgreen')
call s:hi('pythonspaceerror',       'white', 'errorred')
" dont know what these are for
call s:hi('pythonspecial',          'fuchsia')         " <leader> <c-u> etc
call s:hi('pythonidentifier',       'fuchsia')         " print, end
call s:hi('pythonpreproc',          'fuchsia')        " bold
call s:hi('pythontitle',            'fuchsia')        " <leader> <c-u> etc
call s:hi('pythonerror',            'fuchsia')
call s:hi('pythonasync',            'fuchsia')
call s:hi('pythonattribute',        'fuchsia')
call s:hi('pythondoctest',          'fuchsia')
call s:hi('pythondoctestvalue',     'fuchsia')
call s:hi('pythonmatrixmultiply',   'fuchsia')
call s:hi('pythonsync',             'fuchsia')

" {{{1 django
call s:hi('djangoerror',            'fuchsia'   ,'#404050')
call s:hi('djangotagblock',         'brightsky' ,'#404050')
call s:hi('djangofilter',           'brightsky' ,'#404050')
call s:hi('djangostatement',        'peach'     ,'#404050')
call s:hi('djangoargument',         'purple'    ,'#404050')
call s:hi('djangovarblock',         'purple'    ,'#404050')
call s:hi('djangotodo',             'fuchsia'   ,'#404050')
call s:hi('djangotagerror',         'fuchsia'   ,'#404050')
call s:hi('djangovarerror',         'fuchsia'   ,'#404050')
call s:hi('djangocomment',          'fuchsia'   ,'#404050')
call s:hi('djangocomblock',         'gray'      ,'#404050')

" {{{1 json
call s:hi('jsonkeyword',           'nordpurple')
call s:hi('jsonquote',           'skygray')

" {{{1 viml
" call s:hi('vimtodo',                'fuchsia')
call s:hi('vimcommand',             'red')
" call s:hi('vimonlycommand',         'fuchsia')
" call s:hi('vimstdplugin',           'fuchsia')
" call s:hi('vimonlyoption',          'fuchsia')
" call s:hi('vimtermoption',          'fuchsia')
" call s:hi('vimerrsetting',          'fuchsia')
call s:hi('vimgroup',               'lime')
call s:hi('vimhlgroup',             'skybright')
" call s:hi('vimonlyhlgroup',         'fuchsia')
" call s:hi('vimglobal',              'fuchsia')
" call s:hi('vimsubst',               'fuchsia')
call s:hi('vimcomment',             'gray')
call s:hi('vimnumber',              'green')
call s:hi('vimaddress',             'brightsky')
call s:hi('vimautocmd',             'orange')
call s:hi('vimecho',                'gray')
call s:hi('vimiscommand',           'yellow')
" call s:hi('vimextcmd',              'fuchsia')
" call s:hi('vimfilter',              'fuchsia')
call s:hi('vimlet',                 'purple')
call s:hi('vimmap',                 'red')
" call s:hi('vimmark',                'fuchsia')
call s:hi('vimset',                 'brightsky')
" call s:hi('vimsyntax',              'fuchsia')
call s:hi('vimusercmd',             'grau')
call s:hi('vimcmdsep',              'stone')
call s:hi('vimvar',                 'stone')
call s:hi('vimfbvar',               'purple')
" call s:hi('viminsert',              'fuchsia')
call s:hi('vimbehavemodel',         'brightsky')
" call s:hi('vimbehaveerror',         'fuchsia')
call s:hi('vimbehave',              'red')
call s:hi('vimftcmd',               'peach')
call s:hi('vimftoption',            'purple')
" call s:hi('vimfterror',             'fuchsia')
" call s:hi('vimfiletype',            'fuchsia')
call s:hi('vimaugroup',             'brightsky')
" call s:hi('vimexecute',             'fuchsia')
call s:hi('vimnotfunc',             'yellow')
call s:hi('vimfuncname',            'stone')
call s:hi('vimfunction',            'orange')
" call s:hi('vimfunctionerror',       'fuchsia')
call s:hi('vimlinecomment',         'gray')
call s:hi('vimspecfile',            'mustard')
call s:hi('vimoper',                'stone')
call s:hi('vimoperparen',           'brightsky')
call s:hi('vimstring',              'grassgreen')
" call s:hi('vimregister',            'fuchsia')
" call s:hi('vimcmplxrepeat',         'fuchsia')
" call s:hi('vimregion',              'fuchsia')
" call s:hi('vimsynline',             'fuchsia')
call s:hi('vimnotation',            'mustard')
" call s:hi('vimctrlchar',            'fuchsia')
call s:hi('vimfuncvar',             'skypale')
call s:hi('vimcontinue',            'gray')
call s:hi('vimsetequal',            'brightsky')
call s:hi('vimoption',              'amber')
call s:hi('vimaugroupkey',          'red')
" call s:hi('vimaugrouperror',        'fuchsia')
" call s:hi('vimenvvar',              'fuchsia')
" call s:hi('vimfunc',                'fuchsia')
call s:hi('vimparensep',            'gray')
call s:hi('vimsep',                 'lime')
" call s:hi('vimopererror',           'fuchsia')
" call s:hi('vimfunckey',             'fuchsia')
" call s:hi('vimfuncsid',             'fuchsia')
" call s:hi('vimabb',                 'fuchsia')
call s:hi('vimechohl',              'amber')
call s:hi('vimhighlight',           'peach')
call s:hi('vimnorm',                'red')
" call s:hi('vimsearch',              'fuchsia')
" call s:hi('vimunmap',               'fuchsia')
call s:hi('vimusercommand',         'red')
call s:hi('vimfuncbody',            'purple')
" call s:hi('vimfuncblank',           'fuchsia')
" call s:hi('vimpattern',             'fuchsia')
" call s:hi('vimspecfilemod',         'fuchsia')
" call s:hi('vimescapebrace',         'fuchsia')
" call s:hi('vimsetstring',           'fuchsia')
" call s:hi('vimsubstrep',            'fuchsia')
" call s:hi('vimsubstrange',          'fuchsia')
" call s:hi('vimuserattrb',           'fuchsia')
" call s:hi('vimuserattrberror',      'fuchsia')
" call s:hi('vimuserattrbkey',        'fuchsia')
" call s:hi('vimuserattrbcmplt',      'fuchsia')
" call s:hi('vimusercmderror',        'fuchsia')
" call s:hi('vimuserattrbcmpltfunc',  'fuchsia')
call s:hi('vimcommentstring',       'bluegray')
" call s:hi('vimpatseperr',           'fuchsia')
" call s:hi('vimpatsep',              'fuchsia')
" call s:hi('vimpatsepz',             'fuchsia')
" call s:hi('vimpatsepzone',          'fuchsia')
" call s:hi('vimpatsepr',             'fuchsia')
" call s:hi('vimpatregion',           'fuchsia')
" call s:hi('vimnotpatsep',           'fuchsia')
call s:hi('vimstringend',           'grassgreen')
" call s:hi('vimstringcont',          'fuchsia')
" call s:hi('vimsubsttwobs',          'fuchsia')
" call s:hi('vimsubstsubstr',         'fuchsia')
" call s:hi('vimcollection',          'fuchsia')
call s:hi('vimsubstpat',            'yellow')
call s:hi('vimsubst1',              'brightsky')
" call s:hi('vimsubst2',              'fuchsia')
call s:hi('vimsubstdelim',          'neonlime')
call s:hi('vimsubstrep4',           'brightsky')
" call s:hi('vimsubstflagerr',        'fuchsia')
" call s:hi('vimcollclass',           'fuchsia')
" call s:hi('vimcollclasserr',        'fuchsia')
call s:hi('vimsubstflags',          'bushgreen')
" call s:hi('vimmarknumber',          'fuchsia')
" call s:hi('vimplainmark',           'fuchsia')
" call s:hi('vimrange',               'fuchsia')
" call s:hi('vimplainregister',       'fuchsia')
" call s:hi('vimsetmod',              'fuchsia')
call s:hi('vimsetsep',              'stone')
call s:hi('vimmapmod',              'lime')
call s:hi('vimmaplhs',              'orange')
call s:hi('vimautoevent',           'yellow')
" call s:hi('vimautocmdspace',        'fuchsia')
" call s:hi('vimautoeventlist',       'fuchsia')
call s:hi('vimautocmdsfxlist',      'brightwhite')
call s:hi('vimechohlnone',          'bluegray')
call s:hi('vimmapbang',             'orange')
call s:hi('vimmaprhs',              'yellow')
" call s:hi('vimmapmoderr',           'fuchsia')
call s:hi('vimmapmodkey',           'lime')
" call s:hi('vimmaprhsextend',        'fuchsia')
" call s:hi('vimmenubang',            'fuchsia')
" call s:hi('vimmenupriority',        'fuchsia')
" call s:hi('vimmenuname',            'fuchsia')
" call s:hi('vimmenumod',             'fuchsia')
" call s:hi('vimmenunamemore',        'fuchsia')
" call s:hi('vimmenumap',             'fuchsia')
" call s:hi('vimmenurhs',             'fuchsia')
" call s:hi('vimbracket',             'stone')
" call s:hi('vimuserfunc',            'peach')
" call s:hi('vimelseiferr',           'fuchsia')
" call s:hi('vimbufnrwarn',           'fuchsia')
call s:hi('vimnormcmds',            'brightsky')
" call s:hi('vimgroupspecial',        'fuchsia')
" call s:hi('vimgrouplist',           'fuchsia')
" call s:hi('vimsynerror',            'fuchsia')
" call s:hi('vimsyncontains',         'fuchsia')
" call s:hi('vimsynkeycontainedin',   'fuchsia')
" call s:hi('vimsynnextgroup',        'fuchsia')
call s:hi('vimsyntype',             'brightsky')
" call s:hi('vimausyntax',            'fuchsia')
" call s:hi('vimsyncase',             'fuchsia')
" call s:hi('vimsyncaseerror',        'fuchsia')
" call s:hi('vimclustername',         'fuchsia')
" call s:hi('vimgroupname',           'fuchsia')
" call s:hi('vimgroupadd',            'fuchsia')
" call s:hi('vimgrouprem',            'fuchsia')
" call s:hi('vimisklist',             'fuchsia')
" call s:hi('vimisksep',              'fuchsia')
" call s:hi('vimsynkeyopt',           'fuchsia')
" call s:hi('vimsynkeyregion',        'fuchsia')
" call s:hi('vimmtchcomment',         'fuchsia')
" call s:hi('vimsynmtchopt',          'fuchsia')
" call s:hi('vimsynregpat',           'fuchsia')
" call s:hi('vimsynmatchregion',      'fuchsia')
" call s:hi('vimsynmtchcchar',        'fuchsia')
" call s:hi('vimsynmtchgroup',        'fuchsia')
" call s:hi('vimsynpatrange',         'fuchsia')
" call s:hi('vimsynnotpatrange',      'fuchsia')
" call s:hi('vimsynregopt',           'fuchsia')
" call s:hi('vimsynreg',              'fuchsia')
" call s:hi('vimsynmtchgrp',          'fuchsia')
" call s:hi('vimsynregion',           'fuchsia')
" call s:hi('vimsynpatmod',           'fuchsia')
" call s:hi('vimsyncc',               'fuchsia')
" call s:hi('vimsynclines',           'fuchsia')
" call s:hi('vimsyncmatch',           'fuchsia')
" call s:hi('vimsyncerror',           'fuchsia')
" call s:hi('vimsynclinebreak',       'fuchsia')
" call s:hi('vimsynclinecont',        'fuchsia')
" call s:hi('vimsyncregion',          'fuchsia')
" call s:hi('vimsyncgroupname',       'fuchsia')
" call s:hi('vimsynckey',             'fuchsia')
" call s:hi('vimsyncgroup',           'fuchsia')
" call s:hi('vimsyncnone',            'fuchsia')
" call s:hi('vimhilink',              'fuchsia')
call s:hi('vimhiclear',             'brightwhite')
call s:hi('vimhikeylist',           'stone')
" call s:hi('vimhictermerror',        'fuchsia')
call s:hi('vimhibang',              'orange')
call s:hi('vimhigroup',             'lime')
call s:hi('vimhiattrib',            'peach')
call s:hi('vimfgbgattrib',          'lightpink')
" call s:hi('vimhiattriblist',        'fuchsia')
" call s:hi('vimhictermcolor',        'fuchsia')
" call s:hi('vimhifontname',          'fuchsia')
" call s:hi('vimhiguifontname',       'fuchsia')
call s:hi('vimhiguirgb',            'brightsky')
" call s:hi('vimhiblend',             'fuchsia')
" call s:hi('vimhiterm',              'fuchsia')
call s:hi('vimhicterm',             'amber')
" call s:hi('vimhistartstop',         'fuchsia')
call s:hi('vimhictermfgbg',         'amber')
call s:hi('vimhigui',               'orange')
" call s:hi('vimhiguifont',           'fuchsia')
call s:hi('vimhiguifgbg',           'orange')
" call s:hi('vimhitermcap',           'fuchsia')
" call s:hi('vimhikeyerror',          'fuchsia')
call s:hi('vimhinmbr',              'green')
call s:hi('vimcommenttitle',        'brightsky')
" call s:hi('vimcommenttitleleader',  'fuchsia')
" call s:hi('vimsearchdelim',         'fuchsia')
" call s:hi('vimembederror',          'fuchsia')
" call s:hi('vimaugroupsynca',        'fuchsia')
" call s:hi('vimerror',               'fuchsia')
" call s:hi('vimkeycodeerror',        'fuchsia')
" call s:hi('vimwarn',                'fuchsia')
" call s:hi('vimauhighlight',         'fuchsia')
" call s:hi('vimautocmdopt',          'fuchsia')
" call s:hi('vimautoset',             'fuchsia')
" call s:hi('vimcondhl',              'fuchsia')
" call s:hi('vimelseif',              'fuchsia')
" call s:hi('vimfold',                'fuchsia')
" call s:hi('vimsynoption',           'fuchsia')
" call s:hi('vimhlmod',               'fuchsia')
" call s:hi('vimkeycode',             'fuchsia')
" call s:hi('vimkeyword',             'fuchsia')
" call s:hi('vimscriptdelim',         'fuchsia')
" call s:hi('vimspecial',             'fuchsia')
" call s:hi('vimstatement',           'fuchsia')

" {{{1 cursor
" windows terminal overrides these settings
" hi cursor               guifg=bg guibg=fg
" hi! link cursorim cursor                           " dont know what cursor ime mode is
" hi! link lcursor cursor                            " dont know what cursor ime mode is

" {{{1 line numbers
hi linenr               guifg=#aab0a8 guibg=#404040 gui=bold,italic " line number colour
hi cursorlinenr         guifg=#202020 guibg=#89b43f gui=bold " cursor line number colour
hi signcolumn                         guibg=#000000 " to the left of number line

" {{{1 built in visual enhancements
hi nontext              guifg=#555555               " hidden characters from set list
hi colorcolumn                        guibg=#404040 " 80 chars wide column
hi cursorcolumn         guifg=none    guibg=#181818 " a vertical line that follows custor, enable with :set cursorcolumn
hi incsearch            guifg=#000000 guibg=#ffff00 gui=bold " while one is typing search pattern
hi search               guifg=#000000 guibg=#cf9f00          " other search matches

" {{{1 cursor line
hi cursorline                         guibg=#444444 " the current cursor line highlighting, works!
augroup mytheme_cursorline
    autocmd!
    autocmd insertenter * hi cursorline guibg=#550000 " change color when entering insert mode
    autocmd insertleave * hi cursorline guibg=#4f4f4f " revert color to default when leaving insert mode, should match colour above
augroup end

" {{{1 cmd line
" cmdline = the command line window at the bottom
" cmdwin  = q: or q/ or q? windows
hi _cmdnormal           guifg=#ffffff guibg=#000044
hi _cmdlinenr           guifg=#a0a0a0 guibg=#000000 " line number colour
hi _cmdcursorlinenr     guifg=#000080 guibg=#ffffff  gui=bold " cursor line number colour
" doesnt work well on windows
" augroup mythemecmdline
"     autocmd!
"     autocmd cmdlineenter * set winhighlight=normal:_cmdnormal,linenr:_cmdlinenr,cursorlinenr:_cmdcursorlinenr | redraw
"     autocmd cmdlineleave * set winhighlight=normal:normal,linenr:linenr,cursorlinenr:cursorlinenr | redraw
" augroup end

