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
    + Ubuntu Linux 16.04 LTS, R-release, GCC


## R CMD check results

Per Prof. Brian Ripley's email, this is a submission that addresses the problems in
his "CRAN packages suggesting vdiffr but not using it conditionally" email sent
on 2020/12/8. I am submitting before the 2021-01-12 deadline.