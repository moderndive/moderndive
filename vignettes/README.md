# Journal of Open Source Education Article

The `JOSE.Rmd` file is the source file for a [Journal of Open Source Education (JOSE)](https://jose.theoj.org/) article. To create and preview the submission:

- In `paper.Rmd` uncomment the following lines
```
output:
  rticles::joss_article:
    keep_md: yes
    number_sections: yes
```
- From Terminal -> `vignettes/` folder -> run `./_build.sh` (see comments in `_build.sh` for more details)
- This will produce the `paper.md` file necessary for JOSE submission
- Test the submission [here](https://whedon.theoj.org/) by setting:
    - Paper repository address: <https://github.com/moderndive/moderndive>
    - Compile paper for: JOSE





