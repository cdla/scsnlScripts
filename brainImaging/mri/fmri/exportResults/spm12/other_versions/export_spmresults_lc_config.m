% Configuration file for export_spmresults.m
%
% _________________________________________________________________________
% 2009-2010 Stanford Cognitive and Systems Neuroscience Laboratory
%
% $Id: export_spmresults_config.m.template 2010-06-26 $
% LC edited 2018-11-19
% -------------------------------------------------------------------------

%-Please specify parallel or nonparallel
%-e.g. for individualstats, set to 1 (parallel)
%-for groupstats, set to 0 (nonparallel)
paralist.parallel = '0';
%-Please specify project directory
paralist.projectdir = '/oak/stanford/groups/menon/projects/lchen32/2018_MathFUN_mindset/';

% Please specify the list of group stats folders
%single folder
paralist.stats_folder_path_list = 'glm';
%list of folder names in a text file
%paralist.stats_folder_path_list = 'groupstats_list.txt';


% Please specify the contrast folder name
%single folder
paralist.contrast_folder_list = 'Groupstats_SWAOR_spm12_Add1Add2_Pre_Post_Tut_SubgroupByTime';
%list of folder names in text file
%paralist.contrast_folder_list = 'contrast_list.txt';

% Please specify the contrast name: 1 = pos; 2 = neg
% paralist.contrast_index = 1;
% If want to look at all contrasts:
paralist.contrast_index = [];

%provide the full path of the folder holding all groupstats results (Note the different folder structures for tasfmri or restfmri
paralist.currentdir =  '/oak/stanford/groups/menon/projects/lchen32/2018_MathFUN_mindset/results/taskfmri/groupstats/';

% Please specify the mask file (full path), if no masking, leave as ''
paralist.mask_file = '/oak/stanford/groups/menon/scsnlscripts/brainImaging/mri/fmri/masks/vbm_grey_mask.nii';
% If no mask:
%paralist.mask_file = '';

% Please specify the correction method for multiple comparisons
% uncorrected: 'none'; family-wise: 'FWE'; false discovery: 'FDR'
paralist.multiple_correction = 'none';

% Please specify the p value
paralist.pval = 0.01;

% Please specify the spatial extent threshold (in voxels)
paralist.spatial_extent = 128;

% Please specify the group name for txt files
paralist.user_input = 'gray_mask';

% Please specify the number of local maxima to display
paralist.NumMax = 3;

% Please specify the distance between local maximas (in mm)
paralist.DisMax = 8;

%-SPM version, this only matters when you try to use group-averaged images as a mask
paralist.spmversion = 'spm12';