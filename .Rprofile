#options(latexcmd="/usr/texbin/pdflatex")
options(repos="http://streaming.stat.iastate.edu/CRAN")
#options(repos="http://cran.opensourceresources.org/")

#if (substr(R.version$os,1,5) == "darwi") {
#    .libPaths('~/Dropbox/Library/R/i386-apple-darwin9.8.0/2.12.1/')
#}
#
#if (interactive()){
#    local({
#            options(help_type='html')
#    })
#}

#Sys.setenv(PATH=paste(Sys.getenv('PATH'),':/usr/texbin'))

#library(pgfSweave)
#Sweave <- function(file) { 
#    pgfSweave(file,compile.tex=TRUE,syntax=getOption("SweaveSyntax"),pdf=TRUE,clean=TRUE,quiet=FALSE)
#}

if (interactive()) {
#   library(colorout)
#   library(setwidth)
   library(vimcom)
  
  get.nonsynced.packages <- function() {
    remove.manipulate <- function(x) {
        m <- match('manipulate',x)
        if (!is.na(m))
          x <- x[-m]
        x
      }
    
    load('~/Dropbox/Library/.Rpackages.Rdata')
    pkgs <- remove.manipulate(pkgs)
    me.pkgs <- rownames(utils::installed.packages())
    me.pkgs <- remove.manipulate(me.pkgs)
    shared <- intersect(pkgs,me.pkgs)
    to.install <- pkgs[match(pkgs,shared,nomatch=0)==0]
    to.install
  }
  
  sync.packages <- function()  {
          
    cat('Syncing package installations...\n')
    
    to.install <- get.nonsynced.packages()
    if (length(to.install)>0)
    {
      cat(paste("... Installing packages:",paste(to.install,collapse=', '),'\n'))
      install.packages(to.install,dep=TRUE)
    } else {
      cat("... Package installation in sync.\n")
    }
    cat('Updating packages...\n')
    update.packages(ask=FALSE)
  }
  
  
  library(fortunes)
  .First <- function() {

    cat("   Welcome to R!\n")
    
    to.install <- get.nonsynced.packages()
    if (length(to.install)>0)
    {
      cat('\nPACKAGES NOT SYNCED... Think about running sync.packages()\n')
      cat('   MISSING:',paste(to.install,collapse=','),'\n')
    }
    print(fortune())
  }
  .Last <- function() {
    remove.manipulate <- function(x) {
        m <- match('manipulate',x)
        if (!is.na(m))
          x <- x[-m]
        x
      }
    load('~/Dropbox/Library/.Rpackages.Rdata')
    pkgs <- remove.manipulate(pkgs)
    me.pkgs <- rownames(utils::installed.packages())
    me.pkgs <- remove.manipulate(me.pkgs)
    shared <- intersect(pkgs,me.pkgs)
    to.install <- pkgs[match(pkgs,shared,nomatch=0)==0]
    pkgs <- c(shared,to.install)
    save(pkgs,file='~/Dropbox/Library/.Rpackages.Rdata')
    cat("\n   Goodbye!\n")
    print(fortune())
  }
}

