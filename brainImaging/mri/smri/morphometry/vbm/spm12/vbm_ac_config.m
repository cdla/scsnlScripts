%-Configfile for vbm_ac.m
%__________________________________________________________________________

%-SPM version
paralist.spmversion = 'spm12';

%-Please specify parallel or nonparallel
%-e.g. for preprocessing and individualstats, set to 1 (parallel)
%-for groupstats, set to 0 (nonparallel)
paralist.parallel = '0';

%-Subject list (full path to the csv file)
paralist.subjectlist = 'spgrsubjectlist.csv';
%---- example ----
%- PID, visit, session, spgrfilename
%- 7014, 1 ,1 , spgr

%- List of smri images 
% (no .nii or .img extensions)
% i.e.--> 
%      spgr (name of spgr file for the 1st subject in paralist.subjectlist)
%	   spgr (name of spgr file for the 2nd subject in paralist.subjectlist)
%	   spgr (name of spgr file for the 3rd subject in paralist.subjectlist)
%	   spgr_1 (name of spgr file for the 4th subject in paralist.subjectlist)
%      ....

% I/O parameters
% - Raw data directory
paralist.rawdatadir = '/oak/stanford/groups/menon/rawdata/scsnl/';

% - Project directory - output of the preprocessing will be saved in the
% data/imaging folder of the project directory
paralist.projectdir = '/oak/stanford/groups/menon/projects/ruiyuan/rui/shelbyka/2017_TD_MD_mathfun/';

% 

