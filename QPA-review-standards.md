# QPATutorialsCourse — Review Standards (v19)

**Extended later on 25 August 2026** with the T12--T21 work: the reframing
carried into the three testing tutorials, the pronoun sweep completed corpus-wide,
`try_again` stripped of its "Hint:" prefix in 63 places, three tutorials
restructured for section length, and a grader audit across T15--T21 that added a
`TRUE`/`FALSE` check to all 46 and brought eight graders up to what their prompts
prescribe. **Five status claims in this document were found stale that day** ---
the T7--T9 infographic order, T9's library paragraph, T11's wrapped prose, the
three-option question exceptions, and `fig.alt` in T15--T19. All five are
corrected in place and marked with the date verified.

**New in v19**, from the TA-review grader work and the inference reframing of
24--25 August 2026, across T4 and T6--T11. Three kinds of entry: new grader
rules in §1, the reframing vocabulary in §8, and **corrections to three claims
this document made about T7--T11 that were already out of date.**

**THE STALE-CLAIM PROBLEM IS THE MOST IMPORTANT ENTRY HERE.** Three separate
claims in v18.2 about what T7--T11 still needed had already been fixed by the
time they were checked: the infographic reorder, T9's library paragraph, and
T11's wrapped prose. Each cost a check to disprove. **Before enforcing any
"tutorial X still needs Y" claim in this document, verify it against the file.**
The rules describing a shape or a test remain reliable; the status claims decay.

**New grader rules (§1):**
- **`TRUE` and `FALSE` are written in full; `T` and `F` are rejected.** 27 check
  sites across T1, T2, T5, T6, T7 and T9. Two message variants, one where the
  argument is needed and one where it is not.
- **A grader must never assert something the student can see is false.** T6's
  `range()` message said "Your `range()` call returns NA" while the result sat
  on screen, because `na.rm = T` was read as the argument being absent.
- **ggplot no longer stores DEFAULT labels on the plot object.** `p$labels` is
  an empty named list for a plot whose labels were never set, so
  `is.null(.result$labels$x)` cannot tell "wrote `x = NULL`" from "wrote
  nothing" and passes both. Eight such checks across T4--T8 were dead. Scope
  the check to the `labs()` call in the submitted code instead.
  **The general lesson: a check that tests for ABSENCE fails OPEN.** It passes a
  wrong answer silently, where a check on a value fails loudly if the API moves.
  Audit those first in any tutorial not yet reviewed.
- **Label comparisons echo the student's own text**, so an invisible difference
  such as a trailing space becomes visible. 32 sites across T4--T9.
- **Scale-label checks split into branches** rather than one `identical()`:
  missing scale, unmatched stored value, a stray key matching nothing, wrong
  replacement text, and (where the expected text contains one) a missing `\n`.

**Reframing vocabulary (§8):**
- **A hypothesis is a claim about a general political relationship; the
  particular election or cross-section is the evidence.** Settled 24 August
  after she judged the old framing contrived: the counties and world data are
  near-complete cases, and justifying inference by calling them a sample from a
  finite population is not true of the data.
- **Interval-outcome hypotheses read "will tend to have".** A tendency admits
  exceptions, which is what makes inference the right tool. Categorical-outcome
  hypotheses already read "will be more likely to" and are untouched.
  **The "In a comparison of [cases]" template STAYS** --- she teaches it, and it
  names the unit of analysis, which free prose drops.
- **"larger than chance" and "statistical significance" are OUT** of the
  descriptive tutorials. The replacement, used seven times across T7--T9:
  *whether a pattern this large would be surprising if there were no systematic
  relationship between the variables.* "Chance" invites "chance from what?",
  which is the question the reframing exists to answer.
- **Do not call complete data a sample.** Fixed in T6's n-1 explanation, its
  range paragraph and its Takeaways; in T8's "small-sample noise" for a group of
  96 counties; and in T10's claim that any 40-country data set is a sample.
  Genuine samples keep the word: T8's invented commute-time cities, T9's
  correlation formula terms, T11's Gallup survey.

**Voice (§9):** the pronoun sweep is NARROW. Only authorial `we`/`us`/`our`
goes --- promises about the document, and possessives for things belonging to
the reader. `we` meaning the discipline's practice or the shared walkthrough
STAYS. T10 and T11 legitimately carry far more of it than T7--T9 because they
are narrative simulations; that is a genre difference, not a defect.

**Editing discipline (§12): RAISE AN ISSUE BEFORE REVISING, NOT IN THE MESSAGE
CARRYING THE FILE.** Her ruling, 24 August, after I flagged an open question in
a delivery: anything known to be unresolved stops the edit until she has ruled.

**Also settled:** the pipe stays `%>%` corpus-wide, with a note in T4 that `|>`
exists and either is accepted; a migration, if ever done, goes across tutorials,
decks, problem sets and readings in one pass.

**New in v18.2**, from the T1--T6 Takeaways rebuild of 9 August 2026. §6 gains
six rules for the Takeaways and §8 gains two on overstatement. The one REVERSAL:
**motivation now comes before the infographic**, replacing the 8 August rule that
the infographic opens the Takeaways. T1--T6 have been brought into line;
**T7, T8, T9, T12, T13 and T14 have not.**

**New in v18.1**, from the T1--T9 pass of 9 August 2026. Two §5 changes to the
key-term scheme, both of which the corpus has already been brought into line
with for T1--T9 and T11:
- **No `**` inside an `.important-text` span** — `a11y.css` already sets the
  weight, so it was redundant markup. This REVERSES the v18 rule.
- **A reminder is not a redefinition** — a tutorial that spans a term it did
  not introduce gets one sentence or one clause, and names the source.
Also settled: `let's` STAYS (inclusive, not authorial), while authorial `we`
goes; and `scale_x_discrete()`/`scale_fill_discrete()` labels take the
order-proof named form, with graders matching by name rather than position.

**New in v18**, from the full external-review pass over all 21 tutorials on
8 August 2026. Most entries are corrections to rules that were being applied
too widely or too narrowly, not new requirements.

**Rules corrected or scoped:**
- §5 **Reported statistics are ordinary prose text** --- no backticks, no math
  mode. Math mode is for symbols alone and for formulas.
- §5 **The em-dash ban applies to markdown prose only, not to raw HTML.** The
  completion banner uses `&mdash;` in the visible text and a literal em dash in
  the `aria-label`, on purpose.
- §6 **A forward reference earns its place when it answers a question the
  tutorial has raised.** History assumptions and catalogues still go; substantive
  pointers stay.
- §6 **The objectives lead-in varies**; three forms are legitimate. What matters
  is that the lead-in reads into its bullets.
- §6 **T1 is an exception to the Overview shape**, because its Roadmap does the
  tutorial-specific orienting.
- §6 **Decide the Overview preview by content, not tutorial number** --- T4, T12
  and T16 have framing sections and still need the paragraph.
- §1 **`pass()` must not do work that belongs to the student elsewhere** ---
  replacing "confirms the work just submitted and nothing else", which forbade
  legitimate interpretation. "Elsewhere" includes the question immediately below.
- §4 **The answer-length rule needs an absolute floor**: flag only at 1.25x the
  mean AND at least five words longer.
- §4 **Output-reading exception** --- a question may ask students to read output
  they just produced.
- §10 **The missing-count rule has a narrow T2 extension**: in the tutorial that
  introduces missingness, counts are stated from the Missing Values section on.
- The **example-shape rule with its labelled theoretical sentence is the T7--T9
  convention**, not a corpus requirement.
- **Nine tutorials have no Takeaways infographic and should not**: T1, T2, T10,
  T11 and T15--T21.
- **Named scaffold exceptions**: T16 Practice 15, T19 Practices 3, 7 and 15, and
  T20's two `stargazer()` starters keep their mid-call blanks, because the blank
  isolates the decision the exercise is about.

**Recurring defects this pass found, worth checking first in any new tutorial:**
- **Graders that search the submission instead of checking the result.** Roughly
  twenty were rebuilt. Where an object exists in the invisible setup, text checks
  prove nothing --- bind the assignment to its right-hand side, or compare the
  fitted object, the rendered output, or the built plot. See §1.
- **Overstated inference language.** Relative-importance rankings, post-hoc
  power explanations for null results, "the relationship is real", confidence
  bands read as tests. The flat phrasing is the correct one in a methods
  tutorial.
- **A claim corrected in one file usually lives in three others.** The
  bare-string claim about factors took five passes across three files; relative
  importance appeared in four. **Grep the corpus for the corrected wording
  rather than fixing the instance you were shown.**

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

- **A GRADER MUST CHECK EVERYTHING ITS PROMPT PRESCRIBES. The single most common
  defect found in the T15--T21 audit of 25 August 2026 --- eight of thirteen
  graders failed it.** Prompts list a title, axis labels, a legend, a caption;
  graders checked some and not others, so a student could omit a prescribed
  title, plot the wrong variable, or pass the wrong model object and still be
  told they were right. **The test: list every string and every object the
  prompt names, then find each one in the grader.** Where the item is already
  written into the starter and the student is told to change nothing else, a
  check still earns its place --- it catches deletion --- but the priority is
  anything the student has to type.
  **Two sub-cases worth naming:** a check on a fragment passes a wrong answer
  (T19 accepted `"Wage Growth"` where the prompt prescribed `"Wage Growth (%)"`),
  and a grader that never names the model object accepts a plot of the right
  shape built from the wrong model.
- **A PATTERN WITH DOUBLED BACKSLASHES MATCHES NOTHING AND FAILS EVERY
  SUBMISSION. Near-miss, 25 August 2026.** Model checks written for T21 came out
  as `plot_model\\\\s*\\\\(` where the working graders beside them read
  `plot_model\\s*\\(`. In R the first looks for a literal backslash, so three
  exercises would have rejected every correct answer. **Compare any new pattern
  against one already working in the same file before accepting it.** It
  surfaced only because the verification step disagreed with the build script's
  own success message --- **which is the general lesson: never accept "applied"
  as evidence that the right thing was applied.**
- **TEXT-CHECKING IS SOMETIMES CORRECT, NOT ALWAYS A SHORTCUT.** The rule below
  about inspecting the result rather than the submission holds --- but `T` versus
  `TRUE` is invisible to any result check, since both evaluate identically, so
  the style check can only be a text check. Likewise, when a task IS to type
  prescribed labels in a prescribed order, those labels are text and checking
  them as text is direct rather than lazy. **Classify a grader as text-only to
  decide where to look, not to conclude it is wrong.** Of thirteen so classified
  in T15--T21, two were sound on inspection.

- **`TRUE` and `FALSE` are written in full. `T` and `F` are rejected.** Added
  25 August 2026 from the TA review. `TRUE` and `FALSE` are reserved words and
  cannot be redefined; `T` and `F` are ordinary object names that any code can
  overwrite, and in a statistics course `F <- 3.2` for an F-statistic is a
  plausible thing to type. After that, `se = F` quietly means 3.2, with no error.
  The check goes ABOVE the check that requires the argument, so `T` gets its own
  message rather than falling through to one written for the argument being
  absent:

  ```r
  if (grepl("na\\.rm\\s*=\\s*T(?![A-Za-z])", code_no_comments, perl = TRUE)) {
    fail("Write `TRUE` in full. ...")
  }
  ```

  `perl = TRUE` is required: the lookahead is what stops the pattern matching
  inside `TRUE`. **Two message variants.** Where the argument is needed, the
  message ends "Replace `T` with `TRUE` and submit again." Where it is not ---
  the variable has no missing values --- it ends by saying the argument can be
  dropped instead, so the student is not sent round twice. **Scope the check to
  the function call when several calls in one submission take the argument
  separately** (T6's `range()`, `min()` and `max()`), and to the whole submission
  when several arguments in one call take it together (T7's four `prop.*`).
- **A GRADER MUST NEVER ASSERT SOMETHING THE STUDENT CAN SEE IS FALSE.** T6's
  Practice 6 told a student "Your `range()` call returns NA" while the range sat
  on screen above the message --- the code said `na.rm = T`, which the check read
  as the argument being absent. The message was accurate for the case it was
  written for and false for the case that reached it. **When a message states a
  fact about the result rather than an instruction, check which inputs can reach
  it.**
- **ggplot no longer stores DEFAULT labels on the plot object.** For a plot whose
  labels were never set, `p$labels` is an empty named list --- so
  `is.null(.result$labels$x)` cannot distinguish a student who wrote `x = NULL`
  from one who wrote nothing, and passes both. Eight checks across T4, T5, T6, T7
  and T8 were dead this way, found 25 August 2026. The fix reads the submitted
  code instead, scoped to the `labs()` call:

  ```r
  labs_txt <- sub(".*labs\\s*\\(", "", code_no_comments)
  if (!grepl("x\\s*=\\s*NULL", labs_txt)) { fail(...) }
  ```

  **The general lesson is bigger than this API change: A CHECK THAT TESTS FOR
  ABSENCE FAILS OPEN.** It passes a wrong answer silently, where a check on a
  value fails loudly and visibly if the library moves under it. When reviewing a
  tutorial that has not been through this, audit the absence checks first.
- **A LABEL COMPARISON ECHOES THE STUDENT'S OWN TEXT.** `identical()` on a title,
  axis label or caption fails on a trailing space or a capital letter the student
  cannot see, and quoting only the expected string back at them shows nothing.
  Build the message with the value they supplied beside the one wanted. A local
  helper inside the grader handles the cases where a label is absent or is a
  language object rather than a string:

  ```r
  show_label <- function(x) {
    if (is.null(x)) "nothing" else paste0('"', paste(as.character(x), collapse = " "), '"')
  }
  ```

  **Do NOT define such a helper in the setup chunk.** There is no evidence in the
  corpus that a setup-chunk function resolves inside a `-check` chunk, and 32
  graders is the wrong place to test the assumption.
- **A SCALE-LABEL CHECK SPLITS INTO BRANCHES.** One `identical()` on
  `labels[names(expected)]` reports four different mistakes with one message, and
  the message names none of them. Split it: no scale at all; a stored value with
  no matching pair, NAMED; a key the student supplied that matches nothing, also
  named; correct keys with wrong replacement text, naming the pair; and, where the
  expected text contains one, a missing `\n` line break, which gets its own
  message because every word can be right and the label still wrong. Seven sites
  across T4, T5, T7 and T8.
- **A `labs()` PRESENCE CHECK GOES ABOVE THE LABEL CHECKS.** Without it, deleting
  `labs()` walks the student through the missing labels one submission at a time.

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
- **[script] `pass()` MUST NOT DO WORK THAT BELONGS TO THE STUDENT ELSEWHERE.**
  It must not preview the next item, supply a calculation, comparison or
  inference the student will later be asked to produce, or duplicate the prose
  immediately below the chunk. **The same rule governs question feedback** ---
  `correct =` and per-answer `message =` are subject to it too.
  **A brief substantive interpretation of the result the student has just
  produced IS legitimate**, and is worth having where otherwise mechanical
  exercises would lose their connection to the data --- T1's pass messages note
  what a narrow range of vote shares says about competitive elections, which is
  the point of the exercise rather than a theft from a later one. Revised
  8 August 2026; the earlier wording was "confirms the work just submitted and
  nothing else", which forbade this too.
  **The test is not "does the message say anything beyond correct?" but "does it
  perform work that belongs to the student elsewhere?"** and **"elsewhere"
  includes the question immediately below** --- that is the common case, not an
  edge one. **[script] Mechanically: compare each `pass()` against the next
  `correct =` for shared five-word runs.** That check fired on three of T21's
  six pass messages on 8 August, each of which opened with the sentence the
  following question's correct answer opened with. T3's ideology question pointed at "the next section" in two separate
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
- **THE FIRST EXERCISE THAT USES A PACKAGE CALLS `library()` VISIBLY, AND THE
  PROSE SAYS SO. This is not redundancy and must not be "fixed".** Students
  never see the setup chunk and do not know it exists. Setup attaches packages
  so that a student who jumps to a later exercise is not blocked --- that is
  invisible infrastructure, not instruction. From the student's position the
  visible `library()` call is the only reason the function works, and loading a
  package before using it is the habit being taught. **Do not rewrite the prose
  to say the packages are already attached, and do not remove the call from
  setup to make the prose literally true.** A reviewer reading the source will
  flag the duplication as a contradiction; it is not one. Settled 8 August 2026,
  after it was raised and wrongly acted on.
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

- **T19 PRACTICES 3, 7 AND 15 KEEP THEIR MID-CALL BLANKS. Settled 8 August
  2026.** The rule below exists to stop meaningless slot-filling; it should not
  remove scaffolding where **the blank is exactly the decision the exercise is
  about**. In all three the surrounding call is machinery the student is not
  being tested on:
  - **Practice 3** is the first interaction prediction plot. Its blanks are
    `plot_model`, the `[meansd]` term notation and the legend label --- the three
    interaction-specific pieces, with the rest of the call supplied.
  - **Practice 7** supplies one worked `predict()` call with the category left
    blank, then asks for three more from scratch. The blank is which category to
    predict for; constructing the remaining calls is the work.
  - **Practice 15** blanks the held quota value and the three history values
    inside `expand.grid()`. Recognising the 3 x 3 combinations and choosing those
    values is the lesson; rebuilding `expand.grid()` is not.
  **Do not report these as violations and do not open them to whole-expression
  blanks.** The test to apply elsewhere: does the blank isolate the new decision,
  or is the student filling slots in a call they already know how to write?
- **T16 PRACTICE 15 KEEPS ITS FILL-IN SKELETON. Settled 8 August 2026 on her
  ruling.** The starter is `___ <- lm(___ ~ ___ + ___ + ___, data = ___)` at a
  point where students have already seen the same model family in Run and
  observe 14, so it reads as over-scaffolded against the post-T2 rule. She chose
  to keep it. **Do not report it as a violation, and do not open it up to an
  empty starter.** The general rule below still holds everywhere else.

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

- **THE FINAL HINT STATES THE ANSWER WHEN IT IS A FACT, AND WITHHOLDS IT WHEN IT
  IS THE JUDGMENT THE EXERCISE TEACHES. Settled 25 August 2026** after T12's four
  graded exercises looked inconsistent and turned out not to be. Corpus practice
  for a last hint is to give the answer outright --- T7's cross-tab hint ends
  "TrumpMajority is the outcome, so it fills the x blank; racial_majority is the
  explanatory variable, so it fills the y blank", and T8's do the same. That is
  correct where the remaining step is knowledge: which variable is the outcome,
  which argument carries the legend title. **But T12's two `prop.test()`
  exercises end their last hint on a question --- "with that group listed first,
  which value of `alternative` tests it?" --- and that is also correct**, because
  translating a hypothesis into `"greater"` or `"less"` given the order the
  groups were listed in IS the skill the exercise exists to teach. Handing it
  over empties the exercise. The test to apply: **if the last hint gave its
  content away, would anything be left to learn?** Where the answer is no,
  withhold and end on the question.
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
- **OUTPUT-READING EXCEPTION, added 8 August 2026.** A question may ask the
  student directly to read or identify something in output they have just
  produced, where interpreting that output IS the skill being taught --- T2's
  Practice 13 asks what type R reports for **date** in `str()` output.
  **Do not rewrite such an item into a contrived misconception scenario to make
  it match the usual shape.** §2 already permits a Practice question "about what
  was just seen", and §4 must not contradict it. The item still has to require
  the student to inspect and understand the output: a question answerable from a
  sentence in the prose above is recall, and remains a defect.
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
- **[script] `try_again` DOES NOT OPEN WITH "Hint:". Settled 25 August 2026**, after
  she noticed T12's read like a stand-in. It is not the Hint button --- questions
  have none --- so the label announces a feature that does not exist. T1 and
  T4--T9 never used it; T3, T10, T11 and T14 used it on every question and T2,
  T12 and T13 on some, so the corpus was split 63 of 143 with no rule written
  down. All 63 were stripped. Start with the substance: "The column totals run
  along the bottom of the table."
- **BOTH the per-answer `message` AND `try_again` display on a wrong answer.**
  Verified in the rendered tutorial, 25 August 2026, because the source cannot
  tell you. That is why `try_again` may be generic while the messages carry the
  diagnosis: the student sees the specific explanation with the generic nudge
  beneath it. **A `try_again` that merely restates one answer's message is
  therefore redundant, not helpful.**
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
  anything above 1.25x --- AND by at least five words in absolute terms.**
  **The absolute floor was added 8 August 2026**, on her ruling about T4's
  `question-tool-choice`: the correct answer ran 10 words against a mean of 7,
  which is 1.43x, and "10 words v 9 or 8 is no big deal". The cue this rule
  guards against is a visibly longer answer; a word or two is not visible, and
  flagging it trains people to ignore the check. Comparing to the longest hides the tilt: a question
  can sit comfortably under its longest distractor while running twice the
  typical one, and the typical one is what a student's eye calibrates against.
  Measured across T15--T19 at 1.6x-of-longest, four questions flagged; the same
  set at 1.25x-of-mean flagged **44 of 79**, and every one of them carried an
  explanatory clause after a `---` that the message already stated.
  Where the correct answer is already terse, lengthen the shortest distractor
  instead --- a four-word throwaway option is its own tell.
  Multi-select items are less exposed, since the cue does not tell you how many
  to pick.
  **A DISTRACTOR THAT CARRIES A MISCONCEPTION IS NOT AN "INVENTED FOURTH OPTION."
  Ruled 25 August 2026, reversing a deletion made earlier the same day.** Four
  questions across T12, T13 and T14 ask which value of `alternative` a hypothesis
  needs. `"greater"`, `"less"` and `"two.sided"` are the whole answer space, so a
  fourth option cannot be another value --- and I read that as the invented-option
  defect and deleted two of them, folding their content into other messages. That
  was wrong. **Each fourth option was the misconception the question exists to
  catch**: that you may reorder the groups, or that variable order changes the
  sign of a correlation. T14's correct-answer message says so outright --- "the
  detail about which variable was entered first is a distractor built into the
  question." **A distractor a student can select tests a misconception better
  than a sentence inside another option's feedback.** Both were restored.
  The real defect was narrower: **two options must not OPEN on the same value.**
  With `random_answer_order = TRUE` a student saw two options beginning
  `alternative = "greater"`, and the opening is what the eye lands on. Fixed by
  putting the reason first --- "Because entering anti-establishment support first
  reverses the predicted direction, `alternative = "greater"`."
  **SKIP MULTI-SELECT ENTIRELY WHEN CHECKING ANSWER LENGTH --- and make the
  script skip them, not just the reader. Learned 25 August 2026:** a first pass
  over T15--T21 reported eight flags, six of them in T20, and all eight were
  "select all that apply" items. The script had taken the FIRST correct answer
  and compared it against the mean of every other option, which mixes the
  remaining correct answers in with the distractors. The rule below already says
  multi-select is less exposed; the check has to implement that. **Detect it by
  counting `correct = TRUE` in the block: more than one means skip.** Of 114
  questions in T15--T21, 30 are multi-select and the other 84 flag nothing.
  **MEASURE IN WORDS AGAINST THE MEAN. Re-learned 25 August 2026:** checking
  characters against the LONGEST distractor cleared three questions at 1.12,
  1.15 and 1.13 that the real rule flagged at 1.59, 1.20 and 1.43. The document
  already said mean-in-words; using the other metric is how you get a false
  clear on your own new writing.
- **[script] A box that concedes the reader already knows is a box that should
  not be there.** Grep the first line of every callout for "As in earlier
  tutorials", "As you know", "You will recall", "By now". T20 carried a `.tip`
  explaining "Run Code" versus "Submit Answer" --- in the twenty-first tutorial,
  opening with "As in earlier tutorials". Nothing here flagged it: every box
  check asks whether a box is well-formed, correctly typed, unstacked and not
  duplicating adjacent prose, and none asks whether the reader needed telling.
  It passed all of them.
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
- **THE EM-DASH BAN APPLIES TO MARKDOWN PROSE ONLY, NOT TO RAW HTML. Recorded
  8 August 2026, after the completion banner was reported as a violation twice
  and was correct both times.** In markdown you write `---` and Pandoc renders an
  em dash; a literal em-dash character there is the defect the rule is about.
  **Inside raw HTML none of that applies, because Pandoc does not process
  markdown there --- `---` would reach the reader as three hyphens.** So the
  banner uses two different forms on purpose, and every one of the seven banners
  in the corpus that contains an em dash does it the same way:
  - **In the visible `<p>` text: the HTML entity** `&mdash;`, which the browser
    decodes.
  - **In the `aria-label` attribute: the literal em-dash character.** The entity
    would also work --- an HTML parser decodes attribute values too --- but the
    literal is what the corpus uses and it keeps the source readable.
  **Do not "fix" either one.** A checker comparing the label to the visible text
  must normalise `&mdash;` and the literal character to the same thing before
  comparing, which the battery does.
- **REPORTED STATISTICS ARE ORDINARY PROSE TEXT --- NO BACKTICKS, NO MATH MODE.
  Recorded 8 August 2026, after this was raised as a violation three times and
  was not one.** A reported value is written exactly as it would be spoken, with
  no markup around it in the source: r = 0.633, p < .001, t = 7.431, df = 149,
  n = 3,110. Counts across the set: T14 writes 14 of these bare, T13 writes all
  of its bare, and T12's single math-mode instance was an error introduced on
  8 August and since corrected.
  - **Backticks are wrong** --- these are not code the student types.
    `t.test()` is code and takes backticks; t = 0.952 is a result and does not.
  - **Math mode is wrong for a reported number, and RIGHT for a symbol alone**
    --- $r$, $\\rho$, $\\mu_d$, $H_0$, $\\pi$ --- **and for a formula**, where the
    symbolic content lives. One sentence may correctly contain both: "$r$ is the
    sample correlation; here r = 0.633."
  - The exception recorded further down still holds: plain arithmetic contrasted
    with a symbolic expression in the same sentence stays in math mode, because
    mixing the two sizes in one clause looks broken.
  **Never convert one tutorial toward a different convention. If this is ever
  changed, change T12, T13 and T14 together and rewrite this entry.**
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
- `[term]{.important-text}` for a term at the point where the sentence
  defines it. Position in the sentence is
  irrelevant and so is count — if one sentence defines four terms it gets four
  highlights.
- **NO `**` INSIDE THE SPAN. Reversed 9 August 2026; this REPLACES the earlier
  "bold goes *inside* the span" rule.** `a11y.css` already sets the weight on
  `.important-text`, so the asterisks change nothing in the rendering and only
  make the source harder to read and to sweep. Write `[term]{.important-text}`,
  not `[**term**]{.important-text}`. Applied 9 Aug to T1 (22), T2 (16), T3 (24),
  T4 (26), T5 (20), T6 (36), T7 (12), T8 (12), T9 (14) and T11 (26); the other
  eleven files still carry it. Inside a callout class, dropping the `**` also
  drops the term's colour, because that rule keys off `strong` -- she reviewed a
  render and accepted it.
- **A REMINDER IS NOT A REDEFINITION. New 9 August 2026.** Where a tutorial
  spans a term it did not introduce, the prose that follows runs to ONE sentence
  or one clause, and it NAMES where the term came from. Full treatment --
  definition, examples, practice -- belongs only where the term is introduced.
  The test is whether this tutorial EXTENDS the term: T5 extends shape with
  *direction across the scale*, T6 extends dispersion with range, variance and
  standard deviation, so both earn their reminders. A term merely mentioned in
  passing gets a cross-reference and no span. Found 9 Aug in T5, whose
  Dispersion section restated T4's whole argument in five sentences with no
  attribution, and whose Shape paragraph opened "The same four labels apply
  here" with no antecedent anywhere in T5.
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
  the [dollar-sign operator]{.important-text} `$`, the
  [equality operator]{.important-text} `==`. No span in the corpus contains
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
  `[term]{.important-text}` in ANY tutorial that defines or develops it, and
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

- **SECTION LENGTH IS MEASURED IN LINES PER LEVEL-2 HEADING, NOT IN HEADING
  COUNT. Settled 25 August 2026** after she noticed T17's pages ran very long.
  learnr builds progressive reveal from headings, so a section is one continuous
  scroll with no break and no landmark. The corpus median is **112 lines per
  `##`**; the files that read best (T8, T12, T13, T18) run 76--82. Heading count
  scales with length and is not the measure --- T1 has 19 sections and reads
  well at 92.
  **Three files were restructured that day**, all of them prediction or model
  tutorials whose worked examples ran unbroken: T17 from 197 to 105, T21 from
  191 to 100, T20 from 174 to 115. **No prose was rewritten** --- subsection
  headings were promoted to sections and renamed.
  **Where to cut:** each example's own subsections already mark the seams. T17
  and T21 divide into tables-and-predicted-values, then the interval predictor,
  then the categorical predictor, then the two together. T20's two examples had
  eight identical subsections that group into estimating, predicting and
  classifying. **A split that follows the tutorial's existing progression needs
  no new writing; one imposed on it needs a lot.**
  **Name the new sections as substantive questions**, because that is what the
  corpus does once worked examples begin --- "How Much Do Census Regions
  Differ?", not "Plotting a Categorical Predictor". The parallel across two
  examples is what lets a student see the second as the same procedure on
  different data.
  **Short sections are normal and not a defect:** 23 of 230 sections corpus-wide
  run under 20 lines, including six-line ones in T5, T8 and T18. The test is
  whether it is a thing you would want to navigate to, not how long it is.
  **T11 (155) and T10 (152) are now the longest-running.** Both are narrative
  simulation tutorials, so that may be genre rather than defect --- the same
  argument that settled their pronoun counts.

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
  T7--T14 all have such a section, so a preview duplicates it; T2--T6 do not, so
  the middle paragraph earns its place.
  **T1 IS AN EXCEPTION and must not be made to match T2--T6.** Added 8 August
  2026. T1 opens the entire series, and its Overview uses the space a
  tutorial-specific preview would occupy to explain the purpose and progression
  of the series as a whole; "Before You Begin" then covers the tutorial
  machinery, and the **Roadmap** does the tutorial-specific orienting by saying
  what Part 1 covers and why its loosely connected R mechanics come in that
  order. Adding a "this tutorial covers..." paragraph to T1's Overview would
  duplicate the Roadmap, not improve orientation. This is the same uniqueness
  §6 already recognises when it says T1 needs a Roadmap where other tutorials
  need a framing section --- the Overview rule has to acknowledge it too. **Read the section that follows before
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
- **THE OBJECTIVES LEAD-IN VARIES, AND THAT IS FINE --- WHAT MATTERS IS THAT THE
  LEAD-IN AND THE BULLETS MATCH GRAMMATICALLY. Recorded 8 August 2026.** Her
  ruling: elegant variation in the lead-in is appropriate; the real key is that
  the two fit together sensibly. Three forms are in use, each covering exactly
  the tutorials that belong together, and **all three are legitimate --- do not
  normalise them to one**:
  - **"In this tutorial you will learn:"** with `* How to ...` bullets.
    T1--T9 and T15--T21.
  - **"In this tutorial you will learn to:"** with bare-verb bullets ---
    `* Explain ...`, `* Describe ...`, `* Distinguish ...`, `* State ...`.
    T10 and T11, the two inference-logic tutorials, where "How to explain the
    difference between" would be clumsy and the verb form reads better for
    conceptual objectives.
  - **"In this tutorial, you will learn how to <do the thing>. Specifically, we
    will cover:"** with `* How to ...` bullets. T12--T14, the hypothesis-test
    set, where the topic sentence names the test the tutorial is about before
    the list breaks it down.
  **Read the lead-in straight into each bullet.** "you will learn to: Explain",
  "we will cover: How to test", "you will learn: How to" all parse; a mismatch
  such as "you will learn to: How to explain" does not, and that is the defect
  to look for.
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
- **A FORWARD REFERENCE EARNS ITS PLACE WHEN IT ANSWERS A QUESTION THE TUTORIAL
  HAS RAISED. Added 8 August 2026, after the rule below was applied too widely.**
  Three different things were being removed as one, and only two of them should
  be:
  - **History assumptions** --- "you have used `group_by()` since Tutorial 5",
    "you built single box plots in Tutorial 6", "in the previous tutorial you
    described...". These assert what the reader has done and break for anyone
    arriving directly. **Remove them.**
  - **Catalogues** --- "This tutorial covers the first case; Tutorials 8 and 9
    cover the other two." A table of contents, which `qpa_launch()` already
    provides and which goes stale on renumbering. **Remove them.**
  - **Substantive pointers** --- "that requires a formal hypothesis test, which
    Tutorial 12 takes up for two categorical variables." **KEEP THESE.** T7--T9
    spend their length telling students what a descriptive pattern cannot
    establish; ending there without saying where the answer lives raises a
    question and withholds its address. **The rule below already states the test
    --- actionability** --- and a reader who has just been told a cross-tab
    cannot settle chance can act on that pointer. Within a SET (T4--T6, T7--T9,
    T12--T14, T15--T19, T20--T21) these connections are what make the set read as
    one, and the infographic-growth exemption below rests on the same reasoning.
  **The test is whether the pointer answers something the reader is now asking,
  not whether it points forward.**
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
  **THE LAST TUTORIAL IN THE SEQUENCE IS THE EXCEPTION: it ends on its own
  material, with no forward paragraph at all.** Settled 8 August 2026 on T21.
  A pointer with no referent cannot be written without either naming a tutorial
  that does not exist or summarising what was finished, and §6 forbids the
  second. What T21 carried instead was a catalogue of the whole sequence, which
  is what `qpa_launch()` is for; it was removed and the Takeaways now close on
  the tutorial's own last point. Do not re-flag T21 as missing a forward
  pointer. Open for revisiting if a tutorial is ever added after it, or if the
  end of the sequence is judged to want a closing note of its own.
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
  **THIS IS THE T7--T9 CONVENTION AND IS NOT REQUIRED ELSEWHERE. Settled
  8 August 2026 on her instruction: "I like the example openings as they are."**
  The labelled cue appears in T7 (3 times), T8 (5), T9 (4) and once in T14, and
  nowhere else in the corpus. Other tutorials open their examples in whatever
  way the material suits --- T15's Example 2, for instance, gives the
  theoretical argument before the hypothesis rather than after it, and that is
  fine. **Do not report a missing "The theoretical explanation is that…" as a
  defect outside T7--T9, and do not restructure example openings to create one.**
- **An umbrella term is spanned wherever a tutorial defines or develops it**
  (revised 3 August 2026 --- see §5). The Overview stays plain bold and the
  Takeaways re-mark whatever the body spanned. What remains a defect under the
  revised rule, and is worth checking in every file:
  a term spanned in the Takeaways but never in the body (marked in a recap of
  something the tutorial never taught); a mismatch between body and
  Takeaways that makes them DIFFERENT TERMS rather than the same term in
  different grammatical number --- `percentile` against `percentiles` is NOT a
  defect, and forcing agreement makes the prose worse (T1 defines one
  [function]{.important-text} in the body and opens its recap
  "[Functions]{.important-text} are what make R powerful", which is right
  both times). Narrowed 4 August 2026, after the check flagged three such pairs
  in T1 and none anywhere else in T1--T6; a term taught and
  spanned but never re-marked in the Takeaways; and a term spanned twice within
  one tutorial.
- **MOTIVATION, THEN GRAPHIC, THEN DETAIL. Reversed 9 August 2026; this
  REPLACES the 8 August rule that the infographic opens the Takeaways.** A short
  motivating paragraph comes FIRST, the infographic follows, and the detail
  comes after. **Her account of how the 8 August rule went wrong: the
  infographics had been the very LAST thing in the Takeaways, standardizing them
  was read too literally, and moving them to the very FIRST thing was a bad
  idea.** Opening on the table also forces the sentence beside it to point
  BACKWARD at something the reader has already scrolled past, and it left T3
  with three stub paragraphs of setup before anything substantive. Applied
  9 Aug to T3, T4, T5 and T6. **T7, T8 and T9 were VERIFIED COMPLIANT on 25 August
  2026 --- all three already open with a motivating paragraph.** T12, T13 and T14
  were listed as open on 9 Aug and have NOT been re-checked; verify before acting.
  T1 and T2 have no infographic.
- **THE SENTENCE BESIDE AN INFOGRAPHIC MUST SAY SOMETHING THE TABLE CANNOT.**
  Her words: "I do not want an administrative table sentence!!" **The test: if
  the sentence could be written by looking at the table, cut it** --- every
  table already carries a `<caption>`. Three legitimate forms, one per position
  in a sequence: a table that STARTS a sequence says what it is FOR ("Every tool
  in the tutorials that follow is chosen by which row of the table below a
  variable falls in"); a table that EXTENDS one says what CHANGED and what is
  next; the LAST says what changed and that the set is complete. Killed on
  9 Aug: "The table summarizes the three levels … and provides examples",
  "The table brings together the tools for describing nominal, ordinal, and
  interval variables", and two instances of "everything that follows explains
  why the entries differ and how to produce them in R".
- **EVERY TAKEAWAYS PARAGRAPH NAMES ITS SUBJECT AT THE FRONT.** The subject is
  usually the `.important-text` term; where there is no term to lead with, a
  short **bolded topic phrase** does the job --- a PHRASE, not a sentence, since
  a bolded sentence reads as emphasis and lands the eye on whatever clause it
  ends with. T2 is the model. **The failure mode this prevents:** keying the
  bullets to the tutorial's conceptual dimensions and then letting everything
  that fits no dimension pool into an unheaded paragraph at the end.
- **THE TAKEAWAYS LEADS USE THE SAME LANGUAGE AS THE TABLE OF CONTENTS.** Not
  every lead has to be a section heading --- her words: "I don't want literally
  every heading in the Takeaways, I want the language consistent in the
  takeaways with what is in the TOC, so we teach visualizing, not building
  anything." The tutorials teach **Visualizing a nominal / ordinal / interval
  variable**, so the Takeaways say that too. **Do not invent a competing verb.**
  Killed 9 Aug: **Building the plots**, **Building the bar plot** (twice), and
  **Building the frequency and proportion table**, which became **Computing**
  to match T6's **Computing the summaries**. Leads that name a task with no
  section of its own --- **Ordering the categories**, **Turning counts into
  proportions**, **Choosing a format** --- are fine as they are.
  **No rule is so fixed that keeping it makes no sense.**
- **Bullets when the content is genuinely enumerable --- a list of functions, a
  set of plot types --- and prose otherwise.** Not written in stone; a tutorial
  whose content suits something else may use it, but the sections must stay
  recognizable as Takeaways across all 21.
- **`library()` INSTRUCTIONS BELONG IN T1 ONLY.** Name the package that holds a
  function anywhere it helps --- `[dplyr]{.package-name}`, `[ggplot2]{.package-name}`,
  base R --- but no loading instructions outside T1, which is where they are
  taught. Stripped 9 Aug from T4, T5 and T6. **T9's paragraph is GONE --- verified
  25 August 2026. T7 and T8 mention packages only in `.package-name` spans, which
  this rule permits.**
- **The Takeaways open with an HTML infographic table that accumulates across
  the sequence.** One data column in the first tutorial, headed generically;
  at the second, that column is RENAMED to its case and a second added. Cells
  are short noun phrases. Function names need `<code>` tags --- markdown
  backticks do not render inside the raw `<table>`.
  **NINE TUTORIALS HAVE NO INFOGRAPHIC AND SHOULD NOT: T1, T2, T10, T11, AND
  T15--T21.** T10, T11 and the regression sequence added 8 August 2026 on her
  ruling ("I don't think we need an infographic"). The accumulating table works
  where a framework builds column by column across a set --- T4--T6 add nominal,
  ordinal and interval; T7--T9 add the three variable pairings. **T10 and T11 do
  not work that way**: T10 is one causal chain from sampling variation to the
  CLT, and T11 is two views of the same idea, hypothesis tests and confidence
  intervals. **T15--T21 do not either** --- and none of the seven has one, so
  adding one to a single tutorial would leave six at odds with it. A table built
  for these would have one row and columns that mean nothing to a student, which
  is the same reason T1 and T2 have none. **Do not report the absence as a
  finding in any of the nine.**
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

- **DIAGRAM CHUNKS CARRY DIFFERENT `out.width` VALUES ON PURPOSE --- do not
  normalise them.** Settled 8 August 2026, after two wrong attempts worth
  recording. `NODE_STYLE` in `tools/render-diagrams.R` fixes box size and font
  size in graphviz units, so **rendering each diagram at its OWN size times a
  common scale factor** makes a box the same number of pixels in every diagram,
  whatever the layout. Forcing a common output width, or a common output height,
  rescales each diagram by a different factor and the boxes come out visibly
  different sizes on the page --- **fixing the height does NOT fix it**, because
  diagrams fill their height differently. With a common box scale, set each
  chunk's `out.width` in proportion to the width the script prints, using a common
  anchor: at anchor 70, 634px → 46%, 754px → 55%, 966px → 70%. **To resize the
  diagrams, move the anchor and re-derive all three --- changing one alone breaks
  the match.** `scale` in the render script sets pixel resolution, not display
  size; lowering it only makes the images blurrier. **A reviewer will read the three different
  percentages as an inconsistency; it is the opposite.** Re-derive them whenever
  a diagram is re-rendered.
- `fig.alt` on every figure. For figures that feed a question, describe visual
  features only — nothing that reveals the answer.
- **T15--T19 HAVE NO `fig.alt` ANYWHERE --- outstanding, logged 8 August 2026.**
  Not on exercise chunks and not on the non-exercise figures either: T16's two
  diagrams, T17's reference prediction plot and T18's conditional diagram are all
  unlabelled, alongside the five plot-producing exercises in T17 and T19.
  **The v17.10 pass reported §7 clean on all five.** This was not a checker gap
  --- §7's first rule is "`fig.alt` on every figure" and the check was simply not
  run. T20 and T21 were brought into compliance on 8 August; T15--T19 still need
  it, and writing the text requires the rendered figures.
  **CLOSED, VERIFIED 25 August 2026: every figure that RENDERS now carries
  `fig.alt`.** Twelve across T17 (3), T19 (3), T20 (1) and T21 (5); T15, T16 and
  T18 produce no figures at all. The count depends on what you call a figure ---
  a first pass reported 44 "missing" because it counted `-hint-` and `-check`
  chunks, which contain plotting code as TEXT and render nothing. Count only
  chunks that execute and display: not hints, not graders, not `eval=FALSE`
  templates. **Nine of the twelve are `exercise=TRUE` chunks, so the untested
  mechanism in the next entry is what they depend on.**
- **OPEN CORPUS-WIDE GAP, logged 8 August 2026: figures produced by STUDENT code
  carry no alt text at all.** `fig.alt` is a knitr chunk option and the checks
  written for it only ever looked at non-exercise chunks, so an exercise whose
  output is a plot passes every accessibility check while shipping an unlabelled
  image. Ten plot-producing exercises across T17, T19 and T21 are in this state,
  and the true count is higher because a from-scratch exercise has an empty
  starter and is invisible to a scan. **This is a real accessibility problem and
  must be revisited.** Two candidate mechanisms, neither yet tested: `fig.alt`
  on the `exercise=TRUE` chunk, if learnr passes chunk options through to
  runtime output --- invisible to students and free if it works; or
  `labs(alt = "...")` inside the plot call, which certainly works for a rendered
  figure but sits in student-visible prescribed code and so becomes taught
  content needing prompts, hints, graders and code files to match. Establish
  which mechanism works before scoping the fix, and do all three tutorials
  together.
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

- **OPEN CORPUS-WIDE GAP, logged 8 August 2026: grouped prediction plots are
  separated by hue alone.** `plot_model()` with two variables in `terms =` draws
  one line per group and distinguishes them by colour only. T17, T19 and T21 all
  do this --- `linetype` and `shape` appear nowhere in any of them --- so it is
  not a defect in any one tutorial but a gap the §7 sweep did not catch, and
  T17 and T19 passed the full v17.10 pass carrying it. T19 also teaches the
  colour-only form explicitly ("one line appears per category, colored and
  labeled by category name"). **This is a real accessibility problem and should
  be revisited**, but the fix is not cosmetic: it means adding a second
  aesthetic to prescribed calls across several exercises in three tutorials,
  with the prompts, hints and graders that go with them. Deliberately deferred;
  do not fix it in one tutorial alone, which would leave the corpus
  inconsistent.
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

- **A HYPOTHESIS IS A CLAIM ABOUT A GENERAL RELATIONSHIP; THE PARTICULAR DATA
  ARE THE EVIDENCE. Settled 24 August 2026.** The counties and world data cover
  nearly every case, and the old framing justified inference by treating them as
  a sample from a finite population --- which is not true of the data and invites
  the obvious student question: why test for significance when we have every
  county? The replacement shape, applied across T7--T9: state the hypothesis
  generally, then bridge to the setting in one sentence --- "The hypothesis
  describes a broader relationship, and the 2016 election provides one setting in
  which to examine it." **The bridge names the operationalization too** where the
  concept and the measure differ: because the Democratic Party held the
  presidency in 2016, Democratic vote share measures incumbent-party support.
  That distinction is a pedagogical gain in its own right.
- **Interval-outcome hypotheses read "will tend to have."** A tendency admits
  exceptions, which is what makes inference the right tool for assessing it.
  Categorical-outcome hypotheses already read "will be more likely to" and are
  untouched. **The "In a comparison of [cases], those that are [X]..." template
  STAYS** --- she teaches it, and its preamble names the unit of analysis, which
  free prose silently drops. Thirteen hypotheses across T7--T9 use it.
- **"larger than chance" and "statistical significance" are OUT of the
  descriptive tutorials.** One replacement, used seven times across T7--T9:
  *it does not tell you whether a pattern this large would be surprising if there
  were no systematic relationship between the variables.* "Chance" invites
  "chance from what?", and the answer is the null model that T10--T14 build.
  In T10 and T11 the word survives only where the process is specified and
  concrete: Sarah guessing at 50% per trial, and the p-value misconception
  passage, where the whole point is the difference between two conditional
  probabilities.
- **DO NOT CALL COMPLETE DATA A SAMPLE.** The corpus had this in five places, all
  fixed 24--25 August: T6's n-1 explanation ("because you are estimating the
  population standard deviation from a sample", while computing the SD of ten
  presidents), its range paragraph and its Takeaways; T8's "small-sample noise"
  for a group of 96 counties; T10's claim that a 40-country data set is a sample
  drawn from all countries; and T4's Takeaways definition of descriptive
  statistics as summaries "about the sample". **Genuine samples keep the word:**
  T8's invented commute-time cities, the sample mean and sample size in T9's
  correlation formula, T11's Gallup survey. The test is whether anything was
  actually sampled.

- **DO NOT OVERSTATE FREQUENCY, UNIVERSALITY, OR WHAT IS COMPUTABLE. New
  9 August 2026, after eight instances surfaced in T1--T5 alone.** The claim is
  never needed and is usually false. Three forms:
  *Frequency* --- "You will reach for `nrow()` constantly", "you will use it
  constantly", "one of the most common things". Say what the function is good
  for instead.
  *Universality* --- "Every analysis begins the same way", "Exploring a new data
  set always begins with the same set of functions", "You will always start with
  the `ggplot()` function". Scope it to the situation the paragraph is actually
  about; often the paragraph's own last sentence already does.
  *Computability* --- "there is no way to compute a mean otherwise", "R cannot
  compute a mean when some values are unknown", "declining to report a mean it
  cannot compute from incomplete data". A mean of the observed cases is
  perfectly computable; **`mean()` simply does not discard missing values unless
  told to.** Describe the function's behaviour, not the limits of arithmetic.
  **A claim about frequency the tutorial cannot support is a claim to delete,
  not to hedge.**
- **A qualifier the corpus has already sharpened must be carried over when the
  point is restated.** "The **substantive** proportions sum to less than 1" ---
  without *substantive* the sentence says the `prop` column fails to sum to 1,
  which is false when the `NA` group is included. The precise wording existed in
  T4 and in T5's own Takeaways; a freshly drafted restatement in T5 dropped it.
  **Grep for how the corpus already words a recurring point before writing it
  again.**

- **HYPOTHESES ARE ABOUT THE POPULATION. Do not write "the population or the
  underlying process." Settled 25 August 2026.** Under the superpopulation
  reading the population parameter IS the process parameter --- they are not two
  targets needing a translation rule, and pairing them makes them sound like
  alternatives. An earlier attempt added a gloss telling students to "read
  'the population' as the inferential target"; it was cut, along with a
  shorthand paragraph built on the same hedge. **The defect to fix is
  "the population, NOT THE SAMPLE"** --- that one calls complete data a sample
  and is false. The replacement is "not about the cases you observed."
- **A CHI-SQUARE NULL NAMES NO PARAMETER, SO STATE IT AT THE LEVEL OF THE
  HYPOTHESIS.** Her ruling, 25 August 2026, on reading "**racial_majority** and
  **TrumpMajority** are not related in the population" and finding that it
  sounded like a question about an already-existing population. T12's six
  omnibus statements now read "Racial composition and support for Republican
  presidential candidates are not systematically related." The tests that DO
  name a parameter keep "in the population", because $\pi$ has to be anchored
  somewhere. The result is a visible two-level structure --- concept, then
  operationalization --- which teaches the reframing instead of explaining it.
  **This requires the concept-to-variable mapping to be explicit once**, which
  is why T12's first bridge says "with Donald Trump as the Republican candidate."
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
- **THE PRONOUN SWEEP IS NARROW. Settled 25 August 2026**, from three options
  offered. Only AUTHORIAL `we`/`us`/`our` goes: promises about the document
  ("we will define it precisely shortly", "the bowl we will use in the next
  section") and possessives for things belonging to the reader ("our sample
  mean" becomes "your sample mean"). **What STAYS** is `we` meaning the
  discipline's practice ("why we test the null and not the alternative", "in
  practice we cannot compute it exactly") and `we` meaning the walkthrough the
  reader and the tutorial are doing together ("we simulate what would happen if
  the null were true"). Rewriting those into second person produces "you
  simulate" for something the tutorial does for the student. `let's` stays.
  **Counts are a genre signal, not a defect count:** T7 has 0, T9 2, T8 3, T6 6,
  T4 12 --- but T10 and T11 had 48 and 41, because they are narrative
  simulations. Fifteen authorial uses were removed from the two of them; the rest
  are correct. **COMPLETE ACROSS THE CORPUS as of 25 August 2026:** T10 and T11
  (15 edits), T12, T13 (15), and T16, T18, T19, T20, T21 (15 between them). T14,
  T15 and T17 were checked and needed nothing --- every candidate in them was
  `tells us` or `lets us`, which stays. Of 256 uses in T15--T21, 45 were
  `tells us` alone. **Do not re-run this sweep.**
- **Never assume WHEN the reader is reading, or what they have just been doing.**
  These tutorials are used in other courses, and by students returning to them
  semesters later while writing honors theses. So nothing may refer to the
  course calendar or to a reader's recent history: not "a week has passed
  since", not "as you saw last class", not "by now in the semester", not "we
  covered this on Tuesday". Where a reader genuinely needs reminding of
  something, say what it is and why it is worth recalling without dating it ---
  "the shape is worth recalling before you write it", not "you have not written
  one of these in a while". A cross-reference to another tutorial is fine: that
  points at a place, not at a time.
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
  bullet above it; and **the YAML front matter is excluded**. **T11 was VERIFIED
  CLEAN on 25 August 2026: zero wrapped bullet continuations, prose median 296
  characters against a corpus range of 263--384, and the short lines inside its
  divs are box titles, which belong on their own line.**
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
- **Where nothing needs filtering, do not raise filtering at all** --- in prose,
  prompts or hints. **THIS DOES NOT SILENCE A GRADER RESPONDING TO FILTERING THE
  STUDENT ACTUALLY USED. Clarified 8 August 2026.** T8's graders accept an
  otherwise correct answer carrying a gratuitous `filter()` or `na.rm = TRUE`
  and then say so: "which does no harm --- but neither of these variables has a
  missing value, so there was nothing to remove. Check the counts before
  reaching for either." That is the pass-with-a-nudge design settled 1 August,
  and it is the opposite of planting the reflex --- it corrects one the student
  has just demonstrated. **Do not delete that feedback as a violation of this
  rule. Do not plant the reflex; do correct it when it appears.**** A sentence
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
  **Extended 8 August 2026, and still narrow: in the tutorial that INTRODUCES
  missingness, counts are stated from the Missing Values section onward, not
  before it.** T2 uses **likes_count**, **shares_count**, **month** and **date**
  well before that section. Announcing counts for them earlier would state
  something the student has no way to read --- they have not yet met `NA` or
  `is.na()` --- and would pre-empt the sequence the tutorial is built on. The
  rule exists so students know how many cases a calculation uses; that sentence
  is meaningless until they know what a missing value is. **This licence covers
  exactly one tutorial and exactly the material before its Missing Values
  section. It is not a general permission to omit counts early in a file.**
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

- **RAISE AN ISSUE BEFORE REVISING, NOT IN THE MESSAGE THAT CARRIES THE FILE.
  Her ruling, 24 August 2026**, sharpening the earlier rule about never handing
  back a file known to be incomplete. Flagging an open question alongside the
  delivery wastes a round: she has to read the file and the caveat together and
  decide whether the file is usable. Anything known to be unresolved stops the
  edit until she has ruled on it. **This applies to questions discovered
  mid-build**, which is when it is most tempting to carry on and mention it
  afterwards.

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
- **CHECKING STARTER-SUPPLIED CODE: PERMITTED, NOT REQUIRED --- and the FAIL
  MESSAGE must match the starter. Clarified 8 August 2026, replacing the earlier
  absolute "do NOT check values the starter supplies".** A grader checks the
  submission it receives, not the difference between the submission and the
  starter. Verifying something the starter provided is therefore legitimate: a
  student can delete or alter it, and a prompt that says "change nothing else"
  states a requirement like any other. **Neither a grader that checks it nor one
  that does not is a defect, and both patterns exist in the corpus --- do not
  sweep a tutorial from one to the other, and do not flag one file for matching
  the opposite pattern to its neighbour.** What IS a defect:
  - **A fail message that blames the student for code they never had to write.**
    Where the starter supplies it, the message says *keep* it --- "Keep
    `type = \"response\"`" --- not *use* it. The verb tells the student whether
    they were meant to type it; getting it wrong sends them hunting for a
    mistake they did not make.
  - **A grader that checks ONLY starter-supplied code** and never verifies what
    the student actually had to supply. That grader passes an untouched starter.
  - **A check on a value the student was invited to choose.** Prescribed values
    are requirements; open ones are not. T6's Practice 12 and Practice 18 carry
    an identical `color = "white"` test; it is wrong only where the starter
    already supplies it and the prompt does not prescribe it. Anchor on the
    surrounding block, never on the test alone.
  - History: sixteen such checks were removed on 4 August from T4 Practice 17,
    T5 Practice 6, T6 Practice 12 and T6 Practice 17, and declined earlier on
    T5 Practice 13, T7 Practice 15, T8 Practice 12. Those removals stand; they
    are not to be reinstated, and their absence is not a defect either.
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
