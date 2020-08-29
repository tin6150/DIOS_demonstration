

Tried to run rstudio using R from container, so it get the lib
But no luck.  rstudio need lot of stuff interactively with R

    Example run with R Studio (with singularity image named as "R"):
	PATH=.:${PATH} rstudio
	PATH=.:{$PATH} && R_HOME=. &&  rstudio
	Neither work :-\ Get ERROR: R did not return any output when queried for directory location information; Unable to determine R home directory


So, may still best be to try to use the rstudio that is also inside the container.  
Resolving X would be the trick there.
