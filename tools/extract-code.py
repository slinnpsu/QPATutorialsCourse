"""Generate T<N>-all-code.R from a tutorial .Rmd.

Two jobs in one file:
  * a cheat sheet of the code a student types in each exercise
  * a script that runs top to bottom and reproduces the tutorial's output

So it emits the setup chunk, every BACKGROUND code chunk the page runs
behind the scenes, and every exercise, in tutorial order.

Left out, because none of it runs or helps outside learnr: hint chunks
(fragments with blanks), -check graders (they inspect a submission that
does not exist here), question/quiz chunks (no code), and the encoder and
banner chunks (Canvas submission plumbing).

No tutorial in this package has a -solution chunk, so where an exercise
ships blank the answer exists only in the previous version of this file.
Regeneration therefore MERGES: reconstructed answers are carried across,
matched on the `# chunk:` line written into every block.
"""
import io, os, re, sys

TITLES = {'01':'R Basics, Part 1','02':'R Basics, Part 2','03':'Levels of Measurement',
'04':'Univariate Description --- Nominal','05':'Univariate Description --- Ordinal',
'06':'Univariate Description --- Interval','07':'Bivariate Description --- Two Categorical',
'08':'Bivariate Description --- Categorical and Interval','09':'Bivariate Description --- Two Interval',
'10':'The Logic of Statistical Inference','11':'Hypothesis Testing and Confidence Intervals',
'12':'Hypothesis Tests --- Two Categorical Variables','13':'Hypothesis Tests --- Categorical and Interval',
'14':'Hypothesis Tests --- Two Interval Variables','15':'Simple Regression','16':'Multiple Regression',
'17':'From Coefficients to Predictions','18':'Interactions','19':'Prediction Plots for Interaction Models',
'20':'Logistic Regression','21':'Prediction Plots for Logistic Regression'}

HEAD = '''# =====================================================================
# T{n} -- {title}
# EVERY LINE OF CODE THE TUTORIAL RUNS, in tutorial order.
#
# Generated from the .Rmd, not retyped. Run it top to bottom in a clean
# session and it reproduces the tutorial's output.
#
#   [STUDENT CODE]  code a student types into an exercise box
#     [VERBATIM]        ships complete in the .Rmd
#     [RECONSTRUCTED]   the exercise ships blank or with ___; the answer was
#                       built by hand from the prompt and the grader.
#                       UNVERIFIED until run. If a grader rejects one, that
#                       is a bug here, not in your typing.
#   [BACKGROUND]    runs behind the page; students never see or type it, but
#                   later exercises depend on it, so do not skip it
#
# The `# chunk:` line under each heading is the .Rmd chunk label. It is what
# lets this file be regenerated without losing the reconstructed answers.
# Do not edit those lines.
#
# Hints, graders, multiple-choice questions and the Canvas encoder chunks are
# not here --- none of them run outside learnr.
# =====================================================================
'''

CHUNK = re.compile(r'^```\{r[ \t]+([^\n},]+?)[ \t]*(?:,([^\n}]*))?\}$', re.M)
BOLD  = re.compile(r'^\*\*(Practice|Run and observe|Apply|Explore) (\d+):[ \t]*(.*?)\*\*[ \t]*$')


def rule(s):
    return '# ' + '-' * 69 + '\n# ' + s + '\n# ' + '-' * 69


def classify(label, opts, body):
    """Return 'setup', 'student', 'background', or None to skip."""
    if label == 'setup':
        return 'setup'
    if re.search(r'exercise\s*=\s*TRUE', opts):
        return 'student'
    if re.search(r'-hint(-\d+)?$', label) or label.endswith(('-check', '-solution')):
        return None
    if 'context=' in opts or label.startswith(('encode-', 'tutorial-success')):
        return None
    if re.search(r'\b(question|question_checkbox|quiz)\s*\(', body):
        return None
    if not body.strip():
        return None
    return 'background'


def parse(path):
    """Yield (kind, label, opts, body, item_label) in .Rmd order."""
    text = io.open(path, encoding='utf-8').read()
    L = text.split('\n')
    fence = [k for k, x in enumerate(L) if x.startswith('```')]
    for m in CHUNK.finditer(text):
        k = text[:m.start()].count('\n')
        e = next(x for x in fence if x > k)
        label, opts, body = m.group(1).strip(), (m.group(2) or ''), '\n'.join(L[k + 1:e]).rstrip()
        kind = classify(label, opts, body)
        if kind is None:
            continue
        # Search back for the bold item label, stepping over any prepare-*
        # chunk that sits between the label and the exercise, and stopping
        # only at the previous exercise. A fixed line window used to lose the
        # title whenever a setup chunk intervened.
        item = None
        for x in range(k - 1, -1, -1):
            if re.match(r'^```\{r[^\n}]*exercise\s*=\s*TRUE', L[x]):
                break
            b = BOLD.match(L[x])
            if b:
                item = f'{b.group(1)} {b.group(2)}' + (f': {b.group(3)}' if b.group(3) else '')
                break
        if item is None:
            cap = re.search(r'exercise\.cap="([^"]+)"', opts)
            item = cap.group(1) if cap else label
        yield kind, label, opts, body, item


def read_old(out_path):
    """Map old block bodies by chunk label, and by bare title as a fallback
    for files written before `# chunk:` lines existed."""
    by_chunk, by_title, order = {}, {}, []
    if not os.path.exists(out_path):
        return by_chunk, by_title, order
    blocks = io.open(out_path, encoding='utf-8').read().split('# ' + '-' * 69)
    for i in range(1, len(blocks) - 1, 2):
        head, body = blocks[i], blocks[i + 1]
        hl = [x for x in head.split('\n') if x.startswith('# ')]
        if not hl:
            continue
        heading = hl[0][2:].strip()
        # The `# chunk:` line sits at the TOP OF THE BODY, not in the head --
        # the head is what falls between two rule lines. Reading it from the
        # head left the marker inside the carried-over code and duplicated it
        # on every regeneration.
        blines = body.split('\n')
        chunk = next((x.split(':', 1)[1].strip() for x in blines if x.startswith('# chunk:')), None)
        code = '\n'.join(x for x in blines
                         if not x.startswith('# ---') and not x.startswith('# chunk:')).strip()
        if not code:
            continue
        title = heading.split(':', 1)[1].strip() if ':' in heading else ''
        title = re.sub(r'\s*\[.*', '', title).strip()
        if chunk:
            by_chunk[chunk] = code
        if title:
            by_title.setdefault(title, code)
        order.append((heading, code))
    return by_chunk, by_title, order


def build(path, out_path):
    num = os.path.basename(path)[:2]          # from the BASENAME, not the path
    by_chunk, by_title, _ = read_old(out_path)
    _, _, old_order = read_old(out_path)
    # POSITIONAL ALIGNMENT. Titles are NOT a safe key: T21's item titles were
    # edited after its all-code file was written, and title matching silently
    # handed one exercise another one's answer. The old files were generated
    # from these same .Rmd files in chunk order, so position is exact --- as
    # long as the sequences are the same length. The old generator dropped
    # exercises whose chunk label contained an uppercase letter, so those are
    # excluded from the new sequence before comparing.
    old_students = [c for h, c in old_order if not h.startswith('SETUP')]
    new_students = [lab for kind, lab, _, _, _ in parse(path)
                    if kind == 'student' and re.fullmatch(r'[a-z0-9._-]+', lab)]
    by_pos = (dict(zip(new_students, old_students))
              if len(old_students) == len(new_students) else {})
    aligned = bool(by_pos)
    out, report = [HEAD.format(n=num, title=TITLES[num])], []
    counts = dict(verbatim=0, recon=0, kept=0, todo=0, background=0)

    for kind, label, opts, body, item in parse(path):
        if kind == 'setup':
            out.append('\n' + rule('SETUP   [BACKGROUND]') + '\n# chunk: setup\n\n' + body.strip())
            continue

        if kind == 'background':
            counts['background'] += 1
            code = body
            if re.search(r'eval\s*=\s*FALSE', opts):
                code = ('# This chunk is a display template (eval=FALSE); it is shown, not run.\n'
                        + '\n'.join('# ' + x for x in body.split('\n')))
            out.append('\n' + rule('[BACKGROUND] ' + item if item == label else
                                   f'[BACKGROUND] before {item}')
                       + f'\n# chunk: {label}\n\n' + code)
            continue

        bare = '\n'.join(x for x in body.split('\n')
                         if x.strip() and not x.strip().startswith('#')).strip()
        # A starter can be non-empty and still be a starter: T5 ships
        # `fHouse %>%` with the pipe dangling. Treating that as a finished
        # answer put an expression in the file that cannot run.
        last = bare.split('\n')[-1].rstrip() if bare else ''
        open_paren = bare.count('(') > bare.count(')')
        incomplete = bool(re.search(r'(%>%|\|>|\+|,|&|\||~|<-|=)$', last)) or open_paren
        if bare and '___' not in bare and not incomplete:
            counts['verbatim'] += 1
            out.append('\n' + rule(f'{item}   [STUDENT CODE / VERBATIM]')
                       + f'\n# chunk: {label}\n\n' + body)
            continue

        counts['recon'] += 1
        prior, how = by_chunk.get(label), 'carried over'
        if prior is None and aligned:
            prior = by_pos.get(label)
            how = 'position-matched'
        elif prior is None:
            prior = by_title.get(re.sub(r'^[^:]*:\s*', '', item))
            how = 'TITLE-MATCHED --- CHECK'
        if prior:
            counts['kept'] += 1
            report.append((label, item, how))
            code = prior
        else:
            counts['todo'] += 1
            report.append((label, item, 'NO PRIOR ANSWER --- TODO'))
            code = ((body if body.strip() else '# starter is empty')
                    + '\n\n# TODO: answer not auto-generated --- build from the prompt and grader.')
        out.append('\n' + rule(f'{item}   [STUDENT CODE / RECONSTRUCTED]')
                   + f'\n# chunk: {label}\n\n' + code)

    return '\n\n'.join(out) + '\n', counts, report


if __name__ == '__main__':
    force = '--force' in sys.argv
    for p in [a for a in sys.argv[1:] if not a.startswith('--')]:
        o = f'T{os.path.basename(p)[:2]}-all-code.R'
        txt, c, report = build(p, o)
        if c['todo'] and os.path.exists(o) and not force:
            print(f'  {o:20s} NOT WRITTEN --- {c["todo"]} answer(s) would be lost. '
                  f'Check the report below, then pass --force.')
        else:
            io.open(o, 'w', encoding='utf-8').write(txt)
            print(f'  {o:20s} student {c["verbatim"]+c["recon"]:3d} '
                  f'(verbatim {c["verbatim"]}, reconstructed {c["recon"]}: '
                  f'{c["kept"]} carried over, {c["todo"]} TODO)  background {c["background"]:3d}')
        for label, item, how in report:
            print(f'      {how:24s} {item}   [{label}]')
