# Regression model with one categorical explanatory/predictor variable

`geom_categorical_model()` fits a regression model using the categorical
x axis as the explanatory variable, and visualizes the model's fitted
values as piece-wise horizontal line segments. Confidence interval bands
can be included in the visualization of the model. Like
[`geom_parallel_slopes()`](https://moderndive.github.io/moderndive/reference/geom_parallel_slopes.md),
this function has the same nature as
[`geom_smooth()`](https://ggplot2.tidyverse.org/reference/geom_smooth.html)
from the `ggplot2` package, but provides functionality that
[`geom_smooth()`](https://ggplot2.tidyverse.org/reference/geom_smooth.html)
currently doesn't have. When using a categorical predictor variable, the
intercept corresponds to the mean for the baseline group, while
coefficients for the non-baseline groups are offsets from this baseline.
Thus in the visualization the baseline for comparison group's median is
marked with a solid line, whereas all offset groups' medians are marked
with dashed lines.

## Usage

``` r
geom_categorical_model(
  mapping = NULL,
  data = NULL,
  position = "identity",
  ...,
  se = TRUE,
  level = 0.95,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
)
```

## Arguments

- mapping:

  Set of aesthetic mappings created by
  [`aes()`](https://ggplot2.tidyverse.org/reference/aes.html). If
  specified and `inherit.aes = TRUE` (the default), it is combined with
  the default mapping at the top level of the plot. You must supply
  `mapping` if there is no plot mapping.

- data:

  The data to be displayed in this layer. There are three options:

  If `NULL`, the default, the data is inherited from the plot data as
  specified in the call to
  [`ggplot()`](https://ggplot2.tidyverse.org/reference/ggplot.html).

  A `data.frame`, or other object, will override the plot data. All
  objects will be fortified to produce a data frame. See
  [`fortify()`](https://ggplot2.tidyverse.org/reference/fortify.html)
  for which variables will be created.

  A `function` will be called with a single argument, the plot data. The
  return value must be a `data.frame`, and will be used as the layer
  data. A `function` can be created from a `formula` (e.g.
  `~ head(.x, 10)`).

- position:

  A position adjustment to use on the data for this layer. This can be
  used in various ways, including to prevent overplotting and improving
  the display. The `position` argument accepts the following:

  - The result of calling a position function, such as
    [`position_jitter()`](https://ggplot2.tidyverse.org/reference/position_jitter.html).
    This method allows for passing extra arguments to the position.

  - A string naming the position adjustment. To give the position as a
    string, strip the function name of the `position_` prefix. For
    example, to use
    [`position_jitter()`](https://ggplot2.tidyverse.org/reference/position_jitter.html),
    give the position as `"jitter"`.

  - For more information and other ways to specify the position, see the
    [layer
    position](https://ggplot2.tidyverse.org/reference/layer_positions.html)
    documentation.

- ...:

  Other arguments passed on to
  [`layer()`](https://ggplot2.tidyverse.org/reference/layer.html)'s
  `params` argument. These arguments broadly fall into one of 4
  categories below. Notably, further arguments to the `position`
  argument, or aesthetics that are required can *not* be passed through
  `...`. Unknown arguments that are not part of the 4 categories below
  are ignored.

  - Static aesthetics that are not mapped to a scale, but are at a fixed
    value and apply to the layer as a whole. For example,
    `colour = "red"` or `linewidth = 3`. The geom's documentation has an
    **Aesthetics** section that lists the available options. The
    'required' aesthetics cannot be passed on to the `params`. Please
    note that while passing unmapped aesthetics as vectors is
    technically possible, the order and required length is not
    guaranteed to be parallel to the input data.

  - When constructing a layer using a `stat_*()` function, the `...`
    argument can be used to pass on parameters to the `geom` part of the
    layer. An example of this is
    `stat_density(geom = "area", outline.type = "both")`. The geom's
    documentation lists which parameters it can accept.

  - Inversely, when constructing a layer using a `geom_*()` function,
    the `...` argument can be used to pass on parameters to the `stat`
    part of the layer. An example of this is
    `geom_area(stat = "density", adjust = 0.5)`. The stat's
    documentation lists which parameters it can accept.

  - The `key_glyph` argument of
    [`layer()`](https://ggplot2.tidyverse.org/reference/layer.html) may
    also be passed on through `...`. This can be one of the functions
    described as [key
    glyphs](https://ggplot2.tidyverse.org/reference/draw_key.html), to
    change the display of the layer in the legend.

- se:

  Display confidence interval around model lines? `TRUE` by default.

- level:

  Level of confidence interval to use (0.95 by default).

- na.rm:

  If `FALSE`, the default, missing values are removed with a warning. If
  `TRUE`, missing values are silently removed.

- show.legend:

  logical. Should this layer be included in the legends? `NA`, the
  default, includes if any aesthetics are mapped. `FALSE` never
  includes, and `TRUE` always includes. It can also be a named logical
  vector to finely select the aesthetics to display. To include legend
  keys for all levels, even when no data exists, use `TRUE`. If `NA`,
  all levels are shown in legend, but unobserved levels are omitted.

- inherit.aes:

  If `FALSE`, overrides the default aesthetics, rather than combining
  with them. This is most useful for helper functions that define both
  data and aesthetics and shouldn't inherit behaviour from the default
  plot specification, e.g.
  [`annotation_borders()`](https://ggplot2.tidyverse.org/reference/annotation_borders.html).

## See also

[`geom_parallel_slopes()`](https://moderndive.github.io/moderndive/reference/geom_parallel_slopes.md)

## Examples

``` r
library(dplyr)
#> 
#> Attaching package: ‘dplyr’
#> The following objects are masked from ‘package:stats’:
#> 
#>     filter, lag
#> The following objects are masked from ‘package:base’:
#> 
#>     intersect, setdiff, setequal, union
library(ggplot2)
library(moderndive)

p <- ggplot(evals, aes(x = rank, y = score)) +
  geom_point() +
  geom_categorical_model()
p


# In the above visualization, the solid line corresponds to the mean score
# for the baseline group "teaching", whereas the dashed lines correspond to
# the means for the non-baseline groups "tenure track" and "tenured".
# In the corresponding regression table the coefficients for "tenure track"
# and "tenured" are presented as offsets from the mean for "teaching":
model <- lm(score ~ rank, data = evals)
get_regression_table(model)
#> # A tibble: 3 × 7
#>   term              estimate std_error statistic p_value lower_ci upper_ci
#>   <chr>                <dbl>     <dbl>     <dbl>   <dbl>    <dbl>    <dbl>
#> 1 intercept            4.28      0.054     79.9    0        4.18     4.39 
#> 2 rank-tenure track   -0.13      0.075     -1.73   0.084   -0.277    0.017
#> 3 rank-tenured        -0.145     0.064     -2.28   0.023   -0.27    -0.02 

# You can use different colors for each categorical level
p %+% aes(color = rank)
#> Warning: <ggplot> %+% x was deprecated in ggplot2 4.0.0.
#> ℹ Please use <ggplot> + x instead.


# But mapping the color aesthetic doesn't change the model that is fit
p %+% aes(color = ethnicity)
```
