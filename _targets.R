library(targets)
library(tarchetypes)

render_to_output_dir <- function(infile) {
  outfile <- rmarkdown::render(infile, output_dir="output")
  return(outfile)
}

list(
  tar_files(infiles, file.path("docs", list.files("docs", recursive=T,pattern="*.Rmd"))),
  tar_target(report, render_to_output_dir(infiles), pattern = map(infiles), format="file")
)