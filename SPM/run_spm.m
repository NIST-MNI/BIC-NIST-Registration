clear all
clc
addpath(genpath('Registration_Experiments/spm12/'))
Info=readtable('All_Info.csv');
VG=spm_vol('icbm_template.nii')

for i=1:size(Info,1) 
    system(cell2mat(strcat('mnc2nii',{' '},Info.A(i),{' '},'tmp/',Info.S(i),'_',Info.V(i),'.nii')));
    VF=spm_vol(cell2mat(strcat('tmp/',Info.S(i),'_',Info.V(i),'.nii')));
    system(cell2mat(strcat('cp tmp/',Info.S(i),'_',Info.V(i),'.nii tmp/',Info.S(i),'_',Info.V(i),'_ns.nii ')));
    spm_smooth(VF,cell2mat(strcat('tmp/',Info.S(i),'_',Info.V(i),'.nii')),[12 12 12]);
    spm_smooth(VG,'icbm.nii',[12 12 12]);
    M = spm_affreg(VG,VF);
    VF=spm_vol(cell2mat(strcat('tmp/',Info.S(i),'_',Info.V(i),'_ns.nii')));
    VF.mat = M*VF.mat;
    spm_reslice([VG,VF],struct('which',1));
    system(cell2mat(strcat('nii2mnc',{' '},'tmp/r',Info.S(i),'_',Info.V(i),'_ns.nii',{' '},'tmp/',Info.S(i),'_',Info.V(i),'.mnc')));
    system(cell2mat(strcat('mincresample -nearest -like models/icbm152_model_09c/mni_icbm152_t1_tal_nlin_asym_09c_outline.mnc',...
        {' '},'tmp/',Info.S(i),'_',Info.V(i),'.mnc',{' '},'tmp/',Info.S(i),'_',Info.V(i),'_2.mnc')));
    system(cell2mat(strcat('minc_qc.pl --mask models/icbm152_model_09c/mni_icbm152_t1_tal_nlin_asym_09c_outline.mnc --big',...
        {' '},'tmp/',Info.S(i),'_',Info.V(i),'_2.mnc',{' '},'QC_Files/',Info.S(i),'_',Info.V(i),'.jpg -clobber')));
    system(cell2mat(strcat('rm',{' '},'tmp/*',Info.S(i),'_',Info.V(i),'*')));
end

   