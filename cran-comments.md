## Test environments

* local macOS install, R 4.0.1
* ubuntu 16.04.6 on travis-ci (release, devel, oldrel)
* win-builder (release, devel, oldrel)
* GitHub Actions
    + ubuntu-16.04: release
    + windows: release
    + macOS: release, devel
* Rhub via devtools::check_rhub(env_vars=c(R_COMPILE_AND_INSTALL_PACKAGES = "always"))
    + Fedora Linux, R-devel, clang, gfortran
    + Windows Server 2008 R2 SP1, R-devel, 32/64 bit


## R CMD check results

Per Kurt Hornik's email, this is a submission that addresses the problems shown
on https://cran.r-project.org/web/checks/check_results_moderndive.html. I am
submitting before the 2020-07-20 deadline.

* I was not able to confirm checks for windows R-devel b/c the win-builder
upload page has been returning the following error for a few days now:
"ERROR: Access to the path 'C:\Inetpub\ftproot\R-devel\moderndive_0.5.0.tar.gz'
is denied."
* The Rhub Fedora Linux, R-devel, clang, gfortran returned NOTEs that it found the
following (possibly) invalid URLs. However I tested each out and had no problems
loading them.
    + https://www.kaggle.com/c/house-prices-advanced-regression-techniques
    + https://www.kaggle.com/harlfoxem/housesalesprediction
    + https://www.kaggle.com/harlfoxem/housesalesprediction/data
    + https://www.kaggle.com/ndalziel/massachusetts-public-schools-data
