\name{deamerRO}
\alias{deamerRO}

\title{
Density estimation using an auxiliary sample of replicate noisy observations. 
}
\description{
\code{deamerRO} performs a deconvolution estimation of the density of a noisy variable ('y') under 
the hypothesis of an unknown density of the noise using an auxiliary sample of replicate observations 
("RO" for "replicate observations"). Therefore \code{deamerRO} requires two samples: one with single noisy observations and 
another with replicate noisy observations (see details).
}

\usage{
deamerRO(y, replicates, grid.length = 100, from, to, na.rm = FALSE)
}

\arguments{
  \item{y}{Numeric. The vector of noisy observations.}
  \item{replicates}{Numeric. A 2-column matrix or 2-column numeric data-frame. 
                    Contains one replicate observation in each row. 
                    The number of rows does not need to match \code{length(y)}. }
  \item{grid.length}{Numeric. Optional. The number of points of the grid the estimation 
                       is performed on. Defaults to 100. }
  \item{from}{Numeric. Optional. The lower bound of the grid the estimation is performed on. Defaults to \code{min(y)}.}
  \item{to}{Numeric. Optional. The upper bound of the grid the estimation is performed on. Defaults to \code{max(y)}.}
  \item{na.rm}{Logical. Optional. If \code{na.rm=TRUE}, 
               NAs will be removed before estimation. Defaults to \code{FALSE}.}}

\details{
The model is defined as \eqn{y = x + e}, where \eqn{x} and \eqn{e} both have unknown densities.\cr 
Replicate observations are defined as \deqn{z_1 = x + e_1}\deqn{z_2 = x + e_2}
The main underlying hypotheses are:
\enumerate{
 \item Homoscedasticity of the errors. 
 \item The errors \eqn{e_1} and \eqn{e_2} are independent. 
 \item The samples are independent.
 \item Errors are symmetric, 0-mean variables. 
 \item Errors \eqn{e}, \eqn{e_1} and \eqn{e_2} have the same distribution.
  }

}

\value{an object of class \code{'deamer'}}

\references{
\cite{Stirnemann JJ, Comte F, Samson A. Density estimation of a biomedical variable
      subject to measurement error using an auxiliary set of replicate observations.
      Statistics in medicine. 2012 May 17 [Epub ahead of print]}\cr

\cite{Comte F, Samson A, Stirnemann J. Deconvolution estimation of onset of pregnancy
      with replicate observations [Internet]. 2011 [cited 2011 Oct 25].
      Available from: http://hal.archives-ouvertes.fr/hal-00588235_v2/}\cr

}

\author{
Julien Stirnemann <j.stirnemann@gmail.com>
}

\section{Warning}{
\itemize{
\item \code{deamerRO} is not implemented for heteroscedastic errors.
\item Unlike \code{deamerKE} and \code{deamerSE}, \code{deamerRO} assumes the errors are centered around 0. 
}
}

\note{
\code{deamerRO} only allows for 2 replicates per observation for the moment (argument 'replicates' is a 2-column matrix or data-frame).
Future versions should allow using more than 2.

}



\seealso{
\code{\link{deamer}}, 
\code{\link{deamerKE}}, 
\code{\link{deamerSE}}, 
\code{\link{deamer-class}}
}


\examples{
set.seed(123)
n=1000 #sample size of single noisy observtions
M=500 #sample size of replicate observations

rff=function(x){
  u=rbinom(x, 1, 0.5)
  X=u*rnorm(x, -2, 1)+(1-u)*rnorm(x,2,1)
  return(X)
}
x <- rff(n) #a mixed gaussian distribution

# true density function:
f.true=function(x) (0.5/(sqrt(2*pi)))*(exp(-0.5*(x+2)^2) + exp(-0.5*(x-2)^2))

e <- rnorm(n,0,0.5)
y <- x + e

x. <- rff(M)

e1 <- rnorm(M,0,0.5)
e2 <- rnorm(M,0,0.5)
rep<-data.frame(y1=x.+e1, y2=x.+e2)

est<-deamerRO(y, replicates=rep)
est

plot(est, lwd=2)
curve(f.true(x), add=TRUE, lwd=2, lty=3)
lines(density(y), lwd=2, lty=4)
legend("topleft", bty="n", lty=c(1,3,4), lwd=2, legend=c("deamerRO", "true density", 
       "kernel density\nof noisy obs."))

}


