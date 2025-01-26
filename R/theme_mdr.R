#' Custom MDR ggplot2 Theme
#'
#' Colors are pulled from the MDR consoles in shown in the Severance TV show as
#'  well as from the (presumable) hex codes in the Lexington Letters.
#'
#' @return A ggplot2 theme object.
#' @export
#'
#' @examples
#' library(ggplot2)
#' ggplot(mtcars, aes(x = wt, y = mpg)) +
#'   geom_point() +
#'   labs(title = "Car Efficiency", subtitle = "MPG vs Weight") +
#'   theme_mdr()
theme_mdr <- function() {
  ggplot2::theme_minimal(base_family = "mono") +
    ggplot2::theme(
      # background color
      panel.background = ggplot2::element_rect(fill = "#030303", color = "#030303"),
      plot.background = ggplot2::element_rect(fill = "#030303", color = "#030303"),
      plot.title = ggplot2::element_text(color = "#CFE0E1", size = 16, face = "bold"),
      plot.subtitle = ggplot2::element_text(color = "#CFE0E1", size = 12),
      plot.caption = ggplot2::element_text(color = "#CFE0E1", size = 10),
      axis.title = ggplot2::element_text(color = "#CFE0E1", size = 12),
      axis.text = ggplot2::element_text(color = "#CFE0E1", size = 10),
      axis.line = ggplot2::element_line(color = "#CFE0E1"),
      # legend
      legend.title = ggplot2::element_text(color = "#CFE0E1"),
      legend.text = ggplot2::element_text(color = "#CFE0E1"),
      legend.background = ggplot2::element_rect(fill = "#030303", color = "#030303")
    ) +
    ggplot2::update_geom_defaults("point", ggplot2::aes(color = "#6AF307", size = 3))
}
