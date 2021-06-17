# Two possible outputs of `moderndive.Rmd`

The `moderndive.Rmd` R Markdown creates two possible outputs:

## Package Vignette

Knit `moderndive.Rmd` to html_vignette as you normally would.

## Journal of Open Source Education Article

The `moderndive.Rmd` file is the source for a [Journal of Open Source Education (JOSE)](https://jose.theoj.org/) article. To preview a submission's PDF:

1. Ensure in `moderndive.Rmd` -> YAML `output:` section (about line 37) -> YAML code relating to `rticles::joss_article` is uncommented
1. From Terminal -> `vignettes/` folder -> run `./_build.sh` (see comments in `_build.sh` for more details)
1. This will produce the `paper.md` file necessary for JOSE submission
1. Test the submission [here](https://whedon.theoj.org/) by setting:
    1. Paper repository address: <https://github.com/moderndive/moderndive>
    1. Custom branch (optional): jose-paper
    1. Compile paper for: JOSE





