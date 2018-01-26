# Scripts for BIC-NIST registration paper

* [minc-toolkit-v2](http://bic-mni.github.io/), version 1.9.15 was used for running all minc-related experiments 
* All experiments have been run on [McGill HPC cluster](http://www.hpc.mcgill.ca/)
* `BestLinReg`,  `MRITOTAL`, and `Elastix` have been run using [ipl_preprocess_pipeline.py](https://github.com/vfonov/nist_mni_pipelines)  All preprocessing and segmentation options of the pipeline have been set to null (see the .json files), therefore only the specified registrations are executed.
* `Revised BestLinReg` was run using standalone script 'bestlinreg_claude'
* `ANTs` was run using modified script from ANTs distribution: <https://github.com/ANTsX/ANTs/blob/master/Scripts/newAntsExample.sh>
* All experiments used [ICBM 2009a Nonlinear Symmetric template](http://nist.mni.mcgill.ca/?p=904) for registration target

