## Submission

moderndive 0.8.1

This is a patch release with two bug fixes and one documentation link fix:

-   In an interactive RStudio session, `View()` now opens RStudio's data
    viewer again. It called `utils::View()`, which bypasses the `View()` that
    RStudio attaches in `package:utils`, so users got the external data
    editor window, and on macOS an error about a missing XQuartz library.
    `View()` now calls the `View()` attached in `package:utils` and falls
    back to `utils::View()` when `package:utils` is not attached.
-   `plot_3d_regression()` no longer emits a `plotly` warning when the plot
    is printed.
-   The StatCrunch source URL in `man/pennies.Rd` and
    `man/orig_pennies_sample.Rd` now points to its new host, since the old
    one redirects (301).

## Test environments

-   local macOS Tahoe 26.6 (aarch64), R 4.6.1
-   GitHub Actions
    -   windows: latest (release)
    -   macOS: latest (release)
    -   ubuntu: latest (release, devel, oldrel-1)

## R CMD check results

0 errors | 0 warnings | 0 notes

`urlchecker::url_check()` reports all URLs correct.

## Reverse dependencies

We checked the 2 reverse dependencies (LSTbook, pdxTrees) with
`revdepcheck::revdep_check()`, comparing R CMD check results across the CRAN
and dev versions of this package. We saw 0 new problems and failed to check
0 packages.
