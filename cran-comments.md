## Test environments

* local macOS install, R 3.6.1
* ubuntu 14.04.5 (on travis-ci), R-release, R-devel, R-oldrel
* win-builder (release, devel, oldrelease)

## R CMD check results

While I obtained no errors, warnings, or notes on my local macOS and ubuntu (on travis-ci) test environments, I got the NOTE below on win-builder. However, I was able to access the URL on my web browser with no errors.

Found the following (possibly) invalid URLs:
  URL: https://chance.amstat.org/2013/04/looking-good/
    From: man/evals.Rd
    Status: Error
    Message: libcurl error code 35:
      	error:1407742E:SSL routines:SSL23_GET_SERVER_HELLO:tlsv1 alert protocol version
      	


