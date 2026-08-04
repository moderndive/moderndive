## Submission

moderndive 0.8.0

-   New `View()` wrapper that works in non-interactive contexts (R Markdown,
    Quarto, webR) by rendering an inline `DT::datatable()` or static HTML
    table; `utils::View()` behavior is unchanged in interactive sessions.
-   `get_regression_table()`, `get_regression_points()`, and
    `get_regression_summaries()` now support `glm()` models and in-formula
    transformations.
-   `get_correlation()` now accepts multiple right-hand-side variables.
-   New `plot_3d_regression()` function (uses `plotly`, in Suggests).
-   Fixed `pennies_resamples` dataset (`replicate` column numbering).
-   Documentation examples now use package datasets.

## Test environments

-   local macOS install, R 4.5.x
-   win-builder (release, devel, oldrelease)
-   GitHub Actions
    -   windows: latest
    -   macOS: latest
    -   ubuntu: latest (release, devel, oldrel-1)

## Resubmission

This is a resubmission. As requested by Uwe Ligges (2026-08-02), the three
"Moved Permanently" URLs have been fixed:

-   The bare <https://doi.org/> link and <https://www.tidyverse.org/> inside
    inst/doc/paper.pdf now point to their 301 targets
    (<https://www.doi.org/> and <https://tidyverse.org/>); the full DOI
    links in the paper's references are unchanged.
-   The Iowa Environmental Mesonet source citation in
    man/early_january_weather.Rd and man/early_january_2023_weather.Rd now
    links an Internet Archive snapshot of the download page, since the live
    site redirects all automated user agents to a block page (the redirect
    target CRAN's checker sees is that block page, not a moved resource).

We additionally audited every URL in the package and preemptively fixed all
other redirecting or inaccessible links (permanently-redirected Spotify
developer-documentation and Kaggle dataset paths, a retired goo.gl short
link, an http:// Creative Commons link in inst/doc/paper.pdf, and two
source links that now reject automated requests or are no longer publicly
accessible, which were replaced with unlinked source descriptions).
`urlchecker::url_check()` now reports all URLs correct.

## R CMD check results

0 errors | 0 warnings | 1 note

-   Possible NOTE on "(possibly) invalid URLs": in past pre-tests,
    <https://en.wikipedia.org/wiki/Urn_problem> and
    <https://en.wikipedia.org/wiki/List_of_states_with_nuclear_weapons>
    intermittently returned HTTP 429 (rate limiting) to the automated
    checker, and <https://database.coffeeinstitute.org/> intermittently
    reported an expired SSL certificate on the Debian check. All are valid
    dataset source citations that return 200 in a browser.

## Reverse dependencies

We checked the 2 reverse dependencies (LSTbook, pdxTrees) with
`revdepcheck::revdep_check()`, comparing R CMD check results across the CRAN
and dev versions of this package. We saw 0 new problems and failed to check
0 packages.
