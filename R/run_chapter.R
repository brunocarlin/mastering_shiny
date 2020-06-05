
#' Runs chapter
#'
#' @return
#' @export
#'
#' @examples run_chapter(3)
run_chapter <- function(chapter_path) {
  first_path <- paste0("chapters/", chapter_path)
  second_path <-
    paste0("chapters/",
           stringr::str_extract(chapter_path, "[:digit:]+"),
           "/",
           chapter_path)
  if (file.exists(paste0(first_path,"/app.r"))) {
    shinyAppDir(first_path)
  } else if (dir.exists(second_path)) {
    shinyAppDir(second_path)
  } else stop("No app")

}
