

Installying Jupyter Notebook and using R with it
================================================

singularity exec DIOS_demonstration_latest.sif /opt/conda/bin/jupyter lab --allow-root

docker 
podman run  -it --entrypoint=/opt/conda/bin/jupyter  tin6150/r4envids lab --allow-root 



Install notes
-------------

IRkernel is R kernel for Jupyther Notebook.
In R:

install.packages('IRkernel')

see: https://tin6150.github.io/psg/R.html#jupyter
