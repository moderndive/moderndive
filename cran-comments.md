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

## R CMD check results

0 errors | 0 warnings | 1 note

-   The "(possibly) invalid URLs" in the incoming feasibility NOTE are all
    false positives; each returns 200 in a browser:
    -   <https://en.wikipedia.org/wiki/Urn_problem> (man/bowl.Rd) and
        <https://en.wikipedia.org/wiki/List_of_states_with_nuclear_weapons>
        (man/un_member_states_2024.Rd) returned HTTP 429 (rate limiting) to
        the automated checker. These are dataset source citations and are
        valid.
    -   <https://database.coffeeinstitute.org/> (man/coffee_ratings.Rd)
        reported an expired SSL certificate on the Debian check; this is a
        third-party site outside our control and currently serves a valid
        certificate.
    -   <https://mesonet.agron.iastate.edu/request/download.phtml>
        (man/early_january_weather.Rd, man/early_january_2023_weather.Rd)
        returns a 301 to a block page because the site rejects automated
        user agents; it is valid in a browser and is the correct source
        citation for the dataset.
    -   <https://doi.org/> and <https://www.tidyverse.org/> are inside
        inst/doc/paper.pdf, the published Journal of Open Source Education
        paper included verbatim as a static vignette; we prefer not to alter
        the published artifact.

## Reverse dependencies

Checked with `revdepcheck::revdep_check()` — no new problems.
