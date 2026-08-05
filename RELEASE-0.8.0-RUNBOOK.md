# moderndive 0.8.0 — post-acceptance runbook

Everything that has to happen once CRAN publishes 0.8.0, in order,
across the three repos it touches. Written 2026-08-03 while the release
was still pending, so the sequence can be executed in one pass rather
than reconstructed.

Each step says whether it is **manual** or **automatic**. Do not do the
automatic ones by hand.

------------------------------------------------------------------------

## EXECUTED 2026-08-04 — what actually happened

CRAN published **0.8.0 on 2026-08-04** (`cran-watch-moderndive` caught
it at the 20:00 run: `pub=0.7.0;queue=archive -> pub=0.8.0;queue=none`,
day 19). Steps 1–8 and 10 are **done**; step 9 remains blocked. Three
corrections to what is written below, discovered while executing it:

- **Step 1 tags the wrong commit.** The runbook says `9ea51de` — that is
  the *first*, rejected submission. The accepted tarball is
  **`f26c48a`** (the post-Uwe URL-fix resubmit). `v0.8.0` was tagged
  there and the GitHub release cut from it. Steps 3 and 4 landed in
  `66808a9`.
- **Step 5’s roxygen2 warning is moot.**
  `Config/roxygen2/version: 8.0.0` in `DESCRIPTION` is the deliberate
  regeneration that shipped to CRAN, not churn to revert.
- **Step 6’s premise is wrong, and step 8 is a no-op.** See the notes
  inline on those steps.

------------------------------------------------------------------------

## Where things stood on 2026-08-03

Facts checked that day, not recalled:

- CRAN serves **0.7.0**. `moderndive_0.8.0.tar.gz` is in
  `https://cran.r-project.org/incoming/archive/` and in **none** of the
  seven live folders (`inspect`, `pretest`, `recheck`, `newbies`,
  `publish`, `waiting`, `pending`) — checked individually. Per the
  incoming-folder semantics, `archive/` means the submission left the
  pipeline **without** publishing.
- The untracked `CRAN-SUBMISSION` records `Version: 0.8.0`,
  `Date: 2026-07-16 23:21:38 UTC`, `SHA: 9ea51de` — day 18 at time of
  writing.
- No `v0.8.0` tag exists; the newest tag is `v0.7.0` and the newest
  GitHub release is “moderndive 0.7.0”.
- Chester has emailed CRAN asking for an update, following Albert’s
  earlier mail. Albert is `cre`, so every CRAN email goes to him —
  Chester gets no inbox signal, which is what the local watcher exists
  to replace.

**Watcher:** `~/bin/cran-watch-moderndive.sh`, run by
`org.moderndive.cran-watch-moderndive` at 08:00 and 20:00 local; log and
state at `~/.local/state/cran-watch-moderndive.{log,state}`. It went
silent between 2026-08-02 08:00 and 2026-08-03 11:45 because the script
was moved out of `~/.local/bin/` and the agent was never
re-bootstrapped. If the log stops again, check
`launchctl list | grep moderndive` first — an empty result means the
agent is unloaded, not that CRAN is quiet.

## 0. Precondition

Confirm CRAN actually serves 0.8.0 — a version comparison, not a
page-exists check, since the package page returns 200 at 0.7.0
regardless:

``` bash
curl -s https://cran.r-project.org/web/packages/moderndive/index.html \
  | grep -A1 '>Version:<'
```

If the submission expired rather than published, none of the following
applies: it needs a fresh `submit_cran()` from a bumped version first.

## 1. This repo (`moderndive`, branch `master`) — manual

1.  **Tag the release.** The 0.8.0 source is commit `9ea51de`; the two
    commits after it (`2169591`, `0a40476`) only record win-builder URL
    false positives and revdepcheck results in `cran-comments.md`. The
    olympicAthletes precedent was to tag the **CRAN-submitted commit**,
    not the later doc commits:

    ``` bash
    git tag -a v0.8.0 9ea51de -m "moderndive 0.8.0 (CRAN)"
    git push origin v0.8.0
    ```

2.  **Cut the GitHub release** at that tag, with the 0.8.0 section of
    `NEWS.md` as the body.

3.  **Commit `CRAN-SUBMISSION`.** It is `.Rbuildignore`d but still
    untracked; olympicAthletes committed its equivalent post-acceptance.

4.  **Bump to development.** `DESCRIPTION` → `0.8.0.9000`, and open a
    new development section at the top of `NEWS.md`.

5.  Watch for the roxygen2 8.0.0 trap: running `devtools::document()`
    with it installed rewrites `RoxygenNote: 7.3.3` into
    `Config/roxygen2/version: 8.0.0` and duplicates the Authors block in
    `man/moderndive-package.Rd`. Revert that churn unless the upgrade is
    intended.

## 2. `ModernDive_book` (branch `v2`) — manual

6.  **Bump the renv pin.** `renv.lock` currently pins moderndive `0.7.0`
    (`Source: Repository`, `Repository: CRAN`). ~~CI renders against the
    lockfile, so until this moves the book keeps building against
    0.7.0.~~

    **CORRECTION (2026-08-04): that reason is wrong — the bump is
    cosmetic.** `quarto-publish.yml` disables renv entirely and installs
    the lockfile’s CRAN packages by name from a dated P3M snapshot, with
    `need <- setdiff(need, "moderndive")` (line 76) explicitly dropping
    moderndive, then clones **dev moderndive from GitHub `main`** (line
    125). `pr-preview.yml:60` and `audits.yml:304` do the same. So the
    lockfile is a *manifest* (which packages), not the *pin* (which
    versions) — the workflow even prints a “renv.lock version drift
    (informational)” report about exactly this gap. Bumped to `0.8.0`
    anyway so the manifest is accurate and that drift line goes quiet.
    No `Hash` fields exist in this lockfile (checked: 0 of 190 entries),
    so a Version-only edit is a complete edit.

    **The real follow-up this exposes:** now that 0.8.0 carries both
    multi-predictor
    [`get_correlation()`](https://moderndive.github.io/moderndive/reference/get_correlation.md)
    and
    [`View()`](https://moderndive.github.io/moderndive/reference/View.md),
    the “Install dev moderndive from GitHub” step and its stale comment
    (“multi-predictor
    [`get_correlation()`](https://moderndive.github.io/moderndive/reference/get_correlation.md)
    is not in the CRAN release yet”) could be retired in favor of the
    CRAN build across all three workflows. Deliberately **not** done as
    part of the release — it changes what production builds against and
    deserves its own change. Note it interacts with step 9: the webR
    side still needs the r-universe dev build for
    [`View()`](https://moderndive.github.io/moderndive/reference/View.md).

7.  **DONE 2026-08-04.** Published after all four `v2` workflows went
    green on `7ec85475c` (Quarto Publish, Audits, Spell check,
    node-guard) and after the new footnote was confirmed live at
    `moderndive.com/v2/01-getting-started.html` — the tag landed on
    `7ec85475c` as intended. The checklist HTML comment was stripped
    from the notes before publishing; the notes’ “0.8.0 on CRAN” claim
    is now true.

    **Publish the draft release `v2.9.0`.** It already exists as a draft
    targeting the `v2` **branch**, so publishing creates the tag at
    whatever `v2`’s tip is at that moment — confirm `v2` CI is green
    first. Its notes already claim “0.8.0 on CRAN”, which is why it was
    held back. A pre-publish checklist sits in an HTML comment at the
    top of the notes.

8.  ~~**Optionally** bump `latest_release_version` / date in
    `scripts/image_functions.R` if the preface should cite this release
    (called out by the draft’s own checklist).~~

    **NO-OP — do not do this (checked 2026-08-04).**
    `latest_release_version` / `latest_release_date` refer specifically
    to the **CRC Press print edition**, as the comment above them in
    `image_functions.R` says, and they feed one preface sentence: “The
    CRC Press print edition corresponds to Version 2.0.0 and released on
    `r latest_release_date`” (`00-preface.qmd:235`). v2.9.0 is an
    *online* release, so bumping these would make the preface claim a
    print edition that does not exist. The sibling constants
    `version <- "2.1.0"` / `date <- "April 27, 2026"` (“current online
    build”) are not referenced by any `.qmd`, `.yml`, or script — dead
    constants, left alone.

9.  **The webR cleanup is NOT automated — this is the trap.**
    `.github/workflows/webr-watch.yml` prunes graduated packages, but
    `scripts/promote_webr_packages.R` reads only the `pkg_data` list in
    `scripts/webr-shadow-library.R` — the GitHub-only *data* packages.
    `moderndive` sits in **`pkg_extras`**, so nothing prunes it
    automatically. Once `repo.r-wasm.org` serves 0.8.0, do these by
    hand:

    - drop the `moderndive` entry from `pkg_extras` in
      `scripts/webr-shadow-library.R` (it backfills `envoy_flights`,
      `early_january_2023_weather`, `un_member_states_2024` from the
      mirror);
    - remove the `https://moderndive.r-universe.dev` entry and the
      `- moderndive` package line from `_quarto.yml`, plus the comments
      explaining why they were needed;
    - re-examine the webR version pin in `_quarto.yml`, which is held at
      0.6.0 specifically because the r-universe dev build exporting
      [`View()`](https://moderndive.github.io/moderndive/reference/View.md)
      was only compiled for R 4.6.0.

    Do **not** do this on CRAN publication alone: CRAN and the webR wasm
    build are separate availability questions, and the wasm build lags.

    **STILL BLOCKED as of 2026-08-04.**
    `repo.r-wasm.org/bin/emscripten/contrib/ {4.4,4.5,4.6}/PACKAGES` all
    still carry moderndive **0.7.0** — checked per R version, not
    inferred. Re-check before touching any of the three sub-items. P3M
    was likewise still on 0.7.0 the day of publication (~1-day sync lag,
    nothing to do).

10. **DONE 2026-08-04** (`7ec85475c` on `v2`). The row had drifted to
    `01-getting-started.qmd:631`; the footnote is a reference-style
    `[^view-in-browser]` defined just after the callout closes, matching
    the `[^1]:` style already used in `07-sampling.qmd`.
    Footnote-inside-a-table- cell-inside-a-callout was verified by
    running pandoc on the extracted block rather than assumed. Not
    touched: the
    [`library(moderndive)`](https://moderndive.github.io/moderndive/)
    comment in the chapter’s `#| context: setup` cell (lines 649–650)
    still describes the r-universe shim — that wording belongs to step
    9.

    **Unblock the Ch1 cheatsheet footnote.** The deferred backlog item —
    footnote the `View(df)` row so it says that in the browser cells
    [`View()`](https://moderndive.github.io/moderndive/reference/View.md)
    comes from `moderndive` and renders an inline DT table. It was
    blocked because CRAN moderndive had no
    [`View()`](https://moderndive.github.io/moderndive/reference/View.md).
    Verified 2026-08-03 that `export(View)` **is** in `NAMESPACE` at
    0.8.0 and `NEWS.md` documents it there, so CRAN publication
    genuinely unblocks it. The row is at `01-getting-started.qmd:631` —
    re-locate it rather than trusting the line number, which has already
    drifted once.

## 3. `moderndive-instructor-resources` — mostly automatic

11. **`instructor-solutions/posit-cloud/setup.R` needs no edit.** It
    lists `moderndive` under `companion_packages` with
    `companion_min_cran = c(moderndive = "0.8.0")`, and checks CRAN live
    at install time: the moment CRAN carries ≥ 0.8.0 it installs from
    CRAN instead of GitHub, with no code change. That constant is the
    single source of truth — `student-setup.qmd` and
    `scripts/promote_cran_packages.R` read it too. Verify by running
    setup rather than by editing it.

12. **`instructor-solutions/common-errors.qmd`** carries a “package
    ‘moderndive’ is not available for this version of R” entry and a
    webR section describing the shadow-library shim. Review both once
    step 9 lands; the webR wording is only wrong after the shim entry is
    gone.

## Order that matters

Steps 1–5 are independent of everything else. Step 6 (renv pin) should
land before step 7 (publish v2.9.0) so the release tag points at a tree
that actually builds against 0.8.0. Steps 9 and 10 are gated on **webR**
and **CRAN** respectively — different signals, so they may land days
apart.
