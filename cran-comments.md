## Test environments

* local macOS install, R 4.0.2
* win-builder (release, devel, oldrelease)
* GitHub Actions
    + ubuntu-16.04: latest
    + windows: latest
    + macOS: latest, devel
* Rhub via devtools::check_rhub(env_vars=c(R_COMPILE_AND_INSTALL_PACKAGES = "always"))
    + Fedora Linux, R-devel, clang, gfortran
    + Ubuntu Linux 20.04.1 LTS, R-release, GCC
    + Windows Server 2008 R2 SP1, R-devel, 32/64 bit


## R CMD check results

* Rhub Windows Server 2008 R2 SP1, R-devel, 32/64 bit returned the following NOTES:
    + Package suggested but not available for checking: 'readr'. I am able to install this package from CRAN without issue
    + Unable to find GhostScript executable to run checks on size reduction. I believe this issue is temporary as it wasn't flagged yesterday
* I obtained the following NOTE about (possibly) invalid URLs, but it works just fine: https://profiles.doe.mass.edu/state_report/

