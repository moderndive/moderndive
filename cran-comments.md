## Resubmission

This is a resubmission of moderndive v0.5.3 that fixes URL's.



## Test environments

* local macOS install, R 4.0.3
* win-builder (release, devel, oldrelease)
* GitHub Actions
    + ubuntu-16.04: latest
    + windows: latest
    + macOS: latest, devel
* Rhub via devtools::check_rhub(env_vars=c(R_COMPILE_AND_INSTALL_PACKAGES = "always"))
    + Apple Silicon (M1), macOS 11.6 Big Sur, R-release
    + macOS 10.13.6 High Sierra, R-release, CRAN's setup
    + Windows Server 2008 R2 SP1, R-release, 32/64 bit
    + Windows Server 2008 R2 SP1, R-oldrel, 32/64 bit
    + Windows Server 2022, R-devel, 64 bit
    + Debian Linux, R-release, GCC
    + Fedora Linux, R-devel, GCC
    + Debian Linux, R-patched, GCC
    + Fedora Linux, R-devel, clang, gfortran
    + Debian Linux, R-devel, GCC
    + Debian Linux, R-devel, clang, ISO-8859-15 locale
    + Oracle Solaris 10, x86, 32 bit, R release, Oracle Developer Studio 12.6
    + Oracle Solaris 10, x86, 32 bit, R-release


## R CMD check results

* 

