## Test environments

* local macOS install, R 4.0.2
* win-builder (release, devel, oldrel)
* GitHub Actions
    + ubuntu-16.04: latest
    + windows: latest
    + macOS: latest, devel
* Rhub via devtools::check_rhub(env_vars=c(R_COMPILE_AND_INSTALL_PACKAGES = "always"))
    + Fedora Linux, R-devel, clang, gfortran
    + Windows Server 2008 R2 SP1, R-devel, 32/64 bit
    + Ubuntu Linux 16.04 LTS, R-release, GCC


## R CMD check results

Per Prof. Brian Ripley's email, this is a submission that addresses the problems in
his "CRAN packages suggesting vdiffr but not using it conditionally" email sent
on 2020/12/8. I am submitting before the 2021-01-12 deadline.


On the CRAN Package Check Results for Package moderndive page https://cran.r-project.org/web/checks/check_results_moderndive.html,
there is one Additional Issue "M1mac" https://www.stats.ox.ac.uk/pub/bdr/M1mac/moderndive.out,
which I believe has to with the vdiffr package. 


I also, obtained the following NOTES about (possibly) invalid URLs, but they all work just fine: 

URL: https://www.kaggle.com/c/house-prices-advanced-regression-techniques
  From: inst/doc/why-moderndive.html
  Status: 404
  Message: Not Found
URL: https://www.kaggle.com/harlfoxem/housesalesprediction
  From: man/house_prices.Rd
  Status: 404
  Message: Not Found
URL: https://www.kaggle.com/harlfoxem/housesalesprediction/data
  From: man/house_prices.Rd
  Status: 404
  Message: Not Found
URL: https://www.kaggle.com/ndalziel/massachusetts-public-schools-data
  From: man/MA_schools.Rd
  Status: 404
  Message: Not Found
URL: https://www.statcrunch.com/app/index.php?dataid=301596
  From: man/orig_pennies_sample.Rd
        man/pennies.Rd
  Status: Error
  Message: libcurl error code 60:
    	SSL certificate problem: certificate has expired
    	(Status without verification: OK