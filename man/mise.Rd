\name{mise}
\alias{mise}

\title{
Mean integrated squared error
}

\description{
Computes the mean integrated squared error between a theoretical density
and an estimate given by \code{deamer}
}

\usage{
mise(density, obj)
}

\arguments{
  \item{density}{a theoretical density. Should be a single argument function
}
  \item{obj}{an object of class \code{'deamer'}. See \code{deamer-class}.
}
}
\note{
This function is mainly for simulation and comparison of methods.
}
\value{
Returns the value (scalar) of the mean integrated squared error.
}

\author{
Julien Stirnemann <j.stirnemann@gmail.com>
}


\seealso{
\code{\link{deamerKE}},\code{\link{deamerSE}},\code{\link{deamerRO}}, \code{\link{deamer}}, \code{\link{deamer-class}}
}

\examples{

 n=1000
 x <- rchisq(n, df=3)
 e <- rnorm(n,0,0.1)
 y <- x + e
 estimate <- deamerKE(y, noise.type="gaussian", sigma=0.1)
 f_th <- function(x) dchisq(x, df=3)
 
 mise(f_th, estimate)
 
}
