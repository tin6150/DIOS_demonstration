#!/bin/bash 
# simple bash script to install libraries for R
# can be called by container builder (docker, singularity) or 
# a user's desktop env


# do not place TAB between package name and repos, 
# ie no TAB inside packages(...)
# when this is executed as bash script the tab is passed verbatim and Rscript can't handle it.  extra space padding is ok.
Rscript --quiet --no-readline --slave -e 'install.packages("ggplot2", repos = "http://cran.us.r-project.org")'
Rscript --quiet --no-readline --slave -e 'install.packages("raster", repos = "http://cran.us.r-project.org")'
Rscript --quiet --no-readline --slave -e 'install.packages("mvnfast", repos = "http://cran.us.r-project.org")'
Rscript --quiet --no-readline --slave -e 'install.packages("gstat", repos = "http://cran.us.r-project.org")'
Rscript --quiet --no-readline --slave -e 'install.packages("cowplot", repos = "http://cran.us.r-project.org")'
Rscript --quiet --no-readline --slave -e 'install.packages("geoR", repos = "http://cran.us.r-project.org")'
Rscript --quiet --no-readline --slave -e 'install.packages("foreach", repos = "http://cran.us.r-project.org")'
Rscript --quiet --no-readline --slave -e 'install.packages("doParallel", repos = "http://cran.us.r-project.org")'
Rscript --quiet --no-readline --slave -e 'install.packages("tidyverse", repos = "http://cran.us.r-project.org")'
Rscript --quiet --no-readline --slave -e 'install.packages("rPref", repos = "http://cran.us.r-project.org")'
Rscript --quiet --no-readline --slave -e 'install.packages("RColorBrewer", repos = "http://cran.us.r-project.org")'


# tin's addition
Rscript --quiet --no-readline --slave -e 'install.packages(c("tidycensus", "rstudioapi", "data.table", "tigris"), repos = "http://cran.us.r-project.org")'

Rscript --quiet --no-readline --slave -e 'library()'   | sort | tee R_library.out


# vim: noexpandtab nosmarttab noautoindent nosmartindent tabstop=4 shiftwidth=4 paste formatoptions-=cro
