# Teaching evaluations at the UT Austin

The data are gathered from end of semester student evaluations for a
sample of 463 courses taught by 94 professors from the University of
Texas at Austin. In addition, six students rate the professors' physical
appearance. The result is a data frame where each row contains a
different course and each column has information on either the course or
the professor <https://www.openintro.org/data/index.php?data=evals>

## Usage

``` r
evals
```

## Format

A data frame with 463 observations corresponding to courses on the
following 13 variables.

- ID:

  Identification variable for course.

- prof_ID:

  Identification variable for professor. Many professors are included
  more than once in this dataset.

- score:

  Average professor evaluation score: (1) very unsatisfactory - (5)
  excellent.

- age:

  Age of professor.

- bty_avg:

  Average beauty rating of professor.

- gender:

  Gender of professor (collected as a binary variable at the time of the
  study): female, male.

- ethnicity:

  Ethnicity of professor: not minority, minority.

- language:

  Language of school where professor received education: English or
  non-English.

- rank:

  Rank of professor: teaching, tenure track, tenured.

- pic_outfit:

  Outfit of professor in picture: not formal, formal.

- pic_color:

  Color of professor’s picture: color, black & white.

- cls_did_eval:

  Number of students in class who completed evaluation.

- cls_students:

  Total number of students in class.

- cls_level:

  Class level: lower, upper.

## Source

Çetinkaya-Rundel M, Morgan KL, Stangl D. 2013. Looking Good on Course
Evaluations. CHANCE 26(2).

## See also

The data in `evals` is a slight modification of
[`openintro::evals()`](https://openintrostat.github.io/openintro/reference/evals.html).
