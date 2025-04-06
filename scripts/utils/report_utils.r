library(rmarkdown)

render_report <- function(input_file, output_file) {
    render(input_file, output_file = output_file)
}
