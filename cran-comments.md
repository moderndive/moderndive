## Test environments

* local macOS install, R 3.6.1
* ubuntu 16.04.6 (on travis-ci), R-release, R-devel, R-oldrel
* win-builder (release, devel)
* Rhub
    + Windows Server 2008 R2 SP1, R-devel, 32/64 bit
    + Ubuntu Linux 16.04 LTS, R-release, GCC
    + Fedora Linux, R-devel, clang, gfortran

    
## R CMD check results

While I obtained no errors, warnings, or notes on my local macOS and ubuntu (on travis-ci) test environments, I got the NOTE below on win-builder. However, I was able to access the URL on my web browser with no errors.

Found the following (possibly) invalid URLs:
  URL: https://chance.amstat.org/2013/04/looking-good/
    From: man/evals.Rd
    Status: Error
    Message: libcurl error code 35:
      	error:1407742E:SSL routines:SSL23_GET_SERVER_HELLO:tlsv1 alert protocol version
      	


