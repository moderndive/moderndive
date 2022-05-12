## Test environments

* local macOS install, R 4.0.3
* win-builder (release, devel, oldrelease)
* GitHub Actions
    + windows: latest
    + macOS: latest, devel
* Rhub via devtools::check_rhub(env_vars=c(R_COMPILE_AND_INSTALL_PACKAGES = "always"))
    + macOS 10.13.6 High Sierra, R-release, CRAN's setup
    + Windows Server 2008 R2 SP1, R-release, 32/64 bit
    + Windows Server 2008 R2 SP1, R-oldrel, 32/64 bit
    + Windows Server 2022, R-devel, 64 bit
    + Debian Linux, R-release, GCC
    + Debian Linux, R-patched, GCC
    + Debian Linux, R-devel, GCC
    + Debian Linux, R-devel, clang, ISO-8859-15 locale
    + Fedora Linux, R-devel, GCC
    + Fedora Linux, R-devel, clang, gfortran


## R CMD check results

NOTES:

* installed size is 5.0Mb (just at the limit)
* It says this URL is invalid, but it works just fine: https://profiles.doe.mass.edu/state_report/


