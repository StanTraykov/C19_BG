% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/c19_var_plot.R
\name{c19_var_plot}
\alias{c19_var_plot}
\title{Various plots from data.gov.bg data.}
\usage{
c19_var_plot(
  chart,
  roll_func = NULL,
  roll_window = 7,
  roll_align = "right",
  roll_fill = NA,
  line_legend = NULL,
  country_data = c19_bg_data()
)
}
\arguments{
\item{chart}{one of: "casesdeaths" | "age" | "dis" | "cases" |
"hospitalized" | "positivity" | "pospcr" | "posag"}

\item{roll_func}{function to roll, e.g. mean (default NULL = raw daily)}

\item{roll_window}{window for roll func in days (e.g. 7, 14)}

\item{roll_align}{rolling alignment (default: "right")}

\item{roll_fill}{fill missing values for rolling function (default: NA)}

\item{line_legend}{regular expression specifying lines that should be
labelled in-plot}

\item{country_data}{country data}
}
\description{
Various plots from data.gov.bg data.
}
\seealso{
Other plot funcs: 
\code{\link{c19_deaths_age}()},
\code{\link{c19_deaths_factor}()},
\code{\link{c19_deaths_map}()},
\code{\link{c19_deaths_total}()},
\code{\link{c19_eu_weekly}()},
\code{\link{c19_heat}()},
\code{\link{c19_oblasts}()},
\code{\link{c19_r_plot}()}
}
\concept{plot funcs}
