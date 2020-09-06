

Installying Jupyter Notebook and using R with it
================================================

singularity exec DIOS_demonstration_latest.sif /opt/conda/bin/jupyter lab 

Open browser and point URL to the path shown by command above.
eg: http://localhost:8888/lab 

or, to run it on terminal non-interactively:

singularity exec DIOS_demonstration_latest.sif /opt/conda/bin/jupyter nbconvert --execute DIOS.ipynb  2>&1 | tee jupyter.out

# if above doesn't work, convert to .py first (it is really an R script)
# and invoke Rscript to execute the resulting .py file.  Kludgy in that regard, but works more reliably than above

singularity exec DIOS_demonstration_latest.sif /opt/conda/bin/jupyter nbconvert --to python jupyter_R_DIOS_demo.ipynb
singularity exec DIOS_demonstration_latest.sif /usr/bin/Rscript  ./jupyter_R_DIOS_demo.py  2>&1 | tee output.log

strange, even inside xterm of VNC, below didn't work.  page is just blank.  Viz may have some strange port mangling setup?
singularity exec DIOS_demonstration_latest.sif /opt/conda/bin/jupyter lab 

beppic2 is still centos6 and so got kernel too old when trying to run the container.

Alternative container with jupyter
----------------------------------

Attempt to use on viz.brc.berkeley.edu :
singularity exec DIOS_demonstration_latest.sif /opt/conda/bin/jupyter lab --no-browser --port=5999 --ip=10.0.0.25
XX http://viz.brc.berkeley.edu:5999/lab ## blocked by network firewall
XX ssh -D 5999 viz.brc.berkeley.edu  ## Nope, TCP forward not allowed 
Only VNC would load page, but login still get stuck :/



bofh:
no singularity 3 yet, so using docker
need to use --ip=0.0.0.0 # cuz docker won't let it bind to 127.0.0.1
cd  ~/tin-gh/DIOS_demonstration
sudo docker run -p 5999:5999 -v "$PWD":/mnt -it --entrypoint=/opt/conda/bin/jupyter  tin6150/r4envids lab --allow-root  --no-browser --port=5999 --ip=0.0.0.0

http://bofh.lbl.gov:5999
login with token 

but only python kernel... 
docker exec -it eloquent_gates bash
docker exec -it eloquent_gates /opt/conda/bin/jupyter  kernelspec list   # show avail kernels


docker 
podman run  -it --entrypoint=/opt/conda/bin/jupyter  tin6150/r4envids lab --allow-root 



Install notes
-------------

Need to install IRkernel and point Jupyter server to where this kernel is installed.
see: https://tin6150.github.io/psg/R.html#jupyter
