% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/profExtremaNumOpt.R
\name{getProfileExtrema}
\alias{getProfileExtrema}
\title{Profile extrema with BFGS optimization}
\usage{
getProfileExtrema(f, fprime = NULL, d, allPsi, opts = NULL)
}
\arguments{
\item{f}{the function to be evaluated}

\item{fprime}{derivative of the function}

\item{d}{dimension of the input domain}

\item{allPsi}{a list containing the matrices Psi (dim \eqn{pxd}) for which to compute the profile extrema}

\item{opts}{a list containing the options for this function and the subfunctions \link{getProfileSup_optim}, \link{getProfileInf_optim}. The options only for getProfileExtrema are
\itemize{
\item{\code{limits:}}{an optional list containing \code{lower} and \code{upper}, two vectors with the limits of the input space. If NULL then \code{limits=list(upper=rep(1,d),lower=rep(0,d))}}
\item{\code{discretization:}}{an optional integer representing the discretization size for the profile computation for each dimension of eta. Pay attention that this leads to a grid of size \code{discretization^p}.}
\item{\code{heavyReturn:}}{If TRUE returns also all minimizers, default is FALSE.}
\item{\code{plts:}}{If TRUE and p==1 for all Psi in allPsi, plots the profile functions at each Psi, default is FALSE.}
\item{\code{verb:}}{If TRUE, outputs intermediate results, default is FALSE.}
}}
}
\value{
a list of two data frames (min, max) of the evaluations of \eqn{P^sup_Psi f(eta) = sup_{Psi x = \eta} f(x) } and \eqn{P^inf_Psi f(eta) = inf_{Psi x = \eta} f(x) }
discretized over 50 equally spaced points for each dimension for each Psi in \code{allPsi}. This number can be changed by defining it in options$discretization.
}
\description{
Evaluate profile extrema for a set of matrices allPsi with full optimization.
}
\examples{
# Compute the oblique profile extrema with full optimization on 2d example

# Define the function
testF <- function(x,params,v1=c(1,0),v2=c(0,1)){
return(sin(crossprod(v1,x)*params[1]+params[2])+cos(crossprod(v2,x)*params[3]+params[4])-1.5)
}

testFprime <- function(x,params,v1=c(1,0),v2=c(0,1)){
  return(matrix(c(params[1]*v1[1]*cos(crossprod(v1,x)*params[1]+params[2])-
                  params[3]*v2[1]*sin(crossprod(v2,x)*params[3]+params[4]),
                 params[1]*v1[2]*cos(crossprod(v1,x)*params[1]+params[2])-
                  params[3]*v2[2]*sin(crossprod(v2,x)*params[3]+params[4])),ncol=1))
}


# Define the main directions of the function
theta=pi/6
pparams<-c(1,0,10,0)
vv1<-c(cos(theta),sin(theta))
vv2<-c(cos(theta+pi/2),sin(theta+pi/2))

# Define optimizer friendly function
f <-function(x){
return(testF(x,pparams,vv1,vv2))
}
fprime <- function(x){
 return(testFprime(x,pparams,vv1,vv2))
}

# Define list of directions where to evaluate the profile extrema
all_Psi <- list(Psi1=vv1,Psi2=vv2)


\donttest{
# Evaluate profile extrema along directions of all_Psi
allOblique<-getProfileExtrema(f=f,fprime = fprime,d = 2,allPsi = all_Psi,
                              opts = list(plts=FALSE,discretization=100,multistart=8))


# Consider threshold=0
threshold <- 0

# Plot oblique profile extrema functions
plotMaxMin(allOblique,allOblique$Design,threshold = threshold)

## Since the example is two dimensional we can visualize the regions excluded by the profile extrema
# evaluate the function at a grid for plots
inDes<-seq(0,1,,100)
inputs<-expand.grid(inDes,inDes)
outs<-apply(X = inputs,MARGIN = 1,function(x){return(testF(x,pparams,v1=vv1,v2=vv2))})

# obtain the points where the profiles take the threshold value
cccObl<-getChangePoints(threshold = threshold,allRes = allOblique,Design = allOblique$Design)

# visualize the functions and the regions excluded

image(inDes,inDes,matrix(outs,ncol=100),col=grey.colors(20),main="Example and oblique profiles")
contour(inDes,inDes,matrix(outs,ncol=100),add=TRUE,nlevels = 20)
contour(inDes,inDes,matrix(outs,ncol=100),add=TRUE,levels = c(threshold),col=4,lwd=1.5)
plotOblique(cccObl$alwaysEx$`0`[[1]],all_Psi[[1]],col=3)
plotOblique(cccObl$alwaysEx$`0`[[2]],all_Psi[[2]],col=3)
plotOblique(cccObl$neverEx$`0`[[1]],all_Psi[[1]],col=2)
plotOblique(cccObl$neverEx$`0`[[2]],all_Psi[[2]],col=2)

}
}
\author{
Dario Azzimonti
}
