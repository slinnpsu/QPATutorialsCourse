# QPATutorialsCourse — Review Standards (v17.10)

**New in v17.9**, corrections of 4 August 2026 rather than new rules: the
version in this title (it read v17 while the document carried v17.8 content);
three wrong section numbers in the v17 changelog below; the codebook count and
the stale claim in §8 that no codebook exists; and the contradiction between
§7 and §10 over which tutorials must state a missing-value count. **None of
these invalidates a v17.8 verdict** except the codebook one, which is a
newly usable source of truth for every tutorial.

**New in v17.8**, from the enumerate-and-read pass over T1--T6 of 4 August
2026: the markup rule for grader strings and its package-name exception (§5).

**New in v17**, from the T10 and T11 span-and-box work later the same night:
the distractor-arithmetic rule (§4); deleting rather than replacing a box that
held definitions, the cross-tutorial preview rule, and the key-term audit (§5);
Takeaways coverage that keyword matching misses (§6); fixing color-only
information in the plot rather than the caption, and folding answer-naming prose
into the message (§7); and two more soft-wrap rules for divs and bullets (§9).

**New in v16**, from the T7–T10 pass of 2 August 2026: the house form for
filter fail messages and the rule against `grepl` checks on fixed aesthetics
(§1); the hint-code scan that actually works (§3); the `correct =` / `message`
split, the warning that multi-line questions are invisible to every scripted
check here, and the throwaway-distractor test (§4); the safe procedure for a
markup pass with its four traps (§5); the ban on hard-wrapped prose (§9); four
additions on describing plots you have not seen (§11); and five on what an edit
leaves behind (§12).

Working standards for the T1–T21 review pass. Derived from house practice in the
existing tutorials plus decisions made during the T1–T3 reviews, 28–30 July 2026,
and extended by the T4–T9 pass of 31 July–1 August 2026. Sections 10, 11 and 12
are new in that pass; several of their rules REVERSE earlier advice and say so
where they do.

Items marked **[script]** can be checked mechanically rather than by reading.

**A note on how to use this.** Several rules in the first version of this
document turned out to be generalizations from two or three files rather than
real conventions, and enforcing them would have made good tutorials worse. Where
a rule below quotes an exact string, treat it as suspect and check the corpus
before enforcing it. Where it describes a shape or a test, it is more reliable.

---

## 1. Graders

- **[script]** Comment stripping must be `gsub("#[^\r\n]*", "", code)` — never
  `gsub("#.*", "", code)`. In R's default regex `.` matches newlines, so the
  short form deletes everything after a student's first comment and fails
  correct work silently.
- **[script] The collapse separator is coupled to that regex.** The submission
  must be joined with `paste(.user_code, collapse = "\n")`, never
  `collapse = " "`. A space-joined string contains no newlines, so the corrected
  regex has nothing to stop at and the bug returns in full. Checking one without
  the other leaves graders broken while looking fixed. T2 had four of these.
- `grade_this()` throughout, with whitespace-tolerant regex.
- Null guards; term-order and label-order enforcement where order matters.
- `pass()` messages open with a short affirming hook, then the substance.
  **Vary the hook** — "Right!", "Correct!", "Exactly!", "Well done!", "Good
  work!" all qualify. Across T4, T12, and T16 only 5 of 12 use "Right!" and T4
  uses it zero times. Eighteen identical openings in one tutorial are
  monotonous. Do not standardize on one word.
- **[script] `pass()` CONFIRMS THE WORK JUST SUBMITTED AND NOTHING ELSE.** It
  must not point forward or duplicate what comes next. **The same rule governs
  question feedback** --- `correct =` and per-answer `message =` are subject to
  it too. T3's ideology question pointed at "the next section" in two separate
  distractor messages, and the next section was the next thing on the page. Two distinct failures,
  both found repeatedly:
  - **Anticipating the next item.** "…before answering the next question",
    "you will combine this vector with the second group in the next exercise",
    "compare it to the box plot you will create below", "the prose below shows
    where this leads next", "the table below describes what each one records".
    This hands over framing the student has not reached, and it goes stale the
    moment items are reordered or renumbered.
  - **Confirming the wrong work.** T1's Apply 32 asked students to build a
    vector of Republican vote shares; its `pass()` reported the vector's MEAN,
    a calculation they would not perform until three exercises later. A
    phrasing-based scan does not catch this — ask whether the message reports
    the thing the exercise actually produced.
  - **Duplicating the prose that follows.** The message says something, then
    the paragraph immediately below the chunk says it again. T1's classes
    grader ended "you will meet several others as the series continues"
    directly above "There are many other classes of objects in R. We will
    encounter more in future lessons." The student reads the same claim twice
    in a row.
  Neither check was in the battery until 31 July, which is why both survived
  into tutorials already marked finished — seven instances across T4, T6, and
  T8 at that date. Run both:

  ```bash
  # 1. forward-pointing language inside pass()
  grep -nP 'pass\(.*(the next|next question|next exercise|below|coming up|you will see|read on)' FILE
  ```

  ```
  # 2. pass() overlapping the prose that follows it
  # For each pass message, collect the next 12 non-blank lines after the chunk
  # closes and compare word sets; flag overlap above ~45%. Short messages
  # ("Your plot is correct.") produce false positives, so read the pairs the
  # check returns rather than trusting the ratio.
  ```

  The fix is never to delete the substance — it is to replace the forward
  reference with something about the work just done. "Notice that Clinton
  appears twice — you will combine this vector with the second group in the
  next exercise" becomes "Notice that Clinton appears twice — Bill Clinton ran
  in both 1992 and 1996, and a vector holds a repeated value as readily as a
  unique one."
- A grader must not require more than the task does. If two routes to the
  correct answer both use only what the series has taught by that point, both
  must pass.
- **[script] Prompt and grader must agree on `na.rm`.** If the prompt asks for
  it, the grader checks for it; if the grader requires it, the prompt says so.
  The second direction is the dangerous one — a student following the prompt
  exactly then fails.
- Fail messages must not give away the answer. Point back to the table, the
  section, or the concept instead of naming the value.
- **The test for a leak is whether the message reveals something the prompt does
  not already state.** If the prompt says "calculate the square root of 4 using
  `sqrt()`", a fail message saying the same thing reveals nothing. Check the
  prompt before rewriting a message.
- **[script] Be accurate about `na.rm = TRUE`.** Two opposite errors are easy
  here. Do not call adding it routinely "good practice" — it changes which
  cases the number describes. But do not imply there is an alternative either:
  if a variable has `NA` and you want a mean, this argument is the only way to
  get one. What varies is what you do around it — count the missing values
  first, and describe the result as the summary among cases that have values.
  Both errors occurred in T1 and T2 today and were corrected in four places.
- **Ask of every grader: could a student pass without doing the thing the prompt
  teaches?** A grader that only compares `.result` to an expected value is
  well-formed and passes every mechanical check here, but a student who types
  the answer as a literal gets full credit. T5's median exercise could be
  passed by entering `1`. Where the exercise teaches a function, an operator,
  or an argument, check the submitted code for it as well as the result. This
  is NOT scriptable — a result-only grader looks correct from the outside.
- Consider a targeted check for the specific wrong turn students actually take.
  T1's replace-elements grader now catches replacement values wrapped in another
  indexing expression, which the generic NA message misdiagnosed.

- **[script] Fail messages naming a missing filter take one form:**
  ``In `filter()`, remove rows where **X** is missing with `!is.na(X)`.``
  Three shapes had grown across T7 and T9 for the same message. Uniformity wins
  over trimming the expression out: nothing in any prompt asks a student to
  derive `!is.na()`, which they have used since T4, so it reveals nothing the
  prompt withholds.
- **A `grepl` check on a fixed aesthetic is reversible and must not be used.**
  `grepl("color = 'steelblue'")` matches anywhere in the submission, so a
  student who puts the colours on the wrong geoms passes. Bind each value to its
  layer instead:

  ```r
  layer_geoms <- sapply(.result$layers, function(l) class(l$geom)[1])
  pt <- which(layer_geoms == "GeomPoint")
  if (length(pt) == 0 || !identical(.result$layers[[pt[1]]]$aes_params$colour, "steelblue")) fail(...)
  ```

  The `length() == 0` guard stops a missing layer erroring on `[[NA]]`.
  **ggplot normalises `color` to `colour`**, so reading `aes_params$colour`
  catches both spellings.
- **A grader must check everything the prompt demands.** T8's Apply 9 required
  steelblue points and a darkorange line and verified neither. Read the prompt
  and the grader side by side, requirement by requirement.
- **Counting one style of check measures nothing.** A grader inspecting the
  built object can be the strongest in a tutorial while showing the fewest
  `grepl` calls. Judge coverage by what is verified, not by how.

- **Correlation takes either variable order; scatter plots do not.** T9 enforced
  "list the explanatory variable first" for `cor()` in prose, hints, graders and
  pass messages, and T14 did not enforce it at all. Decided 3 August 2026:
  **for `cor()` and `cor.test()` either order is accepted and the tutorials say
  why** --- a correlation measures how tightly two variables move together, not
  how one acts on the other, so `cor(x, y)` and `cor(y, x)` return the same
  number. **The axis convention for scatter plots stands** --- explanatory on
  `x`, outcome on `y` --- and T9's plot graders still enforce it. When loosening
  a convention, sweep the fail messages too: two survived in T9 saying "uses
  `qog$wdi_gini` as x, `qog$vdem_polyarchy` as y" and were found only by reading,
  because they used neither of the phrases the first search looked for.

## 2. Exercises

- **[script]** `tutorial_options(exercise.checker = gradethis::grade_learnr,
  exercise.completion = FALSE)` in every setup chunk that has exercises.
  Autocomplete inserts junk in the learnr editor. Not applicable to tutorials
  with no exercise chunks.
- **Attach only what the tutorial uses.** DESCRIPTION `Imports` declares a
  dependency and makes a package reachable as `pkg::fn()`, but does not attach
  it — a bare `fn()` still fails. `library()` in the setup chunk attaches it.
  So anything called unqualified must be in both; but a package in DESCRIPTION
  belongs in a given setup chunk only if that tutorial actually calls it.
- Four labels. **Each is defined by what it asks, never by where it appears** —
  placement claims about this corpus have been wrong every time:
  - **Run and observe** — code to execute and examine
  - **Explore** — the same, then change it and see what happens.
    **Ungraded by definition.** The distinction from Practice is not whether the
    student modifies code but whether there is a right answer. A box that edits
    starter code but has one correct answer and a grader is Practice.
  - **Practice** — complete or write code, or answer a question about what was
    just seen. Checked.
  - **Apply** — bring several skills together: code drawing on more than one
    idea, judging whether a pattern supports a hypothesis, explaining what a
    result means. Appears wherever a tutorial has built up enough, **not only in
    Check Your Understanding** — T8 has two inside a body worked example.
- **Do not blank the middle of a call the student should be composing.** A
  blank that leaves the scaffolding standing reduces the task to slot-filling:
  `x = factor(___)` asks the student to name a variable, not to notice that a
  numeric variable needs wrapping. Blank the whole expression --- `x = ___` ---
  and let the grader check for `factor()`. Same for a pre-written `filter()`
  line sitting above a blanked pipeline.
- **Do not hand over a complete call unless it is genuinely the student's first
  encounter with it.** Seeing it does not count as encountering it: every
  `filter()` in T4, T5 and T6 starters --- twelve of them --- is handed over
  pre-written, so a student reaching T7 has seen a dozen and composed none. When
  a form IS new, hand-over is defensible only alongside a careful explanation of
  what is new about it.
- **A prompt must not print the code it is asking for.** Prose immediately above
  an exercise that shows the literal call makes any blank in that call
  decorative. Describe the shape instead: "two conditions separated by a comma,
  each negating `is.na()` for one variable" rather than the call itself.
- **A fifth label, "Example code:", is legitimate** for non-exercise
  demonstration chunks (`exercise=FALSE, eval=FALSE`). No caption, no number.
- **[script] No label may open with a verb that duplicates a type name** — no
  Explore, Apply, Practice, Observe, or Run as the first word after the colon,
  since the type word sits immediately beside it. Lowercase use in ordinary
  prose is fine.
- **[script]** Every item numbered in a single sequence through the tutorial —
  exercises and questions together, so numbers ascend down the page. The number
  appears in the bold label and in `exercise.cap`; questions carry it in the
  label only.
- `exercise.cap` is type plus number and nothing else: `Practice 12`,
  `Run and observe 20`. The bold label above carries the full task title.
- **The instruction sentence goes below the bold label**, not above. Where a
  paragraph fuses explanation and instruction, split it: explanation stays
  above, the instruction moves down. Apply this tutorial by tutorial during the
  review rather than as a separate sweep.
- **[script]** Prompt tail is always: `<N> hints are available. Click "Submit
  Answer" to check your work.` Hint count first, Submit sentence last.
- **[script]** Stated hint count must match the number of hint chunks. This is a
  TWO-PLACE fact: the prompt tail and the chunks themselves. Every hint added or
  removed is therefore two edits, and the count also appears inside each hint as
  `# Hint N of M`, so adding one hint rewrites every hint in that exercise.
- **[script] AFTER ANY HINT WORK, RUN THE FULL HINT AUDIT — every graded
  exercise, every criterion, including hints you just wrote.** Checking one
  criterion at a time, or hint 1 only, or a sample plus judgment, has failed
  three times: an ordering defect spanning three hints was invisible to a
  hint-1-only check; a `Tutorial N` grep missed hints withholding a name in
  other words ("the geom layer that counts observations"); and two exercises
  judged "borderline, leave them" were straightforward failures. Twice, hints
  written to fix one criterion broke another in the same edit. The audit
  reports, per graded exercise: hint count; whether hint 1 names any function;
  whether any hint withholds a name it should give; whether hint 1 is the most
  specific of the set; stated-vs-actual count; duplicate chunks; orphans.
  It is one command and it covers a whole tutorial. If a standard needs an
  exception, put the exception IN the standard — deciding case by case is how
  the corpus drifts.
- **[script] RE-RUN THE INTEGRITY CHECKS IMMEDIATELY AFTER ANY BULK CHUNK EDIT** —
  duplicate chunk labels, orphan graders and hints, stated-vs-actual hint counts,
  and item counts. A renumbering pass that assumed one blank line between hint
  chunks once consumed only part of a block and left an orphan carrying a
  DUPLICATE chunk label, which would have failed the build. It surfaced only
  because the counts were re-run afterwards. Check right after the edit, not at
  the end of the session.
- **[script]** Every `exercise.setup` target must resolve to a real chunk.
- **[script]** The object or data frame name a grader requires must appear in
  the prompt or in the starter code, so students never scroll back for a name.
- Merge adjacent boxes that make the same point. Do not merge when the
  separation *is* the point — e.g. one box showing that assignment produces no
  output, followed by one showing how to display a value.

## 3. Hints

**Terminology.** A *hint* is a numbered `-hint-1`, `-hint-2` chunk the student
opens with the "Hint" button. Only coding exercises have them; questions have no
Hint button. The message a wrong multiple-choice answer triggers automatically
is `try_again`, covered in section 4 — different thing, different rules.

- **Structure: conceptual → function names → specifics. ALWAYS CHECK THIS.**
  Three hints is the norm. Two is fine for a genuinely simple exercise; more when
  the code is complex (T6's four-layer histogram has four).
  **Hint 1 states what the student is trying to produce, in terms of the
  statistical idea, before any function is named.** The test: could someone who
  has never seen R follow it? "You need the value that divides the distribution
  in half" passes. "Group the counties, count them, then divide by the total"
  does NOT — that is the recipe with the names filed off, and it is the most
  common failure. T6 does this best; T5's were procedural until fixed.
  EXCEPTION: a purely mechanical blank ("change the number of bins to 50") has no
  concept above the mechanics. Do not manufacture one — a strained conceptual
  hint reads worse than starting at the function.
  Later hints narrow: which function per blank, then the specifics that trip
  people up (an argument that sits outside `aes()`, a function that takes no
  arguments at all).
- **A student must never have to open a previous tutorial to answer a question.**
  A hint saying "the same three functions you used in Tutorial 4" without naming
  them sends the student out of the tutorial to proceed. Naming a function is not
  a leak — the exercise is applying a known method, not recalling its name.
  Cross-tutorial references are fine as reassurance ("the same structure as
  Tutorial 4, with one addition") provided everything needed is also stated here.
  Three hints in T5 failed this and were rewritten.
- **Never complete working code in any hint.** A hint that would pass the grader
  if pasted is a violation, even when the task allows any of several answers.
  The point is that students type the code themselves — copying a hint teaches
  nothing, and typing is what makes it stick.
- **Fill-in-the-blank `___` skeletons appear in T1 and T2 only.** After T2 there
  are none: hints are conceptual or name a function, never a form to fill in.
  Students at that stage should be composing code, not completing it.
- `___` in exercise *starter code* is always fine — the rule is about hints.

- **Hints must not answer each other out of order.** If hint 1 poses a question
  ("Which variable is which here?") and hint 3 answers it, hint 2 must not be
  about something else --- the student opens them in sequence. Check the
  sequence as a sequence, not hint by hint.
- **A hint must point at a blank that exists.** After any change to a starter,
  re-read every hint against the current blanks. A hint describing a step that
  is already filled in wastes the student's escalation and leaves the real blank
  unhinted.
- **Put a mechanics warning where the student meets it**, not where it first
  occurred to you. The inside-versus-outside-`aes()` trap belongs in the hint
  about `geom_bar()`, because that is the layer where a bare variable name
  outside `aes()` produces "object not found".

- **[script] No hint may contain a complete call carrying its own argument
  values.** A line-based scan for "code in hints" finds nothing, because every
  hint line is a comment and the code sits inside them. Scan for
  `\b[a-z_]+\(\s*[a-z_.]+\s*=\s*[^)]*\)` instead. T8's Practice 12 handed over
  `scale_x_discrete(labels = c("Full Democracy", ...))` complete. A fixed idiom
  with no variable content — `guides(fill = "none")` — is not a violation, since
  pasting it alone passes no grader.
- **Removing a hint can orphan a blank.** After any hint is cut, re-check that
  every blank in the starter still has one.

## 4. Multiple choice

- House style is conceptual and interpretive: a scenario in which someone has
  reasoned wrongly, and the student diagnoses it. Not recall of a rule.
- **[script]** At least four options — more is fine. Fewer when the answer
  space is genuinely smaller: Nominal / Ordinal / Interval is the whole set,
  and three options is correct there. **Never invent a fourth option the
  tutorial has told students to disregard** — offering "Ratio" after saying it
  is folded into interval tests recall of a house convention, not
  understanding. `allow_retry = TRUE`; `random_answer_order = TRUE`.
- `correct =` is a crisp hook confirming **why** the answer is right. It never
  previews the next question or primes a later item — that is not confirmation,
  and it gives away framing the student has not reached. Full explanation goes
  in `message =`.
- Per-answer `message =` on every distractor, explaining why it is wrong.
  Each distractor should be a misconception someone actually holds.
- **`try_again` is the message a wrong answer triggers automatically** — not the
  Hint button, which questions do not have. It should point at the distinction
  being tested without naming the answer: "There are two nominal variables in
  this list. Look for variables whose values are unordered category labels."
  Saying how many to find is a legitimate nudge that gives nothing away. A bare
  "Incorrect. Try again." wastes the one moment a student is guaranteed to be
  paying attention.
- **[script]** `incorrect =` is unreachable whenever `allow_retry = TRUE`.
  Fold its content into `try_again` or delete it.
- **[script]** Every question needs a bold label — `Practice:` in the body,
  `Apply:` for synthesis. 43 of 45 across T4, T12, and T16 have one.
- **Check questions written in a non-standard format by hand.** The scripted
  checks assume the house layout: `question("stem",` on one line and each option
  as `  answer("text"` on one line. A question using multi-line `answer(` calls
  is skipped silently by the `try_again`, option-count, and answer-length
  checks — it produces no error, it simply is not seen. T4's Practice 10 was
  written that way and passed two automated sweeps while missing `correct =`,
  `try_again`, and feedback on all three distractors. When a question count and
  a check count disagree, that gap is the reason: find the question the scripts
  cannot parse.
- **[script] Balance option lengths.** The correct answer must not be visibly
  longer than the distractors — students learn to pick the longest and score
  above chance without reading. The usual cause is structural: the correct
  answer states the claim AND explains it, duplicating what `message =` already
  says. Fix by moving the explanation to the message.
  **Measure against the MEAN distractor length, not the longest, and flag
  anything above 1.25x.** Comparing to the longest hides the tilt: a question
  can sit comfortably under its longest distractor while running twice the
  typical one, and the typical one is what a student's eye calibrates against.
  Measured across T15--T19 at 1.6x-of-longest, four questions flagged; the same
  set at 1.25x-of-mean flagged **44 of 79**, and every one of them carried an
  explanatory clause after a `---` that the message already stated.
  Where the correct answer is already terse, lengthen the shortest distractor
  instead --- a four-word throwaway option is its own tell.
  Multi-select items are less exposed, since the cue does not tell you how many
  to pick.
- **Markup conventions apply INSIDE `question()` too — check this in every
  tutorial.** Variable and data-frame names take **bold** in stems, answer
  options, and `message =` text, exactly as in prose; functions and arguments
  take backticks. This is new relative to how most tutorials were written, so
  expect to find it unapplied. Note that the scripted checks will NOT catch it:
  they verify that markup *renders*, not that it is *applied*, and question text
  with no markup at all is perfectly well-formed.
  **Partly scriptable only.** A script can list every occurrence of a variable
  name; a reader has to decide which ones are the variable. The test: if you
  could substitute an ordinary English phrase, it is ordinary usage and stays
  plain. In T4, `counties` was the places in every instance and stayed plain
  throughout, while `region` split four (the column) to nine (the ordinary
  noun) — "between 9 and 16 states per region" is not the variable.
  **Search case-insensitively.** A variable name opening a sentence gets
  capitalized — "Region has the most even spread" — and a case-sensitive pass
  walks straight past it. Do not bold the capitalized form, since R is
  case-sensitive and the variable is lowercase; rewrite so the name is not
  sentence-initial: "The **region** variable has the most even spread."
  **It is LESS unapplied than it looks, so do not sweep blind.** Across
  T1--T14, 18 `answer()` options already carry backticks and 12 carry bold, so
  the convention is established house practice, not a new imposition --- read
  before changing. **Two forms it takes:** a `name = value` pair is ONE
  backticked code span, not a bolded name beside a bare operator
  (`` `TrumpMajority = 1` ``, `` `reps = 1` ``, not `**TrumpMajority** = 1`);
  and **a string the student TYPES keeps escaped quotes and never becomes a
  code span** (`\"Clinton\"`, not `` `"Clinton"` ``) --- inside `question()`
  exactly as in prose.
  **THE BLIND SPOT IS `answer()` OPTION TEXT.** Sweeps get scoped to
  `message =` and `try_again =` because those read like feedback, and the
  options get missed: T10's 2 August pass bolded eleven `replicate` mentions and
  left two bare, both of them in option text. Scope any question-markup sweep to
  the stem, the options AND the feedback.
- No answer-leaking prose below a question; no redundancy between the bold
  label and the question stem.

### What renders inside `question()`

Tested 28 July 2026 against the installed learnr. Re-test after any upgrade —
this is observed behavior, not documented behavior, and it has changed across
versions. The diagnostic file is `mc-markdown-test.Rmd`.

| | Stem | Answers | correct / message / try_again |
|---|---|---|---|
| `**bold**` | applied but invisible* | works | works |
| `` `code` `` | works | works | works |
| `$math$` (LaTeX) | works | works | works |
| `[x]{.important-text}` | literal | literal | literal |
| `[x]{.package-name}` | literal | literal | literal |

\* learnr renders stems and try-again containers entirely in bold, so bold
inside them cannot be seen. Keep it in the source for consistency.

**MathJax fires everywhere inside `question()`** --- confirmed 27 July 2026 and
again on a rendered page 4 August 2026, in T11's Apply 6, where all four answer
options and every feedback message carry `$...$`. **So write formulas in
questions as LaTeX, matching the body; do not leave them as plain text.** The
row above was missing until 4 August, and its absence cost two days: the sizing
decision was recorded under Environment gotchas ("no CSS or JS intervention on
sizing") while the CAPABILITY was written down nowhere, so a reviewer reading
§4 or §5 found no permission for math and twice reopened a settled test.
**Recording a decision about a feature is not the same as recording that the
feature works.**

### Where math renders --- check the SURFACE before converting

Tested 4 August 2026 with a single chunk carrying the same string in three
places at once. **"Does math render here" has a different answer per surface, so
a consistency sweep that converts every plain formula to LaTeX will damage
two of them.**

| Surface | Math renders? | |
|---|---|---|
| Body prose | yes | |
| `question()` stem, options, feedback | yes | tested twice, 27 Jul and 4 Aug |
| `fig.cap` | yes | pandoc renders it; a Greek alpha appears under the figure |
| `fig.alt` | **no** | it is an HTML `alt` attribute --- the source confirmed `alt="ALT: does $\alpha = 0.05$ render here?"`, so a screen reader says "dollar backslash alpha" aloud. **Spell symbols out in words: "alpha equals 0.05".** |
| ggplot `labs()` --- title, subtitle, axis labels, caption | **no** | ggplot draws label strings as literal text; the test plot's title displayed `$\alpha = 0.05$` verbatim on the image. `expression()` and plotmath are the separate mechanism if a symbol is genuinely wanted there. |

The test was run in an `html_document` knit rather than inside a learnr
tutorial. Captions, alt attributes and ggplot labels all take the same knitr
path in both, so it transfers --- but if this is ever in doubt, re-run it as a
tutorial rather than assuming.

Consequence: package names appear as plain text inside questions. Bold and
backticks are fine everywhere.

- **The `correct =` hook affirms; the per-answer `message` does not.** T10 had
  "Right." opening both, so a correct answer showed it twice. T8 and T9 have no
  affirming word in any correct-answer message; write the hook to carry it and
  let the message go straight to substance.
- **[script] A question written with `question(` and each `answer(` broken
  across lines is INVISIBLE to every line-based check here** — option counts,
  lengths, `try_again`, `correct =`. It produces no error; it simply is not
  seen. T4's Practice 10 was one instance; **T10 is written this way throughout
  and hid thirteen missing `correct =` hooks and nine length cues.** Parse by
  walking `question(`'s argument list on balanced parens and splitting on
  top-level commas, so both layouts are seen. Run that parser before assuming
  any tutorial's questions are clean.
- **Two throwaway distractors make an item answerable without understanding.**
  T8's Apply 15 offered "higher means are more likely to be correct" and
  "neither is useful because neither is exactly 41.5" — neither is a
  misconception anyone holds, so the item tested nothing. Replace with the
  reasoning students actually attempt: in that case, comparing which sample mean
  happens to land closer, and treating a standard error as a bound on the one
  sample drawn.

- **[script] Every question needs a bold label, and a parser that reads only the
  `question(` call will not see when one is missing.** Three tutorials in a row
  (T12, T13, T14) had exactly two unlabelled questions each, always the
  hypothesis-setup item sitting under a "Steps 1 and 2" heading with a lead-in
  sentence and no label. Check upward from each `question(` chunk for a
  `**Practice:**` or `**Apply:**` line, not just the call's contents.
- **Three options are correct where three is the whole answer space.** T3 has
  four questions asking what level of measurement a variable has, with options
  Nominal / Ordinal / Interval. That is not a thin option set — T3 states that
  "three levels cover everything you will meet in these tutorials" and folds
  ratio into interval, so a fourth option would have to be invented and would
  contradict the tutorial's own scheme. Check what the answer space actually is
  before treating a three-option item as a defect.
- **[script] The length-cue heuristic does not apply to multi-select items.**
  Where a question has more than one `correct = TRUE`, a long correct answer is
  no cue: T7's `quiz-identify-proportions-gender-regime` flagged at 1.53 while
  one of its two correct answers was the SHORTEST option in the set. Skip the
  ratio when the correct count is above one.
- **A distractor's stated NUMBERS must follow from its own stated METHOD.** T11's
  Apply 6 offered four confidence intervals; two stated bounds their own formulas
  do not produce, and one of those **duplicated the correct answer's bounds**, so
  a student who computed correctly found two options carrying their answer and
  could only choose by reading formulas. Recompute every option. No scripted
  check looks at this — it surfaced only on a rendered page.

## 5. Markup

- **Bold** for object, variable, and data frame names in prose.
- `` `backticks` `` for function names with parens — `` `summary()` `` —
  argument names, `arg = value`, operators, and code fragments.
- `[pkg]{.package-name}` for package names in prose, never backticks.
- **Grader strings follow the prose markup rules.** Variable and data-frame
  names take **bold**; function names, argument names, `arg = value` pairs,
  operators, and code fragments take backticks --- inside `fail()`, `pass()`,
  `correct =`, `message =`, and `try_again =` exactly as in prose. Bold and
  backticks both render in gradethis feedback (confirmed by screenshot, T5
  Practice 7). **Package names are the one exception.**
  `[pkg]{.package-name}` does not render outside prose, so a grader string
  names the package plain and lowercase --- "the rio package" --- and
  backticks the call: ``Load the rio package first with `library(rio)`.`` The
  span stays mandatory in prose. Do NOT "correct" a plain package name in a
  grader string into a span. Added 4 August 2026, after the enumerate-and-read
  pass over T1--T6 found the same instruction formatted two different ways in
  two files of one sequence --- T4 Practice 23 had
  `Set fill = "red" outside aes() inside geom_bar().` against T5 Practice 10's
  ``Set `fill = "steelblue"` inside `geom_bar()`.`` Nothing in this document
  had ever stated the rule for grader strings, so there was nothing for the
  corpus to be consistent with.
- `[**term**]{.important-text}` for a term at the point where the sentence
  defines it. Bold goes *inside* the span. Position in the sentence is
  irrelevant and so is count — if one sentence defines four terms it gets four
  highlights.
- **One span per term, at the section that develops it.** A term is defined
  once. If a framework section previews several terms and each then gets its own
  section, the preview uses plain **bold** and the spans go where each concept is
  actually developed — otherwise the highlight stops meaning "this is where you
  learn what this means." T4 marked central tendency, dispersion, and shape twice
  each, and univariate description twice, because a preview list and the section
  openers both claimed to be the definition. Checked against T5 and T6: both mark
  each of these terms exactly once in the body, at its section opener, plus once
  in the Takeaways. Takeaways re-marking is correct and does not count.
- **Emphasis on a SCHEME is a box or a heading, not a pile of term spans.** The
  reason T4 doubled up was that the framework's importance is structural — three
  dimensions organizing three tutorials — and `.important-text` can only mark a
  term. Put the scheme in an `.important-note` holding just the named dimensions,
  one short clause each, and let the definitions live in the sections. A box that
  also carries the definitions is doing two jobs and becomes too heavy, which is
  what prompted breaking it up in the first place.
- **Reserve the highlight for prose terms, not code.** Where the concept
  matters, highlight the name and leave the symbol in backticks:
  the [**dollar-sign operator**]{.important-text} `$`, the
  [**equality operator**]{.important-text} `==`. No span in the corpus contains
  backticks.
- Names used as examples of *syntax* rather than references to an object stay
  in backticks — e.g. showing that `my.first.object` and `my_first_object` are
  both valid name forms.
- **Quotes mark text the student will see on screen** — button labels
  ("Run Code", "Submit Answer", "Hint") and section headings
  ("Submit Your Work", "Check Your Understanding"). One test: will they see
  these exact words on the page? Exception: the four type names stay **bold**
  in the paragraph that defines them, where the words are the subject rather
  than a pointer.
- Em dashes as `---`. No literal em dash characters or curly quotes.
- **[script] Escape the quotes on any string a student copies into code:**
  `- Title: \\"Democratic Vote Share\\"`. Pandoc's smart typography converts
  straight quotes in PROSE into curly typographic quotes at render time, and R
  does not accept those as string delimiters — so a student who copies a title
  or label off the rendered page gets a syntax error. Backslash-escaping stops
  the conversion; the rendered page still shows ordinary straight quotes, with
  no backslash visible and no code formatting implied.
  **Only strings students TYPE.** Ordinary prose quotes should keep their curly
  rendering — "typical value", "whisker", and button names like
  `Click "Submit Answer"` are read, not typed, and stay unescaped.
  In practice this means the requirements lists under plotting exercises:
  titles, subtitles, axis labels, captions, fill colours, and category-label
  vectors. Fifteen such lines were escaped across T4–T6; expect similar counts
  wherever a tutorial specifies plot text. T1–T3 have none.
  Do NOT try to fix this by disabling smart typography — the same Pandoc
  extension handles `---`, which would then render as three literal hyphens.

- **[script] How to run this pass safely.** Restrict every substitution to
  user-facing strings — `fail(`, `pass(`, `answer(`, `message = `, `correct = `,
  `try_again = `. A naive scan of every string in a grader chunk hits `grepl()`
  REGEX PATTERNS, where inserting `**` or a backtick silently breaks the check.
  Four traps, all of which have bitten:
  - a `(?![\w.*])` lookahead **blocks a sentence-ending period** and skips every
    name that ends a sentence — use `(?![\w*])(?!\.\w)`;
  - bolding runs **inside `$` expressions**, giving `qog$**wdi_gini**` —
    post-process `(\w+)\$\*\*(\w+)\*\*` to `` `X$var` ``;
  - a call wrapper that allows a space before the paren wraps English —
    "mean (34.2)" became a code span — so require the paren IMMEDIATELY after
    the name;
  - a wrapper starting at the function name leaves a **leading `!` outside the
    span**: `` !`is.na(x)` `` should be `` `!is.na(x)` ``.
  Verify after: nothing inside `grepl`/`identical` lines, backticks balanced
  WITHIN each user-facing string, no `****`. Ordinary English words that are
  also object names — counties, rural, world, mean, colour, bowl, replicate —
  are judged case by case; names with an underscore or digit are safe wholesale.

- **When a box turns out to hold definitions, DELETE it — do not replace it with
  a summary box.** Splitting a heavy box means moving the definitions into prose;
  if nothing is left that a box does better than a sentence, the box goes. Having
  moved two definitions out of T10's statistic/parameter box, a summary box was
  manufactured to fill the slot, and it then restated the paragraph above it and
  the notation table below it. Ask what remains for the box to do.
- **`.caution` boxes are not held to the scheme rule.** A warning needs its
  reasoning; a scheme does not. Judge `.important-note` by the rule and
  `.caution` by whether the warning is complete.
- **SPAN WHERE THE TUTORIAL DOES THE TEACHING. Revised 3 August 2026; this
  REPLACES the earlier "first tutorial in the sequence wins" rule.** A term gets
  `[**term**]{.important-text}` in ANY tutorial that defines or develops it, and
  plain **bold** where the tutorial merely uses a term the reader is assumed to
  bring. **Her reasoning: students return to a single tutorial in other semesters
  and other courses, so a tutorial has to stand alone.** The same argument she
  applied to repeated content applies to emphasis: the reader may not have read
  the others. Contrast within one page is what spans are for, and that survives.
  Consequences: T6 spanning `unimodal` and `bimodal` is CORRECT even though T4
  spans them, because T6 teaches those shapes for continuous distributions --- 
  different work. T6 spanning `median` is WRONG, because T6 does not teach the
  median. **The preview/development rule still holds WITHIN a tutorial**: where a
  framework section previews terms that each get their own section, the preview
  uses plain bold and the span goes where the concept is developed.
- **[script] Audit KEY TERMS, not just duplicates.** A duplicate check finds
  terms spanned twice; it cannot find a term spanned zero times. T10 introduced
  the Central Limit Theorem with its own section and a box and never spanned it —
  eight body mentions, no highlight — while `sampling bias` and `point estimate`
  carried spans. List the terms the tutorial teaches and check each one.
- **AN UMBRELLA TERM RUNNING ACROSS A SEQUENCE IS SPANNED AND DEFINED IN EVERY
  TUTORIAL THAT APPLIES IT, NOT ONLY THE ONE THAT INTRODUCES IT** --- settled
  4 August 2026, and it OVERRIDES the earlier "T7 owns bivariate description"
  reading. The reason is the one behind the whole span rule: students return to a
  single tutorial in later semesters, so each must stand alone, and a reader
  landing on T9 should not have to visit T7 to learn what the term means.
  `bivariate description` is now defined and spanned in the body of T7, T8 and
  T9, and re-marked in all three sets of Takeaways. **The definitions are
  near-identical by design. Do NOT report the repetition as a duplicate-span
  defect** --- the duplicate-span check is about one term spanned twice WITHIN a
  tutorial. Place the span where the tutorial develops the concept for its own
  case, not in a preview list: T7 in its framing section, T8 in the Overview
  paragraph that states the structure of its question, T9 in the framing section
  that contrasts it with T7 and T8.

## 6. Structure

- Title Case at both `##` and `###`. **A technical term keeps its lowercase
  letter where the case carries meaning** --- `p-value`, `t-test`, and any
  heading built on them. "The Two-Sample t-Test", "The One-Sample t-Test" and
  "The Paired t-Test" are correct. The test is whether lowercasing is doing
  semantic work, not whether the term appears on a list.
- Overview carries the skip-nav anchor: `## Overview {#main-content}`.
- **The Overview leads with something motivating and situates last.** Settled
  4 August 2026 across all fourteen Overviews of T1--T14. Do not open by saying
  where the tutorial sits in the sequence --- "This tutorial is the middle step
  in the three-tutorial sequence on univariate description" is the shape to
  avoid. The order is: a hook stating plainly why the subject matters; what this
  tutorial covers; then, last and briefly, where it sits and what to go back to.
  **The hook is general and must not use a variable the tutorial itself
  analyzes.** State the situation in terms a reader outside this course would
  recognize --- Likert items and income brackets, not `rural_urban` and
  `FHStatus`. Building a hook on a variable from the body presumes the reader
  has met it, and the body introduces it properly a few paragraphs later anyway.
  Three or four concrete instances, then the point.
  **Do not perform.** "Report the average and you have said something; you may
  also have hidden almost everything" was rejected, and so was "Few statistics
  travel as far outside their home as the correlation coefficient." A reader
  returning eighteen months into a thesis wants the situation stated, not
  admired. Do not start in the middle of things.
  **The test of a good hook is that its own list is the tutorial's arc.** T8's
  names what an average cannot show --- whether the difference characterizes
  most cases, whether the groups overlap, whether a few observations drive it
  --- which is the histogram, the box plot and the outlier discussion, in order.
- **The second paragraph says what the tutorial covers --- unless the section
  below already does.** Where a framing section follows the Overview and teaches
  the same procedure, drop the middle paragraph and leave the Overview at two.
  T7--T14 all have such a section, so a preview duplicates it; T1--T6 do not, so
  the middle paragraph earns its place. **Read the section that follows before
  writing one.** The move is prescribed, the wording is not --- vary it rather
  than repeating "This tutorial covers..." down the sequence. This is a
  deliberate exception to §9's ban on formulaic openers: in a sequence the
  parallel helps a reader who lands in the middle.
- **Cross-references are pointers, not a catalogue --- and `qpa_launch()` is
  why.** Called with no argument it prints all 21 tutorials grouped, with what
  each block builds on and a description of each, so **an Overview must not
  enumerate what other tutorials do.** Keep at most one backward pointer, and
  only where a prerequisite genuinely unblocks this tutorial. Say what the
  reader would get by going there, since someone may arrive two years later
  asking what an ordinal variable is. Never a forward list. Phrase it "If you
  need to review the procedure and the decision rule, go back to Tutorial 11"
  --- not "if either needs refreshing." **Do not tack a pointer on as a
  paragraph's last sentence**; move it into the middle as a subordinate clause
  so the paragraph ends on its own point.
- **`title:` and `description:` are written as a pair, and both are read in a
  list.** The `qpa_launch()` map and the RStudio Tutorial pane display them
  alongside twenty others. The title identifies; the description differentiates.
  **Titles stay short and keep "Variable" or "Variables".** "Bivariate
  Description: Two Categorical (Nominal and/or Ordinal) Variables" at 76
  characters and "...One Categorical (Nominal or Ordinal) Variable and One
  Interval Variable" at 94 truncate everywhere they appear. T9's "Bivariate
  Description: Two Interval Variables" and T12--T14's "Hypothesis Tests: Two
  Categorical Variables" are the model; the parenthetical detail belongs in the
  body.
  **The description is a short differentiating noun phrase, not a sentence
  opening "Learn how to."** Nine of twenty-one began that way and read as a wall
  in a column. Name what is distinctive --- "Adds the median, and putting
  ordered categories in the right order" --- and check it does not restate the
  title.
- **Objectives list:** "In this tutorial you will learn:" followed by `*`
  bullets each beginning "How to …". Confirmed across eight tutorials.
- **Objectives must cover every section.** Check the list against the section
  headings; unannounced material is the common failure. This is also the
  closest thing to an authoritative statement of what the function-restriction
  rule permits.
- **An orienting section between the Overview and the first hands-on material.**
  T4, T12, and T16 use a conceptual framing section, 446–687 words, no
  exercises. T1 uses a Roadmap instead, because its material is many loosely
  connected mechanics and needs an explanation of why the order is what it is.
  Same slot, different content. Do not add a Roadmap to every tutorial — a
  conceptually unified tutorial does not need one, and a self-evident workflow
  (T2) is better framed in the Overview.
- Takeaways must cover every section and re-mark defined terms with
  `.important-text`. Format is free — numbered recap, bullets, or prose.
  Conceptual tutorials should not be forced into lists.
- **Takeaways order should match body order, but the real test is dependency,
  not sequence.** Reordering the body without reordering the recap can break a
  dependency: T2's Takeaways used "logical condition" a paragraph before
  comparison operators explained it. That --- a term used before the recap
  develops it --- is the defect. **Body order is the default; thematic
  consolidation is legitimate where the body interleaves a topic across
  non-adjacent sections.** Settled 4 August 2026 on T1, whose body runs
  calculator, objects, functions, classes, vectors, indexing, arithmetic,
  modifying, summary functions, missing values, multi-input functions,
  packages, comments --- functions in two sections eleven apart, vectors across
  four consecutive ones. Its recap groups objects with classes, all four vector
  sections together, both function sections with packages, then summary
  functions with missing values. Following body order would split functions
  across two paragraphs with vectors wedged between them, and T1 is the one
  tutorial whose material is (in its own Roadmap's words) loosely connected
  mechanics, so the recap is where they finally get organized. Checked against
  the dependency test: ten of eleven spanned terms are spanned at or before
  first use, and the exception --- `function` appearing plainly in paragraph 2
  as one of the three classes and spanned in paragraph 4 --- is the
  preview-then-develop shape §5 already blesses. **Do not "fix" T1's recap into
  body order.**
- **The Takeaways end by pointing forward.** One short paragraph naming the next
  tutorial and what it adds --- the tool that changes, the question that becomes
  answerable. This is where forward references belong, and the only place they
  do: a reader at the start of an Overview cannot act on "Tutorial 12 will test
  whether this pattern could have arisen by chance," but a reader who has just
  finished T7 can. Name what changes rather than only the number, so the pointer
  survives renumbering with one edit and tells the reader whether they want it.
  Where a tutorial closes a block, point to what the next block opens rather
  than summarizing what was finished. Run it as plain prose, not under a bolded
  label. Settled 4 August 2026, when six of fourteen tutorials did this and
  eight did not.
  **A SENTENCE DESCRIBING HOW THE ACCUMULATING TABLE GROWS IS NOT THE FORWARD
  REFERENCE THIS RULE RESTRICTS** --- settled 4 August 2026 after it was raised
  as a defect and withdrawn. The infographic lead-ins say "Tutorial 6 adds a
  third column" (T5), "Tutorials 8 and 9 will add columns of their own" (T7) and
  "Tutorial 9 will add a third column for two interval variables" (T8). Each
  explains why a table in a tutorial about ordinal variables carries a nominal
  column --- a fact about the artifact on the page, not an instruction sending
  the reader elsewhere. The rule exists because a reader cannot act on a pointer
  to work they have not reached; a reader looking at a two-column table that
  will become three-column is being told something about what they are looking
  at. **All three stay. Do not report them as defects.**
- **[script]** Encoding chunks carry the tutorial number: `encode-logic-NN`,
  `encode-ui-NN`, `tutorial-success-banner-NN`.
- **[script]** No duplicate chunk labels; no orphan graders or hint chunks.
- Helper functions defined once, in the setup chunk — not repeated inline.
- **[script]** No dead objects in setup.
- **Material belongs where its topic is, not where its data dependency is.**
  T1's `names()` demonstration sat under Functions with Multiple Inputs only
  because the section above created the vector it needed.
- **Do not interleave two threads in one section.** T7's plotting section ran
  filter (unexplained) → factor levels → line-break syntax → back to missing
  values → back to labels. Each thread was fine; the splice was not. Finish one,
  then start the other.
- **Problem, demonstration, explanation, then mechanics.** Where a section
  exists to show that something goes wrong, the explanation follows the
  demonstration rather than preceding it --- and the lead-in must not give away
  the punchline. "It is worth seeing what happens if you skip the filter" tells
  the student the filter matters before they see why; "build it the same way you
  built the last one, and look carefully at what comes back" does not.
- **Example sections take one shape across a sequence:** heading → a motivating
  question → the `.hypothesis` box → "The theoretical explanation is that…" →
  the variable description. The labelled sentence is deliberate --- students
  struggle to form their own theoretical explanations, and naming it cues them
  on what one is. Check Your Understanding follows the same shape.
- **An umbrella term is spanned wherever a tutorial defines or develops it**
  (revised 3 August 2026 --- see §5). The Overview stays plain bold and the
  Takeaways re-mark whatever the body spanned. What remains a defect under the
  revised rule, and is worth checking in every file:
  a term spanned in the Takeaways but never in the body (marked in a recap of
  something the tutorial never taught); a mismatch between body and
  Takeaways that makes them DIFFERENT TERMS rather than the same term in
  different grammatical number --- `percentile` against `percentiles` is NOT a
  defect, and forcing agreement makes the prose worse (T1 defines one
  [**function**]{.important-text} in the body and opens its recap
  "[**Functions**]{.important-text} are what make R powerful", which is right
  both times). Narrowed 4 August 2026, after the check flagged three such pairs
  in T1 and none anywhere else in T1--T6; a term taught and
  spanned but never re-marked in the Takeaways; and a term spanned twice within
  one tutorial.
- **The Takeaways open with an HTML infographic table that accumulates across
  the sequence.** One data column in the first tutorial, headed generically;
  at the second, that column is RENAMED to its case and a second added. Cells
  are short noun phrases. Function names need `<code>` tags --- markdown
  backticks do not render inside the raw `<table>`.
  **T1 AND T2 HAVE NO INFOGRAPHIC AND SHOULD NOT.** Settled 4 August 2026. The
  accumulating table belongs to a sequence that builds one framework across
  several tutorials --- the univariate run from T4, and T3's standalone levels
  table. R Basics Part 1 and Part 2 teach loosely connected mechanics with no
  framework to tabulate, so a table there would have to be invented to fill the
  slot. Do not report their absence as a finding.

- **[script] Takeaways coverage cannot be checked by keyword.** Matching a
  heading's words against the recap gives false passes: T10's `## Three
  Distributions` scored OK because "distribution" appeared, while the recap
  discussed only the sampling distribution and never made the three-way contrast
  the section exists for. Read the recap against what each section teaches.
- **An objective the Takeaways never mention is a coverage gap.** "Explain why
  sample means from random samples are unbiased" was a stated T10 objective and
  the word `unbiased` appeared nowhere in its recap.
- **The ggplot learning objective takes one shape across the sequence:** the
  function, the package, and the geom that matters ---
  ``How to ... using `ggplot()` from the [ggplot2]{.package-name} package with
  `geom_X()` ``. Decided 3 August 2026 after four different shapes were found
  across T4--T9. T7 is the deliberate exception: it names the `fill` aesthetic,
  `position = "dodge"` and `after_stat(prop)` instead of a geom, because those
  are what distinguish a grouped bar plot.
- **[script] Read an auto-titler's output; do not trust its exit code.** Title
  Case by script put "we" and "not" in the small-word list (both take capitals)
  and capitalised `p-value`, a technical term that keeps its lowercase p.

## 7. Accessibility

- `fig.alt` on every figure. For figures that feed a question, describe visual
  features only — nothing that reveals the answer.
- **[script] Success banner `aria-label` must match the visible text**, not
  restate it at greater length. Screen reader users otherwise hear something
  sighted readers never see. Found in T2, T3, and T16 — check every tutorial.
- Table captions: "Source: Linn, Nagler, Zilinsky", no "and".
- No color-only or position-only information ("the box on the right").
- Exercise labels stay bold, **not** headings. learnr builds its section
  structure from headings, so `###` would fragment progressive reveal and
  `####` would skip a level. Navigation is by find-in-page on the numbers,
  which the built-in accessibility guide already advertises.
- Box classes: `.tip` for technique asides, `.caution` for genuine pitfalls,
  `.important-note` for conceptual emphasis, `.hypothesis` for hypothesis
  statements, `.research-example` for study exemplars, `.table-container`
  around wide tables.
- Avoid two callout boxes back to back — a sentence or two between them.
- **[script] PROSE BELOW A QUESTION MUST NOT NAME ITS ANSWER.** learnr lets a
  student scroll past an unanswered question, so a debrief paragraph placed
  after a `question()` is readable BEFORE they commit. It is not "after" from
  the student's point of view. T6's Practice 14 asks which binwidth is
  coarsest while still showing the shape; the paragraph below it opened "At a
  binwidth near 0.8 the shape is much clearer" — the answer, in the second
  sentence a student would read. The fix is to refer to the choice rather than
  the value: "At the binwidth you settled on...". Check: for every
  `question()`, take the prose between it and the next label and look for the
  correct answer's literal value or a distinctive phrase from its `correct =`
  hook.
- **[script] AFTER ANY EDIT TO A `pass()`, `fail()`, OR ANSWER STRING, CHECK
  PAREN AND BRACE BALANCE IN THAT CHUNK.** Replacing a
  `pass(paste0("...", value, "..."))` with a plain `pass("...")` leaves a
  stray closing paren, and learnr reports only "A problem occurred with the
  grading code for this exercise" — it does not say where. This happened in
  T6 Practice 6 on 31 July and was found by testing, not by reading. Check:
  for every chunk containing `grade_this` or `question(`, blank out the
  contents of all quoted strings, then confirm `(` and `)` counts match and
  `{` and `}` counts match. Run it across the whole file, not just the chunk
  you touched.
- **STATE THE NUMBER OF MISSING VALUES WHERE A VARIABLE IS INTRODUCED — T6
ONWARD --- BUT §10 EXTENDS IT TO EVERY TUTORIAL, INCLUDING WHEN THE COUNT IS
  ZERO, AND §10 IS THE AUTHORITY.** This bullet used to exempt T4 and T5 on the
  grounds that a `filter()` absorbs their missing values; that exemption was
  deleted on 4 August 2026 because it contradicted §10. From T6 on the count
  does extra work, because students call `median()`, `mean()`, `sd()`, `cor()`
  and the like directly on the variable and get `NA` back, so the count explains
  what they are seeing. Give it once, where the variable is introduced, phrased to cover every
  statistic that follows — e.g. "**wage_growth** has 2 missing values, so any
  summary you compute from it describes the 3,110 counties with a recorded
  value rather than all 3,112 in the data." Do NOT name `na.rm = TRUE` in that
  sentence or in the prompt: state the fact and let the student work out the
  remedy; hints may name it. Two consequences: (a) never require
  `na.rm = TRUE` on a variable that has no missing values without saying so —
  T6 Practice 5 requires it on **dem2p_percent**, which has none, and the fail
  message invents a hypothetical reason; (b) a fail message must not say "as
  the prompt asks", which grades compliance rather than understanding.
  NEVER assert a count from memory or infer it from an exercise title —
  verify with `colSums(is.na(df))` and record it in the corpus notes.
  **Verify AFTER the setup chunk runs, not against the shipped data.**
  Several tutorials recode in setup and the two differ: the shipped
  `fHouse$FHStatus` is character with 0 NAs and 8 empty strings, while T5's
  setup recodes it to numeric 0/1/2 and those 8 become NA. A count taken from
  the raw object would have made T5's correct prose look wrong.
- **[script] A LONE FORWARD-LOOKING SENTENCE MUST NOT SIT DIRECTLY BEFORE A
  HEADING.** learnr breaks the page at every `##` and `###`, so a sentence in
  that position renders alone at the foot of the section, above the Next Topic
  button, introducing something the student cannot see. It reads fine in the
  `.Rmd`, which is why only a rendered read or this check finds it. T5 had
  "Does the middle of the distribution fall in the same category as the mode?"
  stranded before `### The Median`; T2 had a sentence before
  `## Indexing in a Data Frame` whose whole content was announcing the next
  section. The fix is to move the sentence BELOW the heading, where it becomes
  the section's opening question rather than a dangling line. Check: for every
  heading, take the previous non-blank prose line; flag it if it is short and
  its last sentence points forward — ends in a question mark, or contains
  "the next section", "which is where", "read on", "comes next". A
  forward-looking clause at the END OF A FULL PARAGRAPH is ordinary connective
  writing and is NOT a defect — T4's four Step transitions are correct.

- **Color-only information is fixed in the PLOT, not the caption.** Map the same
  variable to a second channel — `linetype` for lines, `shape` for points — with
  matching `labels` in both scales so ggplot merges them into one legend key. A
  legend naming the groups is not sufficient on its own if only hue separates
  them on the page.
- **Do not use one colour for two different things in a plot.** T11's interval
  figure drew both the missing intervals and the true-proportion reference line
  in the same red.
- **Captions and `fig.alt` describe BEHAVIOUR, not colour.** "The few drawn as
  dashed lines fall entirely to one side" survives both color blindness and a
  screen reader; "intervals shown in red miss it" survives neither. Where a
  figure has one of a thing, no colour word is needed at all — "the bar", "the X".
- **Prose below a question that names its answer is FOLDED INTO THE MESSAGE, not
  deleted.** T11's Practice 3 asked where a result falls and the paragraph
  beneath it said "very few bars fall at or to the right of the red line" while
  the student was still choosing. The content is usually worth keeping; it is
  the position that is wrong.

## 8. Language

- outcome / explanatory / predictor. Not dependent / independent.
- **The synonyms are named ONCE, at the definition in T7, and nowhere else.**
  Students remember explanatory and outcome but mix up dependent and
  independent, so T7 links them at first definition --- "the explanatory
  variable is also called the independent variable, and the outcome variable
  the dependent variable" --- and then uses the house terms throughout. That
  single sentence is deliberate and is NOT a violation of the rule above. Added
  3 August 2026.
- **T7 DEFINES the bivariate vocabulary for the whole sequence.** `explanatory
  variable`, `outcome variable`, and `column proportions` appear nowhere in
  T1--T6 and 47 times in T8, T9, T12, T13, and T14. Until 3 August 2026 T7 used
  all three from its first body paragraph without defining any of them --- the
  sentence introducing cross-tabs was built out of two terms the student had
  never met. If any of these definitions is moved or trimmed, everything
  downstream loses its footing.
- Fix genuinely causal claims — establishes, proves, demonstrates causation.
  Do **not** replace ordinary regression usage like "X predicts Y" in its
  technical sense; over-correction into "association" reads as stilted.
- "statistically significant evidence in support of the hypothesis" for formal
  test results.
- Confidence band or interval overlap is never a test of whether two
  predictions are distinguishable.
- ANOVA and chi-square: "its p-value does not directly test a specific
  directional contrast."
- **[script]** Cross-references to other tutorials must match current
  numbering. The T17–T21 renumbering of 23 July 2026 is the live scheme.
- **[script]** Removing content breaks callbacks elsewhere. Dropping `names()`
  from T1 orphaned a sentence in T2 that began "which you used in Tutorial 1".
- **Function restriction is cumulative.** Students may use anything introduced
  in the sequence to that point, not only in the current tutorial. Tutorials
  never require tools that have not yet been introduced anywhere.
- **Course-specific language: the rule covers the package, not only the
  tutorials.** These materials are used in more than one course and by students
  returning for thesis work, so a course code does not belong in an example, in
  the startup banner, in DESCRIPTION, or in a vignette. The `.onAttach` banner
  carried "These graded tutorials support PLSC 309H: Quantitative Political
  Analysis at Penn State University" until 4 August 2026 --- the first thing
  every reader saw, telling most of them they were in the wrong place.
  **"Paste it into Canvas" in Submit Your Work stays**, the deliberate
  exception, since Before You Begin tells non-course users to skip that section.

## 9. Voice

- Warm, direct, second person. Humor where it lands.
- Cut formulaic openers. A sentence telling students to press "Run Code" when
  the paragraph above already explained the box is filler — delete it rather
  than rewriting it into a different formula.
- Watch passive-box fatigue. T1 had 22 run-and-observe boxes against 18 graded;
  T4, T12, and T16 run 8–13 boxes total.
- A closing paragraph connecting a mechanical skill to real work is worth
  adding where the payoff is concrete — but not after every section. Two or
  three per tutorial is plenty; more and the tutorial reads as constantly
  justifying itself.

---

- **[script] Prose is never hard-wrapped.** Three rules the first attempt got
  wrong: **div contents wrap too** — only the `:::` markers are structural, and
  skipping their bodies left T11's p-value definition and misconception box still
  wrapped; **bullets belong on one line** — T6 through T9 have zero wrapped bullet
  continuations and T11 had thirteen, so an indented continuation appends to the
  bullet above it; and **the YAML front matter is excluded**.
  **INDENTED LINES ARE NOT PROSE — exclude them from both the measurement and
  the unwrapper.** Every tutorial from T3 onward carries an HTML infographic
  table whose rows are indented, not prefixed with `<` at column zero. A filter
  that only skips lines *beginning* with `<` counts those rows as short prose:
  T3 measured at a median of 65 characters and read as badly wrapped when its
  real prose median was 325 — the highest in the corpus. Worse, the unwrapper
  then JOINED the table onto four lines. The tags survived so it still rendered,
  but the source was destroyed. Skip any line that differs from its own
  `lstrip()`. Found 3 August 2026, after both the false reading and the damage.
  Let lines wrap naturally; a blank line separates paragraphs. T10 arrived with
  493 prose lines at a median of 66 characters against 122–176 everywhere else.
  Unwrapping must leave the YAML front matter alone — it is unindented plain text, so filters that skip code
  chunks, headings, labels, lists and indented lines do not catch it, and
  joining `title:` to `tutorial:` breaks the build.

## 10. Missing values and filtering

**This section REVERSES the "filtering is good practice" advice that T4-T7
carried.** Decided 1 August 2026.

- **Filter only the variables that actually have missing values.** Sometimes
  that means both variables, sometimes one, sometimes neither. "Filtering is
  good practice" and "always filter before plotting" are banned for the same
  reason "`na.rm = TRUE` is good practice" is banned in section 1: they teach a
  reflex in place of a check.
- **Where nothing needs filtering, do not raise filtering at all.** A sentence
  saying "no filter is needed here" introduces the idea in order to negate it.
  If a deletion leaves such a sentence as the first mention of a function in the
  tutorial, the sentence goes.
- **State the count wherever a variable is introduced, including when it is
  zero.** "Neither variable has any missing values, so all 3,112 counties appear
  in the table" is as necessary as the positive case. This extends the
  T6-onward rule in section 7 to the whole sequence.
- **T2 IS AN EXCEPTION: it may withhold its counts.** The rule above says state
  the count where the variable is introduced. T2's Practices 20 and 21 make
  FINDING the counts the graded exercise --- `sum(is.na(unFBposts$message))` is
  what the student is being taught to write. Stating 173 and 1 beforehand would
  remove the task. The counts are given immediately after the student computes
  them and brought together before the summary-function section, which is the
  right place for that tutorial. Recorded 3 August 2026 so this is not
  re-flagged as a violation. The exception is narrow: it applies where counting
  missing values is itself the skill being introduced and graded, not where the
  count is context for some other analysis.
- **Never infer a joint count by subtraction.** Two variables missing 95 and 34
  of 167 do not leave 38 --- the missing sets overlap. `gender_equal3` and
  `regime_type3` leave 61. Take it from the output or from
  `sum(complete.cases(...))`.
- **Graders: pass with a nudge.** A student who filters a complete variable
  still passes; the `pass()` message adds that the filter was harmless here but
  the counts were the thing to check. Failing them punishes a habit the earlier
  tutorials built.
- **Show the unfiltered result first where a variable genuinely has gaps**, so
  the filter fixes something the student watched break. Two constraints on where
  this can go. `CrossTable()` drops missing cases SILENTLY --- no NA row or
  column, only a total that quietly falls --- so the demonstration has to be a
  plot. And `ggplot()` warns about dropped rows only for CONTINUOUS missing
  values; a factor with NAs simply gains an NA level, which is why they render
  as bars. Do not promise a warning that will not appear.
- **Removing a filter orphans the pipe.** `counties %>% ggplot(...)` with
  nothing in between pipes through nothing. House pattern:
  `ggplot(data = counties, mapping = aes(...))` when there is no intermediate
  step, `counties %>% filter(...) %>% ggplot(...)` when there is. Check the
  `library(dplyr)` call and any prose justifying the pipe at the same time.

## 11. Describing output you cannot see

- **Check every series against the claim, not the one that suggested it.** "For
  every group the tallest bar is at X" needs all groups verified. This failed
  twice in one section.
- **An NA level looks like a category and is not one.** A factor's NA level gets
  a bar, a panel, a legend entry, a box --- exactly like a real category.
  Counting it as one commits the error the demonstration exists to expose. Where
  a plot has two different NAs, one on an axis and one in the legend, never
  write "the NA bar" --- name which variable is missing.
- **One point per debrief.** When a debrief needs a third correction, the
  problem is usually its length rather than its wording: every extra claim is
  another chance to misdescribe. Cut to the point the box exists to make.
- **`fig.alt` carries the same claims as the debrief and no more.** If the
  debrief is cut, cut the alt text with it.

- **Ask for a render before describing any plot.** Six plots in T8 produced
  five wrong claims, every one written from summary statistics rather than from
  the figure. **A box plot shows quartiles — not means, not standard
  deviations**: "the widest spread" was true of the SDs and false of the boxes,
  and "the mean sits above three-quarters of the group" was false once
  `quantile()` was run. Ask for `quantile()` before saying where a mean falls
  relative to a box.
- **Two of those five sat inside a question's CORRECT ANSWER.** Check the
  options and their messages against the render, not only the prose.
- **Do not "correct" a verified number from pixels.** An axis made \$85,868 look
  lower than \$85,000 and a correct claim was retracted on that basis.
- **A claim about a range must be checked with `range()`.** "Individual samples
  give you everything from around 0.15 to 0.60" described the bulk; the range
  was 0.08 to 0.76, and the true figure made the tutorial's own point better.

- **[script] Compare every variable description across tutorials.** A sentence
  describing what a variable measures can be wrong in one tutorial and right in
  another, and no within-file check sees it. Extract the sentence following each
  `**variable**` in prose, group by variable name, and read any variable
  described two different ways. Found on 3 August 2026, in files that had all
  passed review: `wage_growth` as "the percent change in average wages from 2008
  to 2016" in T9 and T14 against T6's correct sourcing (BLS Quarterly Census of
  Employment and Wages, Q3 2015 to Q3 2016, twelve months);
  `prop_college_grad` as "a county's population" in T13 and "adults in a county"
  in T9 against T8's correct "adults over 25"; `rural` as nominal in T12 and T13
  against T7's correct ordinal. **Check the codebook** --- all seven now exist
  (see the Codebooks section), and a codebook outranks any tutorial's wording.
  Where a variable is not in one, T6 is authoritative for `wage_growth` and
  `employ_pop_ratio_25_64`, and the poliscidata package documentation for
  `world` variables.

- **`reorder()` plus a hand-written `labels =` vector silently mislabels the
  bars.** `scale_x_discrete(labels = ...)` matches labels to POSITIONS on the
  axis, not to values, so once `reorder()` has sorted the categories by count
  the vector must be listed in the NEW order. T4's Explore 25 listed them
  alphabetically --- `c("Black", "Hispanic", "Other/No", "White")` against a
  scale ordered Other/No (48), Hispanic (96), Black (102), White (2,866) --- so
  the 48-county bar read "Black" and the 102-county bar read "Other/No". The
  plot renders, nothing errors, and each label is individually plausible.
  **Found 3 August 2026 only from a screenshot.** Whenever `reorder()` and a
  labels vector appear in the same chunk, work out the sorted order and check
  the vector against it. Say so in the prose too, or a student will "correct"
  the vector back to alphabetical.

## 12. Editing discipline

Every failure in the T7 pass was in what an edit LEFT BEHIND, not in the edit.

- **After removing anything from an exercise, re-read the whole item in order
  --- starter, every hint, the grader, its fail messages, and the surrounding
  prose --- as a student meets it.** Three separate defects escaped file-level
  checks and surfaced only on render: an orphaned pipe, a dangling negation, and
  a hint aimed at a blank that no longer existed.
- **After moving a block, re-grep for the item labels and re-run the numbering
  check.** A splice that runs one line long silently drops a `**Practice N:**`
  heading.
- **Inserting or removing a box renumbers everything after it** --- item labels,
  `exercise.cap` values, and any cross-reference in prose or hints ("the order
  `levels()` returned in Run and observe 16").
- **Restate a fact where it is used.** A statement made at the variable
  introduction is several learnr PAGES back by the time a plotting section needs
  it. "gender_equal3 is stored as a factor" was stated correctly and was still
  330 lines and one `##` section away from where it mattered.
- **A check for something missing must not require the thing that is missing.**
  A scan for `**Type N:**` labels found none and reported "no items are
  labelled" — all 22 were labelled, just unnumbered, and 22 duplicates were then
  inserted. Match the loosest form first, then test for the missing part.
- **Where labels already exist, keep their titles.** Add the number and the
  type; do not rewrite wording that is already the author's.
- **Splices land in the wrong place when the search runs from the top of the
  file.** Anchor to the target chunk and search BACKWARDS for the nearest
  preceding heading; never let `.*?` span sections.
- **When a structural choice is contested, measure the sections.** Word,
  exercise and question counts per `##` settled in one command what two rounds
  of argument had not: a section holding two worked examples ran 2,101 words
  against 930–1,170 everywhere else, and relocating one example would have moved
  the bulge rather than removing it.
- **An outside review does not know what has already been decided.** Check its
  findings against the session's rulings before acting — one arrived proposing
  exactly the wording that had been settled an hour earlier.
- **When asked for the house pattern, find a section doing the SAME JOB**, not
  one that merely looks similar. A section reminding students of functions they
  already know is not a model for introducing a new one.

---

## Grader strings: READ THEM, do not pattern-match them

The population is small and finite --- T7 has 49, T9 50, T12 34, T8 84. Dump
every `fail()` and `pass()` string and read the list. It takes minutes and it
is the only method that works.

- **A regex verification built from the same assumptions as the regex fix will
  confirm the fix's own blind spot.** On 3 August both T7 and T8 reported "0
  unformatted" while a dozen strings were wrong in each: the sweep had no rule
  for `labs()` arguments and neither did the check. Reading found 13 in T7, 12
  in T8, 16 in T9, and 31 of 34 in T12 --- T12's graders had never had a markup
  pass at all.
- **KNOW THE QUOTE STYLE BEFORE INSERTING A QUOTED VALUE.** This broke two
  files on 3 August and three separate checks passed it both times.
  `fail('Set `alternative = "greater"` ...')` is fine --- single-quoted R
  string, literal `"` is legal. `pass("... `alternative = "greater"` ...")` is
  BROKEN --- the string terminates at the first inner quote and the grader
  fails to parse. Inside a double-quoted string the inner quotes must stay
  escaped as `\"`.
- **Quote PARITY does not detect this.** A broken string often has an even
  number of quotes. Brace-and-paren balance does not detect it either, because
  the checker strips quoted regions first and mis-quoting makes it strip the
  wrong spans. The check that works: for each `fail(`/`pass(`, find where its
  opening quote closes while honouring backslash escapes, and confirm the next
  non-space character is `)` or `,`.
- **The only certain check is R's own parser.** `tools/check-chunks.R` runs
  `parse()` over every chunk in the package. Run it after any grader edit.

## Graders: inspect the object, not the submitted text

Six instances found on 3 August across T7 and T8 of a check that verifies a
string appears somewhere in the submission rather than verifying the thing.

- **T7's `position` and `group`** were `grepl("dodge", code_no_comments)` ---
  matching the word anywhere. Now: pull the `GeomBar` layer, test
  `class(layer$position)` is `"PositionDodge"`, and read `layer$mapping$group`.
- **Legend and axis label ORDER is the recurring bug.** `scale_*_discrete(labels
  = ...)` matches labels to POSITIONS. T4's Explore 25 shipped with two of four
  bars mislabelled; T7's Practice 15 and T8's Practice 12 would have passed a
  student who reordered the vector. Extract the labels in order and compare.
- **`descr::CrossTable` returns the argument values.** `$chisq` and `$expected`
  hold TRUE/FALSE exactly as passed; `$RowData` and `$ColData` hold the full
  variable expressions as strings. So `isTRUE(.result$chisq)` and
  `grepl("TrumpMajority", .result$RowData)` are exact. Verified in her console
  3 August, and the swapped-x/y case now fails where it used to pass.
- **An `htest` grader that checks `.result$p.value` needs nothing else.** A
  wrong `alternative`, filter, or formula all shift the p-value. T12's
  `prop.test`, T13's `t.test`/`oneway.test`, and T14's `cor.test` graders are
  all sound for this reason --- do not "harden" them.
- **Do NOT check values the starter supplies.** A grader that fails a student
  for altering a pre-written title punishes tampering, not misunderstanding.
  Declined on T5 Practice 13, T7 Practice 15, T8 Practice 12.
  **[script] Extract every literal in an exercise's starter code and every value
  its grader compares with `identical()` or `%in%`. A value appearing in both is
  a starter-supplied check and comes out.** The grader and the starter often sit
  two hundred lines apart, which is what reading misses. Applied backwards on
  4 August 2026 to T4 Practice 17, T5 Practice 6, T6 Practice 12 and T6
  Practice 17 --- sixteen checks, all written before this rule existed. **The
  same check can be right in one exercise and wrong in another**: T6's
  Practice 12 and Practice 18 carry an identical `color = "white"` test, and it
  is a defect only in Practice 12, because Practice 18's starter is empty and
  the student types it. Anchor on the surrounding block, never on the test
  alone. **And when a check goes, re-read the `pass()`** --- T5 Practice 6's
  credited the student for nine category labels the starter had handed over.

## Naming things in prose

Three kinds of name, three treatments, and they are not interchangeable.

**Variable names are bold.** `**wage_growth**`, `**electoral_f**`. This holds in
body prose, in `question()` stems, in `answer()` text and in grader messages.

**Code, function names and R output labels are backticked.** `` `factor()` ``,
`` `levels =` ``, `` `Multiple R-squared` ``, `` `democ_fPartial Democracy` ``.
An output label is what R prints, so it is code even when it reads like prose.

**Literal strings are in quotes, never bold.** That includes factor level names
and any prescribed string a student must type. Bolding a level name makes it
look like a variable, which is the confusion this rule exists to prevent --- a
student reading **Mixed** cannot tell whether to type `Mixed` or `"Mixed"`.

**Which quotes depends on whether the student TYPES the string**, and §5 has
the rule: a string that gets copied into code takes backslash-escaped quotes,
`\"Plurality/Majority\"`, so Pandoc's smart typography does not turn them into
curly quotes R will reject. A string merely referred to keeps ordinary quotes
and renders curly, which is correct for prose. Do NOT use backticks for either
--- backticks imply code formatting the string does not have.

## Data dates

Every example states the period its data cover, in the paragraph that
introduces the variables. A reader should never have to open the codebook to
learn what year a finding is about.

State the period for the OUTCOME and for any predictor measured at a different
time. Where a dataset is a single cross-section, one sentence covers it:

    Every variable in `counties` describes the county as of 2016.

Where variables come from different years, say so and say which:

    The Freedom House scores assess 2016; the survey responses come from
    World Values Survey Wave 7, fielded between 2017 and 2023.

Where a dataset takes each variable from its own most recent available year,
say that rather than implying a common date:

    Variables in that cross-section take their most recent available
    observation as of the January 2020 release, so they are not all measured
    in the same year --- consult `?qog` when a specific year matters.

The current periods:

| Dataset | Period |
|:--|:--|
| `counties` | 2016 |
| `ipu` | August 2026; `first_woman_year` runs 1907--2021 |
| `fHouse` | Freedom House 2016 and 2022; WVS Wave 7 fielded 2017--2023 |
| `qog` | January 2020 cross-section, most recent available observation per variable |
| `world` | mixed; see `?world` |
| `states` | 2010 |
| `statesPolicy` | mixed, 2020--2024 by variable name |
| `unFBposts` | see `?unFBposts` |

**Where temporal ordering is part of the argument, state it explicitly and say
why it matters.** A predictor measured after its outcome cannot explain it,
and a reader cannot check that unless the dates are on the page.

## Math mode

Use `$...$` for symbols, equations and anything with a subscript, superscript
or Greek letter:

    $\hat{Y} = \hat{\alpha} + \hat{\beta}X$
    where $\alpha$ is the intercept
    $H_0: \beta = 0$

Do NOT use it for arithmetic on plain numbers. Write those as text:

    5 × 0.314 = 1.57 percentage points          <- correct
    $5 \times 0.314 = 1.57$ percentage points   <- wrong

Two reasons. MathJax renders at a different size from the surrounding text, so
a sentence containing both a math-mode number and a plain one shows the same
quantity at two sizes. And MathJax sizing is unstable on first render --- the
math is noticeably larger before the page settles --- which makes a paragraph
of mixed arithmetic look broken to a student who has just opened the tutorial.

Use the multiplication sign `×` and the minus sign `−` rather than `*` and `-`
when writing arithmetic as text, so it reads as arithmetic rather than as code.

The same rule applies inside `question()` stems, `answer()` text and grader
messages. Math renders in body prose, `question()` and `fig.cap`, but not in
`fig.alt` or ggplot `labs()` --- so a quantity written in math mode cannot be
reused in alt text without rewriting it.

## Codebooks

All seven exist, confirmed 4 August 2026: `data-counties.R`, `data-world.R`,
`data-qog.R`, `data-states.R`, `data-fHouse.R`, `data-statesPolicy.R` and
`data-unFBposts.R`.

- **Check every variable description against the codebook, not against other
  tutorials.** Standardising across files makes them consistent, not correct:
  `prop_college_grad` read "adults over 25" in T8, T9 and T13 because it was
  standardised that way from T8's wording; the codebook says "age 25 or older
  who have completed a bachelor's degree or higher".
- **A codebook that gives only an observed range makes a correct scale
  description look wrong.** `effectiveness` runs 0--100 theoretically but
  7.80--100 observed. State both.
- **`data-usage.R`** maps each `.RData` file to the objects inside it and finds
  where each is used. A file name does not tell you the object name.

## Markup sweeps

Five grader-markup sweeps on 3 August 2026 needed repair afterwards. The causes
repeat, so build them into any future sweep rather than trusting care.

- **Run the sweep line by line inside grader chunks, never as a whole-file
  `re.sub`.** A negated character class such as ``[^`]*`` matches NEWLINES in
  Python, so a pattern
  meant to act inside one span matches from the first backtick in the file to
  the last. One such command stripped every `**` from T5 — all labels, all
  spans, all bolded names — and there was no undo. Recovered only because she
  had her own copy.
- **Diff against a pre-sweep copy before accepting the result.** Compare line
  counts, and walk each changed line back to its enclosing chunk to confirm the
  change landed inside a `-check` block. This caught two adjacent-backtick
  malformations in T2 and confirmed an intentional out-of-chunk edit in the same
  run.
- **Protect what is already marked up, and re-protect after every rule.** Without
  it a sweep bolds inside code: `after_stat(**prop**)`, `filter(!is.na(**x**))`,
  `` `factor(**rural_urban**)` ``. Wrap whole expressions FIRST, stash them, then
  do function names, then variable names.
- **Names at the end of a sentence are invisible to a naive lookahead.**
  A lookahead excluding ``[\w.`*]`` also excludes a following period, so
  `unFBposts.` never matches. Cost
  a second pass in T2 (22 names) and T4 (9).
- **Character classes must not be lowercase-only.** `[a-z_.]+` missed `FHStatus`
  in T5, both in the compound-expression rule and the `factor()` rule.
- **Most English words that look like function names are English words.** Of
  nine bare-name hits in T1, only three were real: the rest were "a narrow
  range", "positive values mean", "must sum to", "the class of".
- **A verification regex spanning two code spans is a false positive.**
  `` `a` … **bold** … `b` `` matches a "bold inside backticks" test that meant to
  look inside one span. Check flagged hits before acting on them.

## Environment gotchas

**learnr runs every exercise in one R process.** `library()` in any box attaches
the package globally for the rest of the session. Any tutorial that demonstrates
a "could not find function" error *before* loading the package will work on a
fresh start and silently stop working once a student runs the loading box. Guard
it with a setup chunk that detaches first:

```r
if ("package:ggplot2" %in% search()) detach("package:ggplot2")
```

wired in with `exercise.setup=`. Detaching from the search path is enough;
`unload = TRUE` has more side effects.

**`options(help_type = "text")`** is required in any tutorial that teaches `?`
or `help()`. learnr cannot display R's HTML help browser, so without it the
exercise produces nothing visible.

**`options(lifecycle_verbosity = "quiet")`** suppresses tidyselect deprecation
warnings surfacing through gradethis.

**MathJax:** no CSS or JS intervention on sizing. Default v2 rendering accepted
(decided 27 July 2026).

**Mojibake in shipped data.** `unFBposts$message` was double-encoded from
Windows-1252, not Latin-1 — the distinction matters, because Latin-1 leaves
0x80–0x9F undefined while CP1252 fills it with curly quotes and dashes. Detect
with `grepl("Ã|Â|â", x)`; the `â` is essential, since curly apostrophes are
usually the bulk of it. Repair with
`iconv(x, from = "UTF-8", to = "WINDOWS-1252")` then `Encoding(x) <- "UTF-8"`.
`table(regmatches(x[bad], regexpr("Ã.|Â.|â..", x[bad])))` shows which sequences
are present. All four datasets have been checked; only `unFBposts` was affected.

**Paren and brace counting is not a reliable check on these files.** Graders
contain regexes like `grepl("filter\\s*\\(", code)`, where the literal paren
inside a doubled-backslash escape defeats naive string stripping. Five of
fourteen tutorials flag as unbalanced while all fourteen render. Use the count to
compare a file against ITSELF before and after an edit --- that is still
meaningful --- but never as evidence that a file is sound.

**`moderndive` silently breaks `oneway.test()`.** It depends on `formula.tools`,
which registers an S3 method `as.character.formula` that deparses a formula to a
single string; `stats::oneway.test` runs `as.character(formula)` internally and
stops with **"a two-sided formula is required"** when the result is not length 3.
The method registers when the namespace is LOADED, not attached, so neither
package appears in `search()`; `stats::` qualification does not help, because
that fixes which function runs and not which S3 method a generic dispatches to.
`traceback()` shows only the `stop()` and misleads. Diagnose with
`as.character(y ~ x)` --- one string means this bug --- then `methods("as.character")`,
`getAnywhere("as.character.formula")`, and `tools::dependsOnPkgs("formula.tools")`.
`moderndive` is T10's and T11's package; a student who runs T10 and then T13 in
one R session hits this, and it cannot be fixed from inside T13.

**Exercises that look broken but are right.** T2's Apply 40 asked for the
message of the least-liked post; nineteen posts tie at zero likes and all
nineteen have no text, so the correct answer was a screen of NAs. Run a graded
exercise's expected answer against the real data before assuming the output
will read sensibly.
