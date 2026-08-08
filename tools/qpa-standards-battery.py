import re,io,sys,os
from collections import Counter
GUARD=('grepl','identical','regexpr','sapply','labels_needed','all.equal','gsub','paste(')
PLACE=re.compile(r'(___|\..\.|value\)|variable_name|value_you_choose|yourmodel|yourdata|x_variable|group_variable|outcome ~|predictor,|x label|y label|level name|selection_variable|variable_you_want|attention|guides\(fill = "none"\))')
MECH={'exercise-predict-2','exercise-predict-ghg2'}
def _norm(s):
    s=s.lower().strip()
    return s[:-1] if s.endswith('s') and not s.endswith('ss') else s

def run(f):
    t=io.open(f,encoding='utf-8').read(); L=t.split('\n'); F=[]
    num=os.path.basename(f)[:2]
    def bad(sec,msg): F.append(f"§{sec}  {msg}")
    labels=[(i,x) for i,x in enumerate(L) if re.match(r'^\*\*(Practice|Run and observe|Apply|Explore) \d+:',x)]
    exs=[(i,re.match(r'```\{r ([^,}]+)',x).group(1)) for i,x in enumerate(L) if 'exercise=TRUE' in x]
    qs=[(i,re.match(r'```\{r ([^,}]+)',x).group(1)) for i,x in enumerate(L) if re.match(r'```\{r ',x) and 'echo=FALSE' in x and 'exercise' not in x]
    def body(i):
        j=i+1; b=[]
        while not L[j].startswith('```'): b.append(L[j]); j+=1
        return '\n'.join(b)
    # ---- 1
    codegraders=0
    for gi,gl in enumerate(L):
        if not re.match(r'```\{r [a-z0-9-]+-check\}',gl): continue
        gj=gi+1; gb=[]
        while gj<len(L) and not L[gj].startswith('```'): gb.append(L[gj]); gj+=1
        if '.user_code' in '\n'.join(gb): codegraders+=1
    if len(re.findall(r'gsub\("#\[\^\\r\\n\]\*"',t))<codegraders: bad(1,"comment-strip form missing in a code-inspecting grader")
    if len(re.findall(r'collapse\s*=\s*"\\n"',t))<codegraders: bad(1,"collapse separator missing in a code-inspecting grader")
    if 'grade_result(' in t: bad(1,"grade_result used")
    # within-tutorial pointers are permitted (her ruling, 8 Aug); what is not:
    # pointing at the NEXT ITEM, asking for work after passing, or naming another tutorial
    fwd=re.compile(r'(the next question|the next exercise|the question below|before moving on|before answering the next|in the next tutorial|Tutorial \d+ will)',re.I)
    for m in re.finditer(r'\b(pass|correct|message|try_again)\s*=?\s*\(?"((?:[^"\\]|\\.)*)"',t):
        if fwd.search(m.group(2)): bad(1,f"forward-pointing at line {t[:m.start()].count(chr(10))+1}")
    hooks=[re.match(r'([^.!]*[.!])',m).group(1) for m in re.findall(r'pass\("((?:[^"\\]|\\.)*)"',t)]
    if hooks and Counter(hooks).most_common(1)[0][1] > max(3,len(hooks)*0.6): bad(1,f"pass hooks monotonous {Counter(hooks).most_common()}")
    for i,n in exs:
        k=[x for x,y in enumerate(L) if y.startswith('```{r '+n+'-check}')]
        if k and 'grepl(' not in body(k[0]): bad(1,f"{n}: grader inspects no code")
    # ---- 2

    # a bold exercise label must be followed by an instruction before the hint tail
    for _i,_l in enumerate(L):
        if not re.match(r'^\*\*(Practice|Run and observe|Apply|Explore) \d+:',_l): continue
        _body=[y.strip() for y in L[_i+1:_i+6] if y.strip()]
        if _body and re.match(r'^(One|Two|Three|Four|Five) hints? (are|is) available',_body[0]):
            bad(2,f"exercise label at line {_i+1} has no instruction before the hint count")
    if exs:
        if 'exercise.completion = FALSE' not in t: bad(2,"tutorial_options missing exercise.completion = FALSE")
        if 'lifecycle_verbosity' not in t: bad(2,"options(lifecycle_verbosity) missing")
    if re.search(r'^library\(dplyr\)',t,re.M) and not re.search(r'\b(filter|mutate|select|group_by|arrange|summarise|tibble|bind_rows|rename)\s*\(',re.sub(r'"[^"]*"','',t)): bad(2,"library(dplyr) attached but unused")
    for x in L:
        if re.match(r'^\*\*(?:Practice|Run and observe|Apply|Explore) \d+: (Explore|Apply|Practice|Observe|Run)\b',x): bad(2,"label opens with a type verb")
    seq=[int(x) for x in re.findall(r'^\*\*(?:Practice|Run and observe|Apply|Explore) (\d+):',t,re.M)]
    if seq!=list(range(1,len(seq)+1)): bad(2,"item numbering not consecutive")
    for c in re.findall(r'exercise\.cap="([^"]*)"',t):
        if not re.match(r'^(Practice|Run and observe|Apply|Explore) \d+$',c): bad(2,f"caption not 'Type N': {c}")
    W={'One':1,'Two':2,'Three':3,'Four':4,'Five':5}
    for i,n in exs:
        nh=len([1 for x in L if x.startswith('```{r '+n+'-hint-')])
        lab=[k for k,_ in labels if k<i][-1]; seg='\n'.join(L[lab:i])
        m=re.search(r'(\w+) hints? (?:are|is) available',seg); stated=W.get(m.group(1)) if m else 0
        if stated!=nh: bad(2,f"{n}: prompt says {stated} hints, {nh} chunks")
        if nh and not re.search(r'hints? (?:are|is) available\. Click "Submit Answer" to check your work\.',seg): bad(2,f"{n}: prompt tail malformed")
        k=[x for x,y in enumerate(L) if y.startswith('```{r '+n+'-check}')]
        if k:
            ctx=seg+'\n'+body(i)
            for o in set(re.findall(r'grepl\("(model_\w+|counties|statesPolicy)\b',body(k[0]))):
                if o not in ctx: bad(2,f"{n}: grader needs {o}, absent from prompt and starter")
    # ---- 3
    for i,n in exs:
        hs=[]
        for h in range(1,9):
            k=[x for x,y in enumerate(L) if y.startswith(f'```{{r {n}-hint-{h}}}')]
            if not k: break
            hs.append(body(k[0]))
        if not hs: continue
        st=body(i)
        # a call NAMES a function; "function_name(argument)" and "the function you need"
        # are the pattern being taught, not a specific function
        _h1=re.sub(r'\b(function_name|function|f|FUN)\(','(',hs[0])
        if n not in MECH and set(re.findall(r'\b([a-z_.][a-z_.0-9]*)\(',_h1)): bad(3,f"{n}: hint 1 names a function")
        for j,h in enumerate(hs,1):
            if '___' in h and num not in ('01','02'): bad(3,f"{n}: hint {j} has a ___ skeleton")
            # a fill-in form need not be a function call: "x = data$outcome.variable"
            if num not in ('01','02') and re.search(r'#[^\n]*\b[a-z_.]+\s*=\s*[a-z_.]+\$(?:outcome|explanatory|selection|your)[a-z_.]*',h):
                bad(3,f"{n}: hint {j} gives a fill-in form")
            if f"# Hint {j} of {len(hs)}" not in h: bad(3,f"{n}: hint {j} header wrong")
            for m in re.finditer(r'\b[a-z_.][a-z_.0-9]*\(\s*[^)\s][^)]*\)',h):
                arg=m.group(0)
                trivial = re.fullmatch(r'[a-z_.][a-z_.0-9]*\(\s*[A-Za-z_][\w.]*\s*\)',arg) is not None
                if not PLACE.search(arg) and arg not in st and not trivial: bad(3,f"{n}: hint {j} hands over {arg[:40]}")
    # ---- 4
    for i,n in qs:
        b=body(i)
        if not re.search(r'\bquestion(?:_checkbox)?\(',b): continue
        ans=[(a,r) for a,r in re.findall(r'''answer(?:_checkbox)?\(\s*"((?:[^"\\]|\\.)*)"(.*?)(?=\n\s*answer|\n\s*allow_retry)''',b,re.S)] + [(a,r) for a,r in re.findall(r"""answer(?:_checkbox)?\(\s*'((?:[^'\\]|\\.)*)'(.*?)(?=\n\s*answer|\n\s*allow_retry)""",b,re.S)]
        multi=sum(1 for a,r in ans if 'correct = TRUE' in r)>1 or 'Select all that apply' in b
        _lab={' '.join(a.split()).lower() for a,_ in ans}
        # a closed answer space: the fixed measurement levels, options that ARE numbers,
        # or options identical word for word apart from their numbers
        _skel={re.sub(r'[\d.,%]+','',x).strip() for x in _lab}
        closed = len(ans)==3 and (_lab=={'nominal','ordinal','interval'}
                                  or all(re.match(r'^[\d.,%\- ]+$',x) for x in _lab)
                                  or all(re.match(r'^[\d.,%\- ]+(?:,| because| computed)',x) for x in _lab)
                                  or len(_skel)==1)
        if len(ans)<4 and not multi and not closed: bad(4,f"{n}: {len(ans)} options")
        for key,msg in [('allow_retry = TRUE','no allow_retry'),('random_answer_order = TRUE','no random_answer_order'),('try_again','no try_again')]:
            if key not in b: bad(4,f"{n}: {msg}")
        if not re.search(r'^\s*correct\s*=',b,re.M): bad(4,f"{n}: no correct= hook")
        if re.search(r'^\s*incorrect\s*=',b,re.M) and 'allow_retry = TRUE' in b: bad(4,f"{n}: incorrect= unreachable")
        for a,r in ans:
            if 'message' not in r: bad(4,f"{n}: an option has no message")
        if not multi:
            cor=[len(a.split()) for a,r in ans if 'correct = TRUE' in r]; dis=[len(a.split()) for a,r in ans if 'correct = TRUE' not in r]
            if cor and dis:
                md=sum(dis)/len(dis)
                if cor[0]/md>1.25 and cor[0]-md>=5: bad(4,f"{n}: answer {cor[0]/md:.2f}x mean distractor (+{cor[0]-md:.0f} words)")
    # ---- 5
    # curly quotes only matter where they could be copied into code: inside a code
    # span, a chunk, or a prescribed string. An apostrophe in "let's" is harmless.
    _cq=False; _in=False
    for _l in L:
        if _l.startswith('```'): _in=not _in; continue
        for _m in re.finditer(r'[\u201c\u201d\u2018\u2019]',_l):
            if _in or '`' in _l[max(0,_m.start()-40):_m.start()+40]: _cq=True
    if _cq: bad(5,"curly quotes in or beside code")
    # markdown does not process bold inside a code span -- students see the asterisks
    for _n,_l in enumerate(L,1):
        _p=_l.split('`')
        for _k in range(1,len(_p),2):
            if '**' in _p[_k] and _p[_k].strip('*'):
                bad(5,f"bold inside a code span, line {_n}: `{_p[_k][:40]}`")
        # a code span should balance its own parentheses; when it does not, a backtick
        # has usually been opened inside one, which renders broken
        if _l.count('`')%2==0:
            for _k in range(1,len(_p),2):
                if _p[_k].count('(')!=_p[_k].count(')'):
                    bad(5,f"unbalanced code span, line {_n}: `{_p[_k][:40]}`")
    if '****' in t: bad(5,"**** present")
    if re.search(r'\[(?!\*\*)[^\]]{1,45}\]\{\.important-text\}',t): bad(5,"span without bold inside")
    for i,l in enumerate(L,1):
        if '\u2014' in l and 'aria-label' not in l: bad(5,f"literal em dash outside aria-label, line {i}")
    if re.search(r'`(sjPlot|pscl|stargazer|ggplot2)`',t): bad(5,"package name in backticks")
    _tw=[k for k,x in enumerate(L) if x.startswith('## The Takeaways')]
    tw=_tw[0] if _tw else len(L)
    bd=[m for i,l in enumerate(L) if i<tw for m in re.findall(r'\[\*\*([^\]]+)\*\*\]\{\.important-text\}',l)]
    tk=[m for i,l in enumerate(L) if i>=tw for m in re.findall(r'\[\*\*([^\]]+)\*\*\]\{\.important-text\}',l)]
    if [x for x in set(bd) if bd.count(x)>1]: bad(5,"term spanned twice in body")
    for x in set(tk):
        if _norm(x) not in [_norm(b) for b in bd]: bad(5,f"term spanned in Takeaways but not body: {x}")
    for x in set(bd):
        if _norm(x) not in [_norm(y) for y in tk]: bad(5,f"term spanned in body but not re-marked in Takeaways: {x}")
    inch=False
    for i,l in enumerate(L,1):
        if l.startswith('```{'): inch=True; continue
        if l=='```': inch=False; continue
        if not inch:
            for mm in re.finditer(r'\\"',l):
                if l.count('`',0,mm.start())%2==1: bad(5,f"escaped quote inside backticks, line {i}")
    # ---- 6
    _d=re.search(r'description: >\n\s*(.*)',t) or re.search(r'^description:\s*"?(.*?)"?\s*$',t,re.M)
    if _d is None: bad(6,"no YAML description")
    elif _d.group(1).strip().startswith('Learn how to'): bad(6,"description opens 'Learn how to'")
    # three legitimate forms; the test is that the lead-in reads into its bullets
    _li=[x for x in L if x.startswith('In this tutorial')]
    _bul=[x for x in L if x.startswith('* ')]
    if not _li: bad(6,"no objectives lead-in")
    elif _bul:
        _lead=_li[0].rstrip(); _first=_bul[0][2:]
        _howto=_first.startswith('How to')
        if _lead.endswith('you will learn:') and not _howto: bad(6,"lead-in 'you will learn:' does not read into its bullets")
        elif _lead.endswith('you will learn to:') and _howto: bad(6,"lead-in 'you will learn to:' does not read into 'How to' bullets")
        elif _lead.endswith('we will cover:') and not _howto: bad(6,"lead-in 'we will cover:' does not read into its bullets")
        elif not any(_lead.endswith(x) for x in ('you will learn:','you will learn to:','we will cover:')):
            bad(6,f"objectives lead-in is an unrecorded form: ...{_lead[-40:]}")
    if not any('{#main-content}' in x for x in L): bad(6,"missing #main-content anchor")
    for c in ['encode-logic','encode-ui','tutorial-success-banner']:
        if not re.search(rf'```\{{r {c}-{num}\b',t): bad(6,f"{c} chunk not numbered -{num}")
    # ---- 7
    for i,l in enumerate(L):
        if not l.startswith('```{r'): continue
        n=re.match(r'```\{r ([^,}]+)',l).group(1)
        b=body(i)
        k=[x for x,y in enumerate(L) if y.startswith('```{r '+n+'-check}')]
        gb=body(k[0]) if k else ''
        if '-hint-' in n or n.endswith('-check'): continue
        if 'eval=FALSE' in l or 'eval = FALSE' in l: continue
        bare=re.sub(r'"(?:[^"\\]|\\.)*"','""',b)          # a name inside a string is not a call
        if re.search(r'\bquestion(?:_checkbox)?\(',bare): continue
        DRAW=r'plot_model|ggplot\(|include_graphics|barplot\(|\bhist\(|\bboxplot\(|\bplot\('
        if re.fullmatch(r'\s*[a-z_.]+\(\)\s*',b): continue
        drawn = ('exercise=TRUE' in l and re.search(DRAW,b+gb)) or ('exercise' not in l and re.search(DRAW,bare))
        if drawn and 'fig.alt' not in l: bad(7,f"{n}: figure without fig.alt")
        if 'exercise=TRUE' in l and 'fig.alt=c(' in l: bad(7,f"{n}: vector fig.alt on an exercise chunk breaks learnr's header parsing")
        # strip properly-quoted strings; what remains must never hold two bare words
        _rest=re.sub(r'"(?:[^"\\]|\\.)*"','""',l)
        _rest=re.sub(r"'(?:[^'\\]|\\.)*'","''",_rest)
        _opts=_rest[_rest.find(' ')+1:] if _rest.startswith('```{r') else ''
        if re.search(r'[A-Za-z]\s+[A-Za-z]',re.sub(r'^[^,]*','',_opts)):
            bad(7,f"{n}: chunk header will not parse -- an option string contains an unescaped quote")
    ai=[k for k,x in enumerate(L) if 'aria-label="' in x and 'Excellent work' in x]
    if ai:
        _a=re.search(r'aria-label="([^"]*)"',L[ai[0]])
        if _a is None:
            bad(7,"aria-label present but not parseable on one line")
        else:
            v=L[ai[0]+2].strip().replace('&mdash;','\u2014')
            if _a.group(1).strip()!=v.strip(): bad(7,"banner aria-label does not match visible text")
    for i,l in enumerate(L):
        if not l.startswith('```{r'): continue
        b=body(i)
        if 'grade_this' not in b and 'question' not in b: continue
        s=re.sub(r'"(?:[^"\\]|\\.)*"','""',b); s=re.sub(r"'(?:[^'\\]|\\.)*'","''",s)
        if s.count('(')!=s.count(')') or s.count('{')!=s.count('}'): bad(7,f"{re.match(r'```.r ([^,}]+)',l).group(1)}: unbalanced")
    # ---- 8/9
    # the standards name the synonyms ONCE, at their definition in T7, and nowhere else
    _t8=t if num!='07' else t.replace('The explanatory variable is also called the independent variable, and the outcome variable the dependent variable.','')
    if re.search(r'\b(dependent|independent) variable',_t8): bad(8,"dependent/independent variable")
    if re.search(r'PLSC ?309|Penn State',t): bad(8,"course code present")
    for w in ['a week','last class','this week','since you last','by now in']:
        if w in t.lower(): bad(9,f"calendar reference '{w}'")
    # ---- 10
    _real=re.search(r'\bdata\("[^"]+", package = "QPATutorialsCourse"',t)
    if _real and not re.search(r'missing (values?|for|a value)|has no missing|no missing values',t,re.I):
        bad(10,"no missing-value statement anywhere")
    # ---- appendix
    for _l in L:
        # plain arithmetic contrasted with a symbolic expression in the same sentence
        # stays in math mode -- mixing the two sizes in one clause is worse
        _sym=any('\\\\' in x or chr(92) in x for x in re.findall(r'\$([^$\n]{1,60})\$',_l))
        for m in re.finditer(r'\$([^$\n]{1,60})\$',_l):
            # a lone operator is typographic, not arithmetic: "gini08 $-$ gini04"
            if re.match(r'^[\d.\s+\-*/=×]+$',m.group(1)) and not _sym and re.search(r'\d',m.group(1)):
                bad('math',f"arithmetic in math mode: {m.group(1)}")
    for m in re.finditer(r'\b(fail|pass|message\s*=|correct\s*=|try_again\s*=|answer)\s*\(?\s*"((?:[^"\\]|\\.)*)"',t):
        if m.group(2).count('`')%2: bad('markup',f"odd backticks in a string, line {t[:m.start()].count(chr(10))+1}")
    if re.search(r'Ã|Â',t): bad('env',"mojibake")
    return F
for f in sys.argv[1:]:
    name=os.path.basename(f)[:3]
    try:
        F=run(f)
    except Exception as e:
        print(f"\n===== {name} : BATTERY ERROR {type(e).__name__}: {e} ====="); continue
    print(f"\n===== {name} : {len(F)} findings =====")
    for x in F: print("  ",x)
