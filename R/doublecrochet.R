
file_read_lines <- function(path){

  readLines(path, skipNul = F)

}


lines_data_frame_chunked <- function(lines, pause_point = "^---$"){

  lines %>%
    stringr::str_replace_all(" ", "~~") %>%
    data.frame(line = .) %>%
    dplyr::mutate(original = stringr::str_replace_all(line, "~~", " ")) %>%
    dplyr::mutate(slide_break = stringr::str_detect(line, pause_point)) %>%
    dplyr::mutate(slide = cumsum(slide_break))

}

data_frame_chunked_remove_pause_points <- function(data_frame_chunked){

  data_frame_chunked %>%
    filter(!slide_break)

}



data_frame_chunked_collapse_to_chunk_list <- function(data_frame_chunked){

  data_frame_chunked %>%
  group_by(slide) %>%
  summarize(slide_content = paste0(line, collapse = "\n")) %>%
  pull()

}

chunk_list_quote <- function(chunk_list){

  chunk_list %>%
    stringr::str_replace_all("\'", "\\\\'") %>%
    stringr::str_replace_all("\n", "\\\\n") %>%
  paste0("```{r, comment = '', echo = F, return = 'asis'}\ncat('---\n",
         .,
         "')\n```")

}




quoted_style <- function(quoted){

  quoted %>%
  paste("\n---\nclass: inverse\n\n#Quoting source .Rmd:n\n",
        .)

}

original_quoted_combine <- function(original, quoted){

  original_mod <- original
  quoted_mod <- quoted

  original_mod[1] <- quoted[1]
  quoted_mod[1] <- original[1]

  #mostly quoted comes first
  paste0(quoted_mod, "\n---\n", original_mod)


}


combined_collapse_and_save <- function(combined, file = "temp.Rmd"){

combined %>%
  paste0(collapse = "\n\n") %>%
  str_replace_all("~~", " ") %>%
  paste0("---\n", .) %>%
  writeLines(con = file)

}



crochet <- function(input, output = str_replace(input, "\\.rmd|\\.Rmd", "_double.Rmd")){

input %>%
  file_read_lines() %>%
  lines_data_frame_chunked() %>%
  data_frame_chunked_remove_pause_points() %>%
  data_frame_chunked_collapse_to_chunk_list() ->
chunk_list

chunk_list %>%
  chunk_list_quote() %>%
  quoted_style() ->
quoted

original_quoted_combine(chunk_list, quoted) %>%
  combined_collapse_and_save(file = output)

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






# mutate(start_chunk = str_detect(line, "```\\{r")) %>%
# mutate(mod = ifelse(start_chunk,
#                     paste0("````markdown\n", line,
#                            "`r ''`"), "")) %>%
# mutate(end_chunk = str_detect(line, "```$")) %>%
# # filter(start_chunk) %>%
# mutate(in_line = str_detect(line, "^`r")) %>%
# mutate(mod = ifelse(end_chunk,
#                     paste0(line, "\n````"),
#                     "")) %>%

# ```markdown
# ---
#
#   ``r 'r chunk_reveal("wrangle")'``
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



