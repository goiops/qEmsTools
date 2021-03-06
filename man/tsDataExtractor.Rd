% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tsDataExtractor.R
\name{tsDataExtractor}
\alias{tsDataExtractor}
\title{tsDataExtractor}
\usage{
tsDataExtractor(ts_data_record)
}
\arguments{
\item{ts_data_record}{a single time-series object returned by a time-series query}
}
\value{
This function returns a dataframe with all the time-series parameters requested as well as an extra column for the flight record.
}
\description{
Pulls out the dataframe part of a time-series extract and appends the flight record as a column.
}
\details{
Time series are usually return as a nested list - this turns them into a simpler format.
}
\examples{
\dontrun{
ts_data <- tsDataExtractor(ts_data_record)
}
}
\author{
Matt Simmons mattsimmons@qantas.com.au
}
