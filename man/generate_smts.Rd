% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{generate_smts}
\alias{generate_smts}
\title{Sequential Minimal Training Samples for Categorical Data}
\usage{
generate_smts(x, n = 2 * length(x[!is.na(x)]))
}
\arguments{
\item{x}{Atomic vector of an eligible data type (\code{\link[base]{logical}}, \code{\link[base]{integer}}, \code{\link[base]{double}} and \code{\link[base]{character}}).}

\item{n}{Numeric vector of \code{\link[base]{length}} 1 indicating the number of samples to generate.}
}
\value{
Returns a \code{\link[base]{list}} with \code{\link[base]{length}} \code{n}. Each element of this list contains a minimal training sample with data of the same type as \code{x}.
}
\description{
\loadmathjax Generate sequential minimal training samples for Binomial and Multinomial models as described in \insertCite{berger2004training;textual}{polya}.
}
\details{
Training samples play a central role in a variety of statistical methodologies and are particularly usefull to

Sequential minimal training samples (SMTS) are obtained by randomly drawing from \code{x} (without replacement for a given SMTS), stopping when the subset is a proper traiing sample.
}
\examples{
set.seed(10)

data_1 <- sample(letters[1:3], size = 5, replace = TRUE)
generate_smts(data_1, 3)

data_2 <- sample(1:10, size = 3, replace = TRUE)
generate_smts(data_2, 5)

}
\references{
\insertAllCited{}
}
\seealso{
\itemize{
\item \code{\link[polya]{ibf}}, \code{\link[polya]{aibf}} and \code{\link[polya]{gibf}} for the implementation of intrinsic Bayes factors that use sequential minimal training samples.
}
}
