# Review Status

Which sections of `QPA-review-standards` have been checked against which
tutorial, and **against which version of the standards**.

## Why the version and not a checkmark

On 3 August 2026, T1--T14 were marked "full treatment" and committed as
`c5e675c`. On 4 August the pass over T1--T6 found roughly a hundred edits'
worth of defects in those same six files.

Those earlier verdicts were not careless. The standards changed underneath
them: §5 did not cover grader strings until v17.8, §6 had no Overview rule,
and the Takeaways forward pointer did not exist. A tutorial marked done is
done *against the standards as they stood that day*, and a plain tick hides
that.

So a cell records the version the check was run against. Bump the standards
and this file shows you immediately which tutorials fell behind, and on which
sections.

**A cell is filled only when the section was worked bullet by bullet.**
Running a section's scripted checks is not running the section. Where a script
surfaced candidates and a human read them, that counts; where a script came
back empty and nobody read anything, it does not.

---

## Sections

| # | Section | # | Section |
|---|---|---|---|
| 1 | Graders | 7 | Accessibility |
| 2 | Exercises | 8 | Language |
| 3 | Hints | 9 | Voice |
| 4 | Multiple choice | 10 | Missing values and filtering |
| 5 | Markup | 11 | Describing output you cannot see |
| 6 | Structure | 12 | Editing discipline |

---

## Status

`18` = checked against v18 · `17.10`, `17.9`, `17.8`, `17` = checked against
that version or earlier · `--` = not run · `*` = partial, see notes ·
`n/a` = does not apply

**No cell reads `18`.** The 8 August pass was review-driven, not a
section-by-section sweep, so no section was worked bullet by bullet against v18
on any tutorial. See "What the 8 August pass actually was" below before reading
the table as a list of gaps.

| Tutorial | §1 | §2 | §3 | §4 | §5 | §6 | §7 | §8 | §9 | §10 | §11 | §12 |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| T1  R Basics: Part 1        | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 |
| T2  R Basics: Part 2        | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 |
| T3  Levels of Measurement   | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 |
| T4  Univariate: Nominal     | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 |
| T5  Univariate: Ordinal     | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 |
| T6  Univariate: Interval    | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 | 17.8 |
| T7  Bivariate: Two Cat      | 17 | 17 | 17 | 17.9 | 17.9 | 17.9 | 17 | 17 | 17 | 17 | 17 | 17.9 |
| T8  Bivariate: Cat × Int    | 17 | 17 | 17 | 17 | 17.9 | 17.9 | 17 | 17 | 17 | 17 | 17 | 17.9 |
| T9  Bivariate: Two Int      | 17 | 17 | 17 | 17 | 17.9 | 17.9 | 17 | 17 | 17 | 17 | 17 | 17.9 |
| T10 Logic of Inference      | 17 | 17 | 17 | 17 | 17.9 | 17.9 | 17.9 | 17 | 17* | n/a | 17 | 17.9 |
| T11 Hypothesis Testing      | 17 | 17 | 17 | 17 | 17.9 | 17.9 | 17.9 | 17.9 | 17.9 | n/a | 17.9 | 17.9 |
| T12 Hyp Tests: Two Cat      | 17 | 17 | 17 | 17 | 17.9 | 17.9 | 17.9 | 17 | -- | 17 | 17 | 17.9 |
| T13 Hyp Tests: Cat and Int  | 17.9 | 17 | 17.9 | 17.9 | 17.9 | 17.9 | **17.10\*** | 17 | -- | 17 | 17 | 17.9 |
| T14 Hyp Tests: Two Int      | 17 | 17 | 17 | 17.9 | 17.9 | 17.9 | **17.10\*** | 17.9 | -- | 17 | 17 | 17.9 |
| T15 Simple Regression       | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** |
| T16 Multiple Regression     | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** |
| T17 Coefficients to Preds   | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** |
| T18 Interactions            | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** |
| T19 Interaction Pred Plots  | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** |
| T20 Logistic Regression     | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** |
| T21 Logit Predictions       | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** | **17.10** |

### THE T15--T19 VERDICTS WERE IN DOUBT --- LARGELY RESOLVED 8 AUGUST

The previous version of this file recorded that an outside review of T15 on
8 August found nine real defects in sections reported clean. **All nine were
fixed that day, and T16--T21 then went through the same external review with
their findings applied.** The `17.10` verdicts in those rows are now backed by
a second, independent read of every file rather than by my checks alone.

**One claim in the old note is stale and is corrected here: T15--T19 are not
without `fig.alt`.** Current counts are T16 2, T17 8, T18 1, T19 6. **T15 has
none and needs none** --- it has no exercise that produces a plot
(`inherits(.result, "ggplot")` appears zero times in its graders).

**The methodological warning stands and should not be deleted.** The common
cause was checks that answered easier questions than the rules ask. On 8 August
the same failure recurred: a nested-backtick check I had just written came back
empty on a real defect because its pattern was too narrow, and I reported the
item already fixed. **Validate every check against a known defect before
trusting a clean report --- and treat a null from my own checker as evidence
about the checker.**

### Notes on the partials

- **T13 and T14 carry `17.10*` on §7** because only one §7 item was run on them:
  the completion-banner check. Their `aria-label` values now match their visible
  text, and `---` inside the raw-HTML `cat()` block has become `&mdash;` so it
  stops rendering as three hyphens. Nothing else in §7 was run.
  **T1--T12 were never affected by the `---` defect** — the habit starts at T13.
- **T20 and T21 are complete on all twelve sections at v17.10**, finished
  8 August 2026, run horizontally one section at a time across the pair. A final
  combined battery returned zero on both, and it was validated first by
  injecting known defects and confirming each one fired.
- **T15--T19 are complete on all twelve sections at v17.10**, run horizontally
  — one section at a time across all five files rather than one file at a time.
  A final combined battery over all five returned zero findings.
- Notes on T1--T14 from the previous version stand unchanged: T10's §9 partial,
  T11's n/a cells, §9 never run on T12--T14, §2 still at `17` on T12--T14.

---

## What the 8 August pass actually was

**Every one of the 21 tutorials went through an external review (ChatGPT) and
had its findings worked through.** That is a different exercise from a
section-by-section pass, and the table above is right not to record it as one:
a reviewer reads a file the way a student would and finds what that reading
finds, which is not the same as walking §1 through §12.

It found things the section passes had missed, repeatedly, in files marked
complete. Worth knowing what kind of thing, because it predicts where the next
one will find more:

- **Numbers that no longer match the fit.** T15's Example 2 carried four
  mutually incompatible sets of coefficients; T19's Example 1 had six wrong
  predicted values and described a crossing as a convergence.
- **A hypothesis and the theory above it disagreeing.** T18 and T19 both stated
  a directional mechanism and then a nondirectional hypothesis.
- **Graders that search the submission rather than check the result.** About
  twenty were rebuilt. Where the object already exists in the invisible setup,
  a text check proves nothing.
- **Inference language stronger than the statistics support.** Relative-
  importance rankings, post-hoc power explanations for null results,
  "the interaction is real", confidence bands read as tests.
- **A false technical claim**: that a bare character string cannot be supplied
  for a factor level. `predict.glm()` converts it using the fitted `xlev`. It
  appeared in three files and took five passes to clear.

## Standards raised to v18

Fourteen rules corrected or scoped rather than added --- see the changelog at
the head of the standards document. Because they are corrections, **nothing in
the corpus falls behind on them in the way a new rule would cause**: a tutorial
checked at v17.10 was not checked against a rule that v18 has since narrowed.
The version column matters most for the three genuinely new entries: the
scaffold exceptions (T16 P15, T19 P3/P7/P15, T20's two `stargazer()` starters),
the nine tutorials with no infographic, and the reported-statistics markup rule.

The two accessibility gaps logged on 7 August: **the `fig.alt` gap is closed**
(see the T15--T19 note above). **The hue-alone gap is still open** ---
`linetype` appears once in T19 and nowhere in T17 or T21, `shape` is used for
point shapes rather than for group separation.

## What v17.10 added (historical)

Four new sections and one amendment, all written during the T15--T19 pass:

1. **Naming things in prose** — variable names bold; code, function names and
   R output labels backticked; **strings the student types in backslash-escaped
   quotes**, so Pandoc does not curl them into characters R rejects. Not
   backticks — those imply code formatting the string does not have.
2. **Data dates** — every example states the period its data cover, with a
   table of the current period for all seven datasets.
3. **Math mode** — `$...$` for symbols and equations, plain text for arithmetic
   on plain numbers, because MathJax renders at a different size and is
   unstable on first render.
4. **A redundant-box rule** — a callout that opens by conceding the reader
   already knows ("As in earlier tutorials") should not exist.
5. **§4 amendment** — measure answer length against the **mean** distractor and
   flag above **1.25×**, not against the longest. At the old threshold four of
   seventy-nine questions flagged; at the new one, forty-four did.

---

## Cross-cutting items

| Item | Done | Outstanding |
|---|---|---|
| Overview rewritten to the v17.8 rule | T1--T21 | none outstanding |
| YAML `description:` rewritten | T1--T21 | none outstanding |
| Takeaways forward pointer | T1--T14, **T20** | T15--T19. **T21 is a deliberate exception** --- last in the sequence, ends on its own material; recorded in §6 |
| `data()` convention in setup | T5--T13, **T20, T21** | T1--T4, T14--T19 |
| `options(cli.num_colors = 1)` in setup | T5--T13 | T1--T4, T14--T21. Absent from T15--T19 too, so T20/T21 are not out of step |
| `options(lifecycle_verbosity = "quiet")` in setup | T15--T19 and 13 others, **T20, T21** | none outstanding |
| Codebook check on variable descriptions | T7--T9, T12, T13, T15--T19, **T20, T21** | T1--T6, T14 |
| Completion banner: label matches visible text, `&mdash;` not `---` | T13--T21 | none outstanding |
| Escaped quotes on strings students type | T15--T19, **T20, T21** | T1--T14 |
| Answer length at 1.25× of mean distractor | T15--T19, **T20, T21** | T1--T14 |
| Data period stated in every example | **T20, T21** | T1--T19 unchecked |
| Missing-value counts where variables are introduced | **T20, T21** | T1--T19 unchecked |
| Items numbered in one ascending sequence, `exercise.cap` = `Type N` | T1--T19, **T20 (1--29), T21 (1--32)** | none outstanding |
| `fig.alt` on figures produced by STUDENT code | T16--T19, **T20 (n/a --- no plot exercises), T21 (all 11)**. T15 n/a --- it has no plot exercises | none outstanding |
| Grouped prediction plots distinguished by more than hue | none | **T17, T19, T21 --- still open.** `linetype` appears once in T19, nowhere in T17 or T21 |

---

## Git

- `c5e675c` (3 Aug) — T1--T14 full treatment.
- `53e8ba0` (5 Aug) — T15--T19 data rebuilds and example replacement.
- `af72566` (7 Aug) — the T15--T19 standards pass, plus T13/T14/T20/T21
  banners, `a11y.css`, `tools/render-diagrams.R`, T18's `conditional.png`,
  `.Rbuildignore` excluding `tools/`, and the standards document itself now
  tracked at the repo root.
- **`1fd1a96` (8 Aug) — the external-review pass over all 21 tutorials.**
  29 files, 2,791 insertions, 1,743 deletions: every tutorial, the standards at
  v18, three regenerated diagram PNGs, `tools/render-diagrams.R`, and two new
  tracked tools --- `tools/qpa-standards-battery.py` (the checker, ~40 checks)
  and `tools/extract-code.py` (generates the all-code files).

**Nothing is uncommitted.** `.gitignore` gained `tools/T*-all-code.R` on
8 August --- a narrow rule, NOT the whole folder, because `create-fHouse.R`,
`create-world.R`, `rebuild-counties.R` and `render-diagrams.R` are tracked and
must stay so. `.Rbuildignore` already excluded `^tools$`, so the answer keys
never reached the built package either.

## Open items not tied to a section

- **TESTING IS THE BINDING CONSTRAINT, and it is the largest open item.**
  - **Twelve rebuilt graders have never been run**: five in T20 (Practice 14,
    both `hitmiss()`, both `stargazer()`) and seven in T19/T21 (two `predict()`
    pairs, five plot graders).
  - **The untested assumption that would break the most** is `ggplot_build()`
    on a `plot_model()` object exposing `$data[[1]]$group`. Seven plot graders
    depend on it; if it is wrong they reject EVERY submission, which is worse
    than the weak graders they replaced.
  - Confirmed by her console on 8 August, so no longer a risk:
    `pscl::hitmiss()` returns a plain numeric vector, and
    `stargazer(type = "text")` returns its lines invisibly as `.result`.
  - **60 reconstructed answers in T2--T14 have never been run either.** Plot
    answers are the likeliest failures --- they depend on exact prescribed
    strings, fill colours, and whether a grader wants `factor(rural_urban)` or
    the bare variable.
- **All-code files: 20 exist**, one per tutorial with exercises (T3 has none).
  **T2--T14 and T20--T21 are complete.** T1 and T15--T19 carry **43 unfilled
  TODO entries** between them. Generated by `tools/extract-code.py`, which
  **refuses to overwrite a file with no TODO markers** unless passed `--force`
  --- added after the generator destroyed T20's and T21's finished files and
  they were recovered only by luck. Not tracked in git; the repo is public and
  they are answer keys.
- **T10's 26 wrapped lines** inside `:::` divs (§9) — parked by the author.
- **T9's three-column Takeaways infographic** may want the `narrow-label` CSS
  variant. Never rendered.
- **T13's front-loading** — 1,782 words. The obvious cut was rejected twice.
- **§9 has never been run on T12, T13 or T14.**
- **The readings need a pass** — `SimpleRegression`, `MultipleRegression`,
  `LogisticRegression` `.qmd`. Different voice; fixes may not transfer.
- **Canvas pages** referencing tutorial numbers need updating after the T19
  split created T20 and T21.
- `data-world.R` has no `gini04` entry, and describes `democ` as binary when it
  is a three-level factor.
- T20/T21 build `rural_cat` with `cut()` — a second recode of `rural_urban`
  alongside the shipped `rural`. Worth reconciling.

---

## Settled during the T15--T19 pass — do not re-raise

- **"Effect" is a defined term.** T15 states the convention, T16 defines and
  spans it, T17's Takeaways restate it. It appears in headings ("How Large Are
  the Effects?"). Purging it would be the inconsistency, not keeping it.
- **`qog` keeps its name.** 128 sites across six tutorials.
- **R output labels are backticked**, not quoted — they are literal machine
  text, and the student's task is matching them in monospaced console output.
- **Em dashes inside `aria-label` attributes are correct.** An HTML attribute
  is not markdown.
- **T20's back-to-back hypothesis boxes are correct** — two hypotheses, one box
  each. §7's rule concerns different kinds of box stacking.
- **Simulated data may demonstrate statistical behaviour in the body** (T06,
  T09--T13, T21) but **never stands as a substantive example**. `bills_df` stays
  in T20's Check Your Understanding for that reason.
- **A template earns its place only when the first from-scratch use has no
  worked instance behind it in the same example.** `plot_model()` qualified;
  `lm()` did not.

---

## Settled on T20 and T21 --- do not re-raise

- **`republican` in `states` is the percentage of residents identifying as
  Republican, not a legislative seat share.** Confirmed against the codebook's
  `liberal` and `hs_dem_prop_all` entries and against the data: Utah is 45.9 on
  `republican` while Republicans hold 71% of its house seats. T20's axis label
  and its chamber-control narrative were both wrong and are fixed; a
  `republican` entry was added to `data-states.R`.
- **Changing a reference category does not shift fitted values.** T20's box said
  it did, contradicting T16. It now says what is true: the reference level is the
  default held value, so it decides which profile a default prediction describes.
- **`rural_cat` uses the shipped `rural`, labelled Urban / Intermediate /
  Rural.** The old `cut(rural_urban, breaks = c(0, 3, 6, 9))` put code 7 in the
  wrong bin, inflating the Rural group by 425 counties. Correcting it made
  `rural_catRural` significant (p = .032) where it had been null, which rewrote
  two `correct = TRUE` answers.
- **T21's Check Your Understanding is built on hypothetical scenarios, not on
  the tutorial's own plots**, matching T17. All simulated data is gone from T21.
- **The prettified message is taught, not suppressed.** `[all]` is prescribed in
  prompts, starters and graders; the two factor plots correctly do not take it.

---

*Last updated 8 August 2026, after the external-review pass over all 21
tutorials and the push of `1fd1a96`. Standards version current at that date:
**v18**.*
