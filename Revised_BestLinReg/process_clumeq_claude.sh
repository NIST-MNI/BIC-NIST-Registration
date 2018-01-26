#! /bin/sh

#PBS -l procs=1
#PBS -l pmem=2700m
#PBS -l walltime=4:00:00
#PBS -A ypr-381-aa
#PBS -j oe
#PBS -V

if [ ! -z $PBS_O_WORKDIR ];then
cd $PBS_O_WORKDIR
fi

export ITK_GLOBAL_DEFAULT_NUMBER_OF_THREADS=1
export OMP_NUM_THREADS=1

mkdir -p pp_claude/${cohort}/${subject}/${visit}/tal

./claude_registration.sh $t1w \
  pp_claude/${cohort}/${subject}/${visit}/tal/tal_${subject}_${visit}

