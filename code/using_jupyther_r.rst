

Installying Jupyter Notebook and using R with it
================================================

singularity exec DIOS_demonstration_latest.sif /opt/conda/bin/jupyter lab 

docker 
podman run  -it --entrypoint=/opt/conda/bin/jupyter  tin6150/r4envids lab --allow-root 


Open browser and point URL to the path shown by command above.
eg: http://localhost:8888/lab 


or, to run it non interactively:


singularity exec DIOS_demonstration_latest.sif /opt/conda/bin/jupyter nbconvert --execute DIOS.ipynb  2>&1 | tee jupyter.out

# if above doesn't work, convert to .py first (it is really an R script)
# and invoke Rscript to execute the resulting .py file.  Kludgy in that regard, but works more reliably than above

singularity exec DIOS_demonstration_latest.sif /opt/conda/bin/jupyter nbconvert --to python jupyter_R_DIOS_demo.ipynb
singularity exec DIOS_demonstration_latest.sif /usr/bin/Rscript  ./jupyter_R_DIOS_demo.py  2>&1 | tee output.log





Install notes
-------------

Need to install IRkernel and point Jupyter server to where this kernel is installed.
see: https://tin6150.github.io/psg/R.html#jupyter
