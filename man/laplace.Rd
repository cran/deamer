\name{laplace}
\alias{rlaplace}
\alias{dlaplace}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Laplace distribution
}
\description{
density and random generation for the Laplace distribution of mean \code{'mu'} and scale 
parameter \code{'b'}
}
\usage{
dlaplace(x, mu=0, b=1)
rlaplace(n, mu=0, b=1)
}

\arguments{
  \item{x}{vector of quantiles.
}
  \item{n}{number of observations.
}
  \item{mu}{mean. Should be a single value. Defaults to 0. 

}
  \item{b}{scale. Should be a single value. Defaults to 1.

}
}

\value{
Returns a vector of \code{n} draws from a Laplace distribution
}

\details{
The Laplace density function is parameterized as:
\deqn{\frac{1}{2b}exp\Big(-\frac{|x-\mu|}{b}\Big)}{exp(-|x-mu|/b)/(2b)} 
}

\author{
Julien Stirnemann <j.stirnemann@gmail.com>
}

\examples{
set.seed(1234)

n=1000
x <- rchisq(n,3)
b=0.4
e <- rlaplace(n, 0, b)
y <- x + e  #noisy observations with laplace noise

}  
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
