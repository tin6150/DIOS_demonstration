
## zin  zink       nahalem E5620 @ 2.40            2x4x2   32 GB   docker (traditional)
## bof             haswell-EP E5-1660 v3 @ 3.0     1x8x2   64 GB   docker (traditional)
## bgo             skylake Silv 4110 @ 2.1         2x8x2   64 GB   docker (traditional)
## hma             Skylake Silv 4110 @ 2.1         2x8x2   32 GB   sudo podman
## exp  explorer   ??   mint + c8 vm then podman ??


n0145 8rtx gpu node with bogus gpu 5128 2.3GHz 2x16

2020.0919
n0170.savio3 M66 RU 3-4 Gold 6230 2.1GHz 2x20 93G
n0173.savio3


~~~~

eventually, edit in jupyter, convert, run

singularity exec DIOS_demonstration_latest.sif /opt/conda/bin/jupyter nbconvert --to python jupyter_R_DIOS_demo.ipynb
singularity exec DIOS_demonstration_latest.sif /usr/bin/Rscript  ./jupyter_R_DIOS_demo.py  2>&1 | tee output.n170.0919.log


for now, just test on jupyter as doesn't take too too long.  learn the construct first...

jupyter instances 2020-0918: 
http://hima.lbl.gov:5999/  # some test, no need to commit
http://bofh.lbl.gov:5999/  # should commit this one, as have some benchmark info here


## Simulated Annealing next, which still about 3*15 = 45 min !!
## but cpu isn't all that busy...
## docker on bofh: start 12:04... end ~12:19.  so ~15 min.  load avg <1.  
## so not sure why takes so long!  capturing that long ass output to the notebook?
## tweaked simAnneal to double thread, took ~13 min

## bof     20min per chain. Total 52m    --  30/10//3 n.total/n.initial//n.real [15 thread]
## bgo    ~20min per chain. Total 65m    --  30/10//3 n.total/n.initial//n.real [31 thread]
## bof    ~15min per 3 chain. mcparalle  --  30/10//3 n.total/n.initial//n.real   //++ fix data combining...
## hma    ~21min per chain. Total 71m    --  30/10//3 n.total/n.initial//n.real [12 thread for SimAnneal, matching num of memory channel.  Ram use 3-8 GB]
## hma    ~23min per chain. Total 73m    --  30/10//3 n.total/n.initial//n.real [15,16,17 thread for SimAnneal]
## hma    ~25min per chain. Total 82m    --  30/10//3 n.total/n.initial//n.real [31 thread]
## hma    ~30min per chain. Total 100m   --  30/10//3 n.total/n.initial//n.real [63 thread]
## n170   ~11min per chain. Total 38m    --  30/10//3 n.total/n.initial//n.real [39 thread]
