
#' Read .rmd as text
#'
#' @param path
#'
#' @return
#'
#' @examples
file_read_lines <- function(path){

  readLines(path, skipNul = F)

}


#' rmd text converted to data frame and slide breaks identified
#' and which lines associated with each slide
#'
#' @param lines
#' @param pause_point
#'
#' @return
#'
#' @examples
lines_data_frame_portioned <- function(lines, pause_point = "^---$"){

  lines %>%
    stringr::str_replace_all(" ", "~~") %>%
    data.frame(line = .) %>%
    dplyr::mutate(original = stringr::str_replace_all(.data$line, "~~", " ")) %>%
    dplyr::mutate(slide_break = stringr::str_detect(.data$line, pause_point)) %>%
    dplyr::mutate(slide = cumsum(.data$slide_break))

}

#' remove slide breaks from content
#'
#' @param data_frame_portioned
#'
#' @return
#'
#' @examples
data_frame_portioned_remove_pause_points <- function(data_frame_portioned){

  data_frame_portioned %>%
    dplyr::filter(!.data$slide_break)

}



#' convert to list containing strings that have content between slide breaks
#'
#' @param data_frame_portioned
#'
#' @return
#'
#' @examples
data_frame_portioned_collapse_to_portion_list <- function(data_frame_portioned){

  data_frame_portioned %>%
  dplyr::group_by(.data$slide) %>%
  dplyr::summarize(slide_content = paste0(.data$line, collapse = "\n")) %>%
  dplyr::pull()

}

#' Quote the material betweeen the pause points ---
#'
#' @param portion_list
#'
#' @return
#'
#' @examples
portion_list_quote <- function(portion_list){

  portion_list %>%
    stringr::str_replace_all("\'", "\\\\'") %>%
    stringr::str_replace_all("\n", "\\\\n") %>%
  paste0("```{r, comment = '', echo = F, return = 'asis'}\ncat('---\n",
         .,
         "')\n```")

  portion_list %>%
    paste0("---\n````{verbatim}\n", ., "\n````")

}


#' Adding style and message to quoted text
#'
#' @param quoted
#'
#' @return
#'
#' @examples
quoted_style <- function(quoted){

  quoted %>%
  paste("\n---\nclass: inverse\n\n####From source .Rmd:\n\n",
        .)

}

#' Alternate original and quoted
#' quoted first, except for initial
#'
#' @param original
#' @param quoted
#'
#' @return
#'
#' @examples
original_quoted_combine <- function(original, quoted){

  original_mod <- original
  quoted_mod <- quoted

  original_mod[1] <- quoted[1]
  quoted_mod[1] <- original[1]

  #mostly quoted comes first
  paste0(quoted_mod, "\n---\n", original_mod)

}


#' Collapse text and save as .Rmd
#'
#' @param combined
#' @param file
#'
#' @return
#'
#' @examples
combined_collapse_and_save <- function(combined, file = "temp.Rmd"){

combined %>%
  paste0(collapse = "\n\n") %>%
  stringr::str_replace_all("~~", " ") %>%
  paste0("---\n", .) %>%
  writeLines(con = file)

}



#' Title crochet
#'
#' @param input path to .Rmd file
#' @param output path to .Rmd output
#'
#' @return saved file
#' @export
#'
#' @examples
doublecrochet <- function(input,
                    dcrocheted_rmd = stringr::str_replace(input,
                                                  "\\.rmd|\\.Rmd",
                                                  "_double_crochet.Rmd"),
                    render = T){
input %>%
  file_read_lines() %>%
  lines_data_frame_portioned() %>%
  data_frame_portioned_remove_pause_points() %>%
  data_frame_portioned_collapse_to_portion_list() ->
portion_list

portion_list %>%
  portion_list_quote() %>%
  quoted_style() ->
quoted

original_quoted_combine(portion_list, quoted) %>%
  combined_collapse_and_save(file = dcrocheted_rmd)

if(render){

  rmarkdown::render(input = dcrocheted_rmd)

}


}



# lines %>%
#   str_replace_all(" ", "~~") %>%
#   data.frame(line = .) %>%
#   mutate(original = str_replace_all(line, "~~", " ")) %>%
#   mutate(slide_break = str_detect(line, "^---$")) %>%
#   mutate(slide = cumsum(slide_break)) %>%
#   filter(!slide_break) %>%
#   group_by(slide) %>%
#   summarize(slide_content = paste0(line, collapse = "\n")) %>%
#   pull() %>%
#   str_replace_all("~~", " ") %>%
#   paste0("---\n",., "\n---\nclass: inverse\n\n",
#          "```{r, comment = '', echo = F, return = 'asis'}\ncat('````",
#          str_replace_all(str_replace_all(., "\'", "\\\\'"), "\n", "\\\\n") ,
#          "')\n```") %>%
#   paste0(collapse = "\n\n") %>%
#   writeLines(con = "test_out.Rmd")
#
# "```{r, comment = ''}\ncat("
# ")
# ```"






# mutate(start_portion = str_detect(line, "```\\{r")) %>%
# mutate(mod = ifelse(start_portion,
#                     paste0("````markdown\n", line,
#                            "`r ''`"), "")) %>%
# mutate(end_portion = str_detect(line, "```$")) %>%
# # filter(start_portion) %>%
# mutate(in_line = str_detect(line, "^`r")) %>%
# mutate(mod = ifelse(end_portion,
#                     paste0(line, "\n````"),
#                     "")) %>%

# ```markdown
# ---
#
#   ``r 'r portion_reveal("wrangle")'``
# ```
#
#
# ````markdown
# ```{r wrangle, include = FALSE}`r ''`
# cars %>%
#   mutate(high_speed =
#            speed > 10) %>%
#   mutate(high_dist =
#            dist > 20) ->
#   cars_mod
# ```
# ````
#
# ---
#
#   ```{r, comment = "", eval = T}
# cat("---\n\n```{r wrangle, include = FALSE}
# cars %>%
#   mutate(high_speed =
#            speed > 10) %>%
#   mutate(high_dist =
#            dist > 20) ->
# cars_mod
# ```\n\n---")
# ```



