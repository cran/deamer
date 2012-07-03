\name{deamerSE}
\alias{deamerSE}

\title{
Density estimation using an auxiliary sample of pure errors 
}

\description{
\code{deamerSE} performs a deconvolution estimation of the density of a noisy variable (\code{'y'}) under 
the hypothesis of an unknown density of the noise using an auxiliary sample of pure errors ("SE" for "sample error"). 
Therefore, \code{deamerSE} requires two samples: one with single noisy observations and another with pure errors.
}

\usage{
deamerSE(y, errors, grid.length = 100, from, to, na.rm = FALSE)
}

\arguments{
  \item{y}{Numeric. The vector of noisy observations.}
  \item{errors}{Numeric. The vector of the auxiliary sample of errors. 
                Does not need to be the same length as \code{'y'}.}
  \item{grid.length}{Numeric. Optional. The number of points of the grid the estimation 
                     is performed on. Defaults to 100.}
  \item{from}{Numeric. Optional. The lower bound of the grid the estimation is performed on. Defaults to \code{min(y)}.}
  \item{to}{Numeric. Optional. The upper bound of the grid the estimation is performed on. Defaults to \code{max(y)}.}
  \item{na.rm}{Logical. Optional. If \code{na.rm=TRUE}, 
               NAs will be removed before estimation. Defaults to \code{FALSE}.}
}

\details{
The model is \eqn{y = x + e} where \eqn{x} and \eqn{e} both have unknown densities.
The density of \eqn{x} is estimated by using an independant auxiliary sample of 
pure errors \eqn{eps} (argument '\code{errors}') that will be used for computing 
the characteristic function of the noise. It is therefore essential to ensure that 
\eqn{e} and \eqn{eps} arise from the same distribution (generally experimentally).\cr  
\code{deamerSE} will handle non-centered errors. Therefore, the input vector for argument \code{errors} 
does not necessarily need to be centered before estimation.
}

\section{Warning}{
\code{deamerSE} is not implemented for heteroscedastic errors.
}


\value{An object of class \code{'deamer'}}

\references{
\cite{Comte F, Lacour C. Data-driven density estimation in the presence of additive
      noise with unknown distribution. Journal of the Royal Statistical Society:
      Series B (Statistical Methodology). 2011 Sep 1;73(4):601-27.}\cr
}
\author{Julien Stirnemann <j.stirnemann@gmail.com>}


\seealso{
\code{\link{deamer}}, 
\code{\link{deamerKE}}, 
\code{\link{deamerRO}}, 
\code{\link{deamer-class}}
}

\examples{

################################################################################
# Example 1: centered errors
set.seed(23456)
n = 1000; M = 500
x <- rchisq(n,3)
b=0.5
e <- rlaplace(n, 0, b)
y <- x + e

eps <- rlaplace(M, 0, b)

est <- deamerSE(y, eps)
est

curve(dchisq(x, 3), 0, 12, lwd=2, lty=3)
lines(est, lwd=2)
lines(density(y), lwd=2, lty=4)
legend("topright", bty="n", lty=c(1,3,4), lwd=2, legend=c("deamerSE", "true density", 
       "kernel density\nof noisy obs.")) 

################################################################################
# Example 2: non-centered errors
set.seed(23456)
n = 1000; M = 500
x <- rchisq(n,3)
mu=2; b=0.5
e <- rlaplace(n, mu, b)
y <- x + e

eps <- rlaplace(M, mu, b)

est <- deamerSE(y, eps, from=0, to=12)
est

curve(dchisq(x, 3), 0, 12, lwd=2, lty=3)
lines(est, lwd=2)
lines(density(y), lwd=2, lty=4)
legend("topright", bty="n", lty=c(1,3,4), lwd=2, legend=c("deamerSE", "true density", 
       "kernel density\nof noisy obs.")) 

}

