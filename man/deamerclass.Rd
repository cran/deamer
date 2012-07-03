\name{deamer-class}
\alias{deamer-class}
%\alias{deamer}
\alias{deamer.default}
\alias{predict.deamer}
%\alias{deamerSE}
%\alias{deamerRO}

\title{
Objects of class 'deamer'
}

\description{
The \code{deamer} class defines the objects produced by \code{deamer.default} or any of 
\code{deamerKE}, \code{deamerSE} or \code{deamerRO}. Objects of class \code{deamer}
can be used in generic functions such as \code{plot}, \code{print} and \code{predict}.\cr
The default function \code{deamer} assumes the user is familiar with all 3 methods "se", "ke" and "ro" (see \code{\link{deamer}} and details), whereas method-specific wrappers
\code{\link{deamerKE}}, \code{\link{deamerSE}}, \code{\link{deamerRO}} are intended for those who are not. 
}

\usage{

\method{deamer}{default}(y, errors, replicates, mu,  sigma, noise.type, method,
       grid.length, from, to, na.rm)
\method{predict}{deamer}(object, newdata, na.rm,...)
}

\arguments{
  \item{y}{Numeric. The vector of noisy observations.}
  \item{errors}{Numeric. The vector of the auxiliary sample of errors. 
                Does not need to be the same length as \code{'y'}.}
  \item{replicates}{Numeric. A 2-column matrix or 2-column numeric data-frame. 
                    Contains one replicate observation in each row. 
                    The number of rows does not need to match \code{length(y)}. }
  \item{mu}{Numeric. The (known) mean of the noise. Defaults to zero.}
  \item{sigma}{Numeric. The (known) standard deviation of the noise if \code{noise.type="Gaussian"} or scale if \code{noise.type="Laplace"}}
  \item{noise.type}{Character. Defines the type of density for the noise. Only \code{"Gaussian"} or \code{"Laplace"} are supported. Defaults to \code{"Gaussian"}}
  \item{method}{Character. Only one of \code{"ke"}, \code{"se"}, \code{"ro"}. 
                Defines the estimation method. See details. } 
  \item{grid.length}{Numeric. Optional. The number of points of the grid the estimation is performed on. Defaults to 100.}
  \item{from}{Numeric. Optional. The lower bound of the grid the estimation is performed on. Defaults to \code{min(y)}.}
  \item{to}{Numeric. Optional. The upper bound of the grid the estimation is performed on. Defaults to \code{max(y)}.}
  \item{na.rm}{Logical. Optional. If \code{na.rm=TRUE}, 
               NAs will be removed before estimation. Defaults to \code{FALSE}.}
  \item{object}{An object of class \code{deamer}}
  \item{newdata}{Numeric vector (possibly single valued).}
  \item{...}{Further arguments for generic functions}

}


\value{
\item{y}{The input vector.}
\item{f}{The deconvolution estimate of the density of \eqn{x}, estimated over \code{supp}.}
\item{n}{Length of input vector.}
\item{M}{Sample size of pure errors (argument \code{'errors'} with \code{method="se"} or \code{deamerSE}) or
         replicate observations (argument \code{'replicates'} with \code{method="ro"} or \code{deamerRO}). 
         For \code{method="ke"} or \code{deamerKE}, \code{M=NULL}}
\item{method}{The method of estimation. Possible values: \code{"kegauss"} for known Gaussian noise, 
               \code{"kelap"} for known Laplace noise,
               \code{"se"} for sample of pure errors, 
               \code{"ro"} for replicate noisy observations.}
\item{mu}{The mean of the error density for \code{method="ke"} or \code{deamerKE}. 
          For other methods, \code{mu=NULL}.}
\item{sigma}{The standard deviation (resp. scale parameter) of the error density for \code{method="ke"} or \code{deamerKE}
             with Gaussian noise (resp. Laplace noise).
             For other methods, \code{sigma=NULL}.}
\item{supp}{The grid of values used for estimation.}
\item{m}{The estimated parameter for adaptive model selection.}
\item{ahat}{Values of the estimated projection coefficients using Fast Fourier Transform.}

Generic function \code{predict} yields a vector of predictions.
}

\details{
The estimation method is chosen according to the \code{method} argument. 
For known density noise, \code{method="ke"} and arguments \code{'mu'} and \code{'sigma'}
should be supplied. For estimation with an auxiliary sample of errors \code{method="se"} and argument 
\code{'errors'} should be supplied. For estimation with an auxiliary sample of replicates, 
\code{method="ro"} and argument \code{'replicates'} should be supplied. 
For further details on each of these models, see \code{\link{deamer}} and functions
\code{\link{deamerKE}}, \code{\link{deamerSE}} and \code{\link{deamerRO}} respectively.
These functions are wrappers for deamer.default and have a more straightforward usage.
}

\section{Warning}{
Heteroscedastic errors are not supported in any of \code{deamerKE}, \code{deamerSE}, \code{deamerRO}.
}

\references{
\cite{Stirnemann JJ, Comte F, Samson A. Density estimation of a biomedical variable
      subject to measurement error using an auxiliary set of replicate observations.
      Statistics in medicine. 2012 May 17 [Epub ahead of print]}\cr
      
\cite{Comte F, Lacour C. Data-driven density estimation in the presence of additive
      noise with unknown distribution. Journal of the Royal Statistical Society:
      Series B (Statistical Methodology). 2011 Sep 1;73(4):601-27.}\cr
      
\cite{Comte F, Rozenholc Y, Taupin M-L. Penalized Contrast Estimator for Adaptive
      Density Deconvolution. The Canadian Journal of Statistics /
      La Revue Canadienne de Statistique. 2006; 34(3):431-52.}\cr
      
\cite{Comte F, Samson A, Stirnemann J. Deconvolution estimation of onset of pregnancy
      with replicate observations [Internet]. 2011 [cited 2011 Oct 25].
      Available from: http://hal.archives-ouvertes.fr/hal-00588235_v2/}  \cr
      
}

\author{ Julien Stirnemann <j.stirnemann@gmail.com> }

\seealso{
\code{\link{deamer}}, \code{\link{deamerKE}}, \code{\link{deamerRO}}, \code{\link{deamerSE}}
}

\examples{

#this example based on simulated data presents each method implemented in deamer. 
#the deamer function is presented but the wrappers deamerKE, deamerRO
#and deamerSE would yield the same results.
 
set.seed(12345)
n=1000; M=500
rff=function(x){
  u=rbinom(x, 1, 0.5)
  X=u*rnorm(x, -2, 1)+(1-u)*rnorm(x,2,1)
  return(X)
}
x <- rff(n) #a mixed gaussian distribution

# true density function:
f.true=function(x) (0.5/(sqrt(2*pi)))*(exp(-0.5*(x+2)^2) + exp(-0.5*(x-2)^2))

e <- rlaplace(n, 0, 0.5) # laplace noise
y <- x + e  # observations with additive noise

eps <- rlaplace(M, 0, 0.5) # a sample of pure errors for method="se"
# a 2-column matrix of replicate noisy observations for method="ro"
rep <- matrix(rep(rff(M),each=2)+rlaplace(2*M,0,0.5), byrow=TRUE, ncol=2)
 
#estimation with known error
# the same as deamerKE(y, noise.type="laplace", sigma=0.5)
est.ke <- deamer(y, noise.type="laplace", sigma=0.5, method="ke")  
#will generate a warning since we are assuming mu=0
est.ke

#estimation with an auxiliary sample of errors
# the same as deamerSE(y, errors=eps)
est.se <- deamer(y, errors=eps, method="se")
est.se

#estimation with replicate noisy observations
# the same as deamerRO(y, replicates=rep)
est.ro <- deamer(y, replicates=rep, method="ro")
est.ro

curve(f.true(x), from=-6, to=6,lwd=2, lty=2)
lines(est.ke, lwd=1, col="green3")
lines(est.se, lwd=1, col="blue2")
lines(est.ro, lwd=1, col="orange")
legend("topright", lty=c(2,1,1,1), col=c("black", "green3", "blue2","orange"), 
        legend=c("true density", "method='ke'", "method='se'", "method='ro'"),
        bty='n')
 
#compare predictions for each method for newx
newx=c(-2,0,2)
rbind(
      predict(est.ke, newdata=newx),
      predict(est.se, newdata=newx),
      predict(est.ro, newdata=newx)
      ) -> preds
dimnames(preds)<-list(c("ke","se","ro"),newx)
        #predictions are made at newdata
preds

}


\keyword{distribution}
\keyword{deconvolution}
\keyword{nonparametric}
\keyword{smooth}
