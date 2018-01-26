#! /bin/bash

if [ -z $2 ];then
 echo "Usage $0 input.mnc output_prefix"
 exit 1
fi

# export PATH=$PATH:/software/CentOS-6/applications/matlab-2016a/bin

if [ -z $RAMDISK ];then
export RAMDISK=/tmp
fi

in=$1
out_xfm=$2.xfm
out_qc=$2.qc.jpg
name=$(basename $in .mnc)


ref=/gs/project/ypr-381-aa/vfonov/data/models/icbm152_model_09c/mni_icbm152_t1_tal_nlin_sym_09c_outline.mnc
model=/gs/project/ypr-381-aa/vfonov/data/models/icbm152_model_09c/mni_icbm152_t1_tal_nlin_sym_09c.mnc
#matlab -nodisplay  <<END
#path(path,'/gs/project/ypr-381-aa/vfonov/data/registration/manifolds')
#graph_registration('$in','$out_xfm')
#END

bestlinreg_claude.pl $in $model -lsq9 -nmi $out_xfm
itk_resample --like $ref $in --transform $out_xfm $RAMDISK/name.mnc
minc_qc.pl --big $RAMDISK/name.mnc --mask $ref $out_qc

