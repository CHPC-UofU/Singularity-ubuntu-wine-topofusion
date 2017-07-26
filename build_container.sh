prg=windows_topofusion
#os=fedora
os=ubuntu
rm -f ${os}_${prg}.img
rm ~/WINE/Topofusion/wineprefix.tgz 
sudo /uufs/chpc.utah.edu/sys/installdir/singularity/2.3.1/bin/singularity create --size 2500 ${os}_${prg}.img
sudo /uufs/chpc.utah.edu/sys/installdir/singularity/2.3.1/bin/singularity bootstrap ${os}_${prg}.img Singularity
