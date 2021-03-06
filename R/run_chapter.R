#' Runs chapter
#'
#' @return
#' @export
#'
#' @param chapter_path a book chapter like 2.2 or 3
#'
#' @value an R shiny app
#'
#' @examples
#'
#' \dontrun{
#' run_chapter(3)
#' run_chapter(2.2)
#' }
run_chapter <- function(chapter_path) {
  first_path <- paste0("chapters/", chapter_path)
  second_path <-
    paste0(
      "chapters/",
      stringr::str_extract(chapter_path, "[:digit:]+"),
      "/",
      chapter_path
    )
  if (file.exists(paste0(first_path, "/app.r"))) {
    shiny::shinyAppDir(first_path)
  } else if (dir.exists(second_path)) {
    shiny::shinyAppDir(second_path)
  } else {
    stop("No app")
  }
}
