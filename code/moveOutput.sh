
# move output of run to a dir to save it.
# run as ./moveOutput.sh newDirName


##OutDir=RUN_desc_time

OutDir=$1
mkdir $OutDir

cp -p RUNinfo.rst $OutDir
mv Rplots*pdf* $OutDir
mv log.txt $OutDir
mv log3.simAnneal.txt $OutDir
mv *log* $OutDir


echo scp -r tin@dtn.brc.berkeley.edu:$(pwd)/$OutDir ~/Downloads
