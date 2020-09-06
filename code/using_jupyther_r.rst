

Installying Jupyter Notebook and using R with it
================================================

singularity exec DIOS_demonstration_latest.sif /opt/conda/bin/jupyter lab 

docker 
podman run  -it --entrypoint=/opt/conda/bin/jupyter  tin6150/r4envids lab --allow-root 


Open browser and point URL to the path shown by command above.
eg: http://localhost:8888/lab 


Install notes
-------------

Need to install IRkernel and point Jupyter server to where this kernel is installed.
see: https://tin6150.github.io/psg/R.html#jupyter
