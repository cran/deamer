\name{deamerKE}

\alias{deamerKE}

\title{
Density estimation with known error density 
}

\description{
\code{deamerKE} performs a deconvolution estimation of the density of a noisy variable (\code{'y'}) under 
the hypothesis of a known density of the noise ("KE" for "known error").
\code{deamerKE} allows to choose between a Gaussian or a Laplace density for the noise. 
The standard deviation of the noise (resp. the scale parameter) is required. By default, \code{deamerKE} 
will consider the noise centered around zero.
}

\usage{
deamerKE(y, mu, sigma, noise.type, grid.length = 100, from, to, na.rm = FALSE)
}

\arguments{
  \item{y}{Numeric. The vector of noisy observations}
  \item{mu}{Numeric. The (known) mean of the noise. Defaults to zero.}
  \item{sigma}{Numeric. The (known) standard deviation of the noise if \code{noise.type="Gaussian"} or scale if \code{noise.type="Laplace"}}
  \item{noise.type}{Character. Defines the type of density for the noise. Only \code{"Gaussian"} or \code{"Laplace"} are supported. Defaults to \code{"Gaussian"}}
  \item{grid.length}{Numeric. Optional. The number of points of the grid the estimation is performed on. Defaults to 100.}
   \item{from}{Numeric. Optional. The lower bound of the grid the estimation is performed on. Defaults to \code{min(y)}.}
  \item{to}{Numeric. Optional. The upper bound of the grid the estimation is performed on. Defaults to \code{max(y)}.}
  \item{na.rm}{Logical. Optional. If \code{na.rm=TRUE}, 
               NAs will be removed before estimation. Defaults to \code{FALSE}.}}

\details{
The model is \eqn{y = x + e} where \eqn{x} has an unknown density \eqn{f} and 
\eqn{e} is a symmetric variable around \code{mu} (either Laplace or Gaussian).
Therefore, \code{deamerKE} can directly handle non-centered noise by specifying \code{mu}.\cr
The Gaussian mean and standard deviation have the general meaning.
The Laplace density function is parameterized as:
\deqn{\frac{1}{2\sigma}exp\Big(-\frac{|x-\mu|}{\sigma}\Big)}{exp(-|x-mu|/sigma)/(2sigma)} 
}

\section{Warning}{
\code{deamerKE} is not implemented for heteroscedastic errors.
}


\value{
An object of class \code{'deamer'}
}

\author{Julien Stirnemann <j.stirnemann@gmail.com>}

\references{
\cite{Comte F, Rozenholc Y, Taupin M-L. Penalized Contrast Estimator for Adaptive
      Density Deconvolution. The Canadian Journal of Statistics /
      La Revue Canadienne de Statistique. 2006; 34(3):431-52.}\cr
      
}

\seealso{
\code{\link{deamer}}, 
\code{\link{deamerRO}}, 
\code{\link{deamerSE}}, 
\code{\link{deamer-class}}
}


\examples{

#########################################################
#EXAMPLE 1: known error, Laplacian

set.seed(12345)
n=1000
rff=function(x){
  u=rbinom(x, 1, 0.5)
  X=u*rnorm(x, -2, 1)+(1-u)*rnorm(x,2,1)
  return(X)
}
x <- rff(n) #a mixed gaussian distribution

# true density function:
f.true=function(x) (0.5/(sqrt(2*pi)))*(exp(-0.5*(x+2)^2) + exp(-0.5*(x-2)^2))

e <- rlaplace(n, 0, 0.5)
y <- x + e

est <- deamerKE(y, noise.type="laplace", sigma=0.5)
est

curve(f.true(x), -6, 6, lwd=2, lty=3)
lines(est, lwd=2)
lines(density(y), lwd=2, lty=4)
legend("topleft", bty="n", lty=c(1,3,4), lwd=2, legend=c("deamerKE", "true density", 
       "kernel density\nof noisy obs."))

#########################################################
#EXAMPLE 2: known error, Laplacian and non-centered 

set.seed(12345)
n=1000
rff=function(x){
  u=rbinom(x, 1, 0.5)
  X=u*rnorm(x, -2, 1)+(1-u)*rnorm(x,2,1)
  return(X)
}
x <- rff(n) #a mixed gaussian distribution

# true density function:
f.true=function(x) (0.5/(sqrt(2*pi)))*(exp(-0.5*(x+2)^2) + exp(-0.5*(x-2)^2))

e <- rlaplace(n, 2, 0.5) #mean=2 and not zero!
y <- x + e

est <- deamerKE(y, noise.type="laplace", mu=2, from=-4, to=4, sigma=0.5)
est

curve(f.true(x), -6, 6, lwd=2, lty=3)
lines(est, lwd=2)
lines(density(y), lwd=2, lty=4)
legend("topleft", bty="n", lty=c(1,3,4), lwd=2, legend=c("deamerKE", "true density", 
       "kernel density\nof noisy obs."))


}

