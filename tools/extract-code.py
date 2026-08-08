"""Generate T<N>-all-code.R from a tutorial .Rmd.

VERBATIM chunks are copied as they ship. Chunks that are blank, carry ___,
or hold only comments are marked RECONSTRUCTED and left for a human to fill,
since an answer invented here would be unverified either way.
"""
import io,re,sys

TITLES={'01':'R Basics, Part 1','02':'R Basics, Part 2','03':'Levels of Measurement',
'04':'Univariate Description --- Nominal','05':'Univariate Description --- Ordinal',
'06':'Univariate Description --- Interval','07':'Bivariate Description --- Two Categorical',
'08':'Bivariate Description --- Categorical and Interval','09':'Bivariate Description --- Two Interval',
'10':'The Logic of Statistical Inference','11':'Hypothesis Testing and Confidence Intervals',
'12':'Hypothesis Tests --- Two Categorical Variables','13':'Hypothesis Tests --- Categorical and Interval',
'14':'Hypothesis Tests --- Two Interval Variables','15':'Simple Regression','16':'Multiple Regression',
'17':'From Coefficients to Predictions','18':'Interactions','19':'Prediction Plots for Interaction Models',
'20':'Logistic Regression','21':'Prediction Plots for Logistic Regression'}

HEAD='''# =====================================================================
# T{n} -- {title}
# WORKING CODE FOR EVERY EXERCISE, in tutorial order.
#
# Generated from the .Rmd, not retyped.
#
#   [VERBATIM]      the chunk exactly as it ships -- already complete code
#   [RECONSTRUCTED] the exercise ships blank, with ___, or with comments only;
#                   the answer has to be built from the prompt's prescribed
#                   values and the grader's requirements. UNVERIFIED until run.
#                   If a grader rejects one, that is a bug here, not in your
#                   typing.
#
# Headings match the numbered bold label above each exercise in the tutorial.
# Questions are not listed; only exercises that take typed code appear here.
#
# Run the setup block once per session; everything else depends on it.
# =====================================================================
'''

def rule(s): return '# '+'-'*69+'\n# '+s+'\n# '+'-'*69

def build(path):
    L=io.open(path,encoding='utf-8').read().split('\n')
    num=path[:2]; out=[HEAD.format(n=num,title=TITLES[num])]
    recon=verb=0
    # setup
    i=next(k for k,x in enumerate(L) if x.startswith('```{r setup'))
    j=next(k for k in range(i+1,len(L)) if L[k].startswith('```'))
    out.append('\n'+rule('SETUP   [VERBATIM]')+'\n\n'+'\n'.join(L[i+1:j]).strip())
    for k,l in enumerate(L):
        m=re.match(r'```\{r ([a-z0-9._-]+),[^}]*exercise=TRUE',l)
        if not m: continue
        cap=re.search(r'exercise\.cap="([^"]+)"',l)
        e=next(x for x in range(k+1,len(L)) if L[x].startswith('```'))
        body='\n'.join(L[k+1:e]).rstrip()
        stripped='\n'.join(x for x in body.split('\n') if x.strip() and not x.strip().startswith('#')).strip()
        # find the bold label above
        lab=next((L[x].strip('*') for x in range(k-1,max(0,k-12),-1)
                  if re.match(r'^\*\*(Practice|Run and observe|Apply|Explore) \d+:',L[x])),
                 cap.group(1) if cap else m.group(1))
        if not stripped or '___' in stripped:
            tag='[RECONSTRUCTED]'; recon+=1
            code=(body if body.strip() else '# starter is empty')+'\n\n# TODO: answer not auto-generated --- build from the prompt and grader.'
        else:
            tag='[VERBATIM]'; verb+=1; code=body
        out.append('\n'+rule(f'{lab}   {tag}')+'\n\n'+code)
    return '\n\n'.join(out)+'\n', verb, recon

if __name__=='__main__':
    import os
    force = '--force' in sys.argv
    for p in [a for a in sys.argv[1:] if not a.startswith('--')]:
        o=f'T{p[:2]}-all-code.R'
        # never silently overwrite a file that already holds reconstructed answers
        if os.path.exists(o) and not force:
            prev=io.open(o,encoding='utf-8').read()
            if 'TODO' not in prev:
                print(f'  {o:20s} SKIPPED --- already holds answers; pass --force to replace')
                continue
        txt,v,r=build(p)
        io.open(o,'w',encoding='utf-8').write(txt)
        print(f'  {o:20s} verbatim {v:3d}  reconstructed {r:3d}')
