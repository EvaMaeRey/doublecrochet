
<!-- README.md is generated from README.Rmd. Please edit that file -->

# doublecrochet

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

Rmarkdown files are super cool because they allow you to co-mingle
prose, code, and output in a single output file. Having code and code
output proximate in a rendered document is helpful at interpreting
intent of the code. And getting up and running with .Rmds is pretty easy
— learn about code chunks, learn a bit of markdown and you are good to
go.

But there is a lot that you can do in .Rmds beyond the basics. One can
quickly experience .Rmd envy when seeing the products of more advanced
users.

And as you become a more advanced user you might asked more and more:
How did you produce those slides, poster, dashboard etc.? How can you
easily deliver ‘the how-to goods’ in a detailed way when you get this
question?

**The goal of doublecrochet is to help you produce a second output from
your .Rmd – one that has source snippets quoted proximate (usually
prior) to the rendered output.**

The package is experimental, and now focused a case where there are
natural breakpoints – slideshows\! Quoted source is be presented on a
slide, then the rendered content is shown. Yay\!

Inspiration for this project was creating [Easy Flipbooks
Recipes](https://evamaerey.github.io/flipbooks/flipbook_recipes#1) where
I was quoting my source a bunch w/ copy paste and fancy fencing. But it
was painstaking and error prone, and I only got through 4 recipes. But
there are more ‘recipes’ that I’d like to share. One test/usecase will
be ‘Most Flipbookr Features’ template, a template that is part of the
flipbookr package that demonstrates (and I use for testing) most
flipbookr modes. Having ‘doublecrochet’ working should be nice for
communicating about how to use flipbookr – and other cool
xaringan-complementary packages. Meanwhile, we’ll think about how it can
be used for other .Rmd products where we don’t have slide breaks as
natural pause points.

## Installation

<!-- You can install the released version of doublecrochet from [CRAN](https://CRAN.R-project.org) with: -->

<!-- ``` r -->

<!-- install.packages("doublecrochet") -->

<!-- ``` -->

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("EvaMaeRey/doublecrochet")
```

## Example

For now doublecrochet::crochet() is intended for use with xaringan .Rmd
slide show files:

``` r
library(doublecrochet)

## a text .rmd file stored on github
my_rmd <- "https://raw.githubusercontent.com/EvaMaeRey/flipbookr/master/inst/rmarkdown/templates/minimal-flipbook/skeleton/skeleton.Rmd"

## translating to the _double version
crochet(my_rmd, output = "my_rmd_double.Rmd")
```

Once you have the ‘doublecrochet’ version of your .Rmd, you can compile
and render this and you’ll have html output w source quoted throughout.
