## Test environments

* local macOS install, R 4.0.2
* win-builder (release, devel, oldrelease)
* GitHub Actions
    + ubuntu-16.04: latest
    + windows: latest
    + macOS: latest, devel
* Rhub via devtools::check_rhub(env_vars=c(R_COMPILE_AND_INSTALL_PACKAGES = "always"))
    + Fedora Linux, R-devel, clang, gfortran
    + Windows Server 2008 R2 SP1, R-devel, 32/64 bit
    + Ubuntu Linux 16.04 LTS, R-release, GCC


## R CMD check results

