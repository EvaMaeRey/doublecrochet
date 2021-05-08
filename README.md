
<!-- README.md is generated from README.Rmd. Please edit that file -->

# doublecrochet

![](https://images.unsplash.com/photo-1577635515158-dcce4789c8fb?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=751&q=80)

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

Rmarkdown files are super cool because they allow you to co-mingle
prose, code, and code output in a single output file. Having code and
code output proximate in a rendered document is helpful at interpreting
intent of the code. And getting up and running with .Rmds is pretty easy
— learn bit about code chunks, a bit of markdown and you are good to go.

But there is a lot that you can do in .Rmds beyond the basics. May feel
.Rmd admiration and *wonder* when seeing the products of more advanced
users. How did they to *that*?

And as you become a more advanced user you might asked more and more:
How did you produce those slides, poster, dashboard etc.? How can you
easily deliver ‘the how-to goods’ in a detailed way when you get this
question?

**The goal of doublecrochet is to help you produce a second output from
your .Rmd – one that has source snippets quoted proximate (usually
prior) to the rendered output.**

The package is experimental, and now focused a case where there are
natural breakpoints – slideshows! Quoted source is presented on a slide,
then the rendered content is shown. Yay!

Inspiration for this project was creating [Easy Flipbooks
Recipes](https://evamaerey.github.io/flipbooks/flipbook_recipes#1) where
I was quoting my source a bunch w/ copy paste and fancy fencing. But it
was painstaking and error prone, and I only got through 4 recipes.

But there are more ‘recipes’ that I’d like to share. One test/use case
will be ‘Most Flipbookr Features’ template, a template that is part of
the flipbookr package that demonstrates (and I use for testing) most
flipbookr modes. Having ‘doublecrochet’ working should be nice for
communicating about how to use flipbookr – and other cool
xaringan-complementary packages.

Check out doublecrochet’s package template which features some cool
things you can do w/ Xaringan extension packages…

[Cool Xaringan
Stuff](https://evamaerey.github.io/vignettes/cool_xaringan_stuff.html)

<div style="position:relative;padding-top:56.25%;">

<iframe src="https://evamaerey.github.io/doublecrochet/vignettes/cool_xaringan_stuff.html" frameborder="2" webkitallowfullscreen mozallowfullscreen allowfullscreen style="position:absolute;top:0;left:0;width:100%;height:100%;" allowtransparency="true">
</iframe>

</div>

And

[Cool Xaringan Stuff Double
Crocheted](https://evamaerey.github.io/doublecrochet/vignettes/cool_xaringan_stuff_double_crochet.html)

<div style="position:relative;padding-top:56.25%;">

<iframe src="https://evamaerey.github.io/doublecrochet/vignettes/cool_xaringan_stuff_double_crochet.html" frameborder="2" webkitallowfullscreen mozallowfullscreen allowfullscreen style="position:absolute;top:0;left:0;width:100%;height:100%;" allowtransparency="true">
</iframe>

</div>

Meanwhile, we’ll think about how it can be used for other .Rmd products
where we don’t have slide breaks as natural pause points.

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

download.file("https://raw.githubusercontent.com/yihui/xaringan/master/inst/rmarkdown/templates/xaringan/skeleton/skeleton.Rmd", "xaringan_skeleton.Rmd")


## a text .rmd file stored on github
download.file(
  url = "https://raw.githubusercontent.com/EvaMaeRey/flipbookr/master/inst/rmarkdown/templates/double-crochet/skeleton/skeleton.Rmd", 
  destfile = "doublecrochet_example.Rmd")


crochet("doublecrochet_example.Rmd")
rmarkdown::render("doublecrochet_skeleton_double_crochet.Rmd")

crochet("xaringan_skeleton.Rmd")

# fails!  you've got to go into the .Rmd and fix up backslashes

# in fact for the math type the conversion is not working, you have to go back in and escape
# rmarkdown::render("xaringan_skeleton_double_crochet.Rmd")
```

Once you have the ‘doublecrochet’ version of your .Rmd, you can try to
compile and render this and you’ll have html output. Source will be
quoted throughout.
