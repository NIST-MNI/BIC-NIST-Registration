#! /bin/bash

if [ -z $2 ];then
 echo "Usage $0 input.mnc output_prefix"
 exit 1
fi

if [ -z $RAMDISK ];then
export RAMDISK=/tmp
fi

in=$1
out_xfm=$2.xfm
out_mat=$2.mat

out_qc=$2.qc.jpg
name=$(basename $in .mnc)

source $FSLDIR/etc/fslconf/fsl.sh
export PATH=$FSLDIR/bin:$PATH

ref=models/icbm152_model_09c/mni_icbm152_t1_tal_nlin_sym_09c_outline.mnc
model=models/icbm152_model_09c/mni_icbm152_t1_tal_nlin_sym_09c.mnc
model_nifti=models/icbm152_model_09c_nii/mni_icbm152_t1_tal_nlin_sym_09c.nii.gz

mnc2nii $in $RAMDISK/in.nii

flirt -in $RAMDISK/in.nii -ref $model_nifti -omat $out_mat -dof 9
flirt -in $RAMDISK/in.nii -ref $model_nifti -init $out_mat -out $RAMDISK/name

nii2mnc $RAMDISK/name.nii $RAMDISK/name.mnc
minc_qc.pl --big $RAMDISK/name.mnc --mask $ref $out_qc
