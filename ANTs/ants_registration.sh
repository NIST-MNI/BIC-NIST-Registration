#! /bin/bash

if [ -z $2 ];then
 echo "Usage $0 input.mnc output_prefix"
 exit 1
fi

if [ -z $RAMDISK ];then
export RAMDISK=$SLURM_TMPDIR
fi

in=$1
out_xfm=$2.xfm
out_qc=$2.qc.jpg
name=$(basename $in .mnc)

ref=models/icbm152_model_09c/mni_icbm152_t1_tal_nlin_sym_09c_outline.mnc
model=models/icbm152_model_09c/mni_icbm152_t1_tal_nlin_sym_09c.mnc

f=$in
m=$model

its=1000x1000x1000
percentage=0.3
syn="100x100x50,-0.01,5"
mysetting=forproduction

out=$out_xfm

antsRegistration -d 3 -r [ $f, $m ,1]  \
                        -m mattes[  $f, $m , 1 , 32, regular, $percentage ] \
                         -t translation[ 0.1 ] \
                         -c [$its,1.e-8,20]  \
                        -s 4x2x1vox  \
                        -f 6x4x2 -l 1 \
                        -m mattes[  $f, $m , 1 , 32, regular, $percentage ] \
                         -t rigid[ 0.1 ] \
                         -c [$its,1.e-8,20]  \
                        -s 4x2x1vox  \
                        -f 3x2x1 -l 1 \
                        -m mattes[  $f, $m , 1 , 32, regular, $percentage ] \
                         -t affine[ 0.1 ] \
                         -c [$its,1.e-8,20]  \
                        -s 4x2x1vox  \
                        -f 3x2x1 -l 1 \
                        -z 1 \
                        -v 0 \
                        --minc \
                        -o $RAMDISK/out

mv $RAMDISK/out0_GenericAffine.xfm $out_xfm

itk_resample --like $ref $in --transform $out_xfm $RAMDISK/$name.mnc
minc_qc.pl   --big $RAMDISK/$name.mnc --mask $ref $out_qc
./minc_aqc.pl $RAMDISK/$name.mnc $2.aqc
