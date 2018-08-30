% This is the configuration template file for group analysis
% More information can be found in the HELP section below
% _________________________________________________________________________
% 2009-2010 Stanford Cognitive and Systems Neuroscience Laboratory
%
% $Id: groupstats_config.m.template 2010-01-02 $
% Yuan Zhang, 2018-02-10,  edited for better compatibility with vsochat
% -------------------------------------------------------------------------

%-Please specify parallel or nonparallel
%-e.g. for individualstats, set to 1 (parallel)
%-for groupstats, set to 0 (nonparallel)
paralist.parallel = '0';

%-Please specify file name holding subjects to be analyzed
% For two group stats, specify two subject list files. For eg.,
% {'group1.csv', 'group2.csv'}.
paralist.subjlist_file = {'/oak/stanford/groups/menon/projects/yuanzh/Yuan_PNC/data/subjectlist/subjs_PNC_gp1.csv','/oak/stanford/groups/menon/projects/yuanzh/Yuan_PNC/data/subjectlist/subjs_PNC_gp2.csv'};  

%-Please specify project directory
paralist.projectdir = '/oak/stanford/groups/menon/projects/yuanzh/Yuan_PNC';

%-Please specify the individualstats folder path
paralist.stats_folder  = 'EI_D55';

% Plese specify the folder path to put analysis results
paralist.output_folder = 'groupstats_2gp_test_pipeline';

% Please specify the file holding regressors
% If there is no regressor, comment the first line and uncomment the second
% line
%paralist.reg_file = {'age_pnc_25s.txt','sex_pnc_25s.txt','race_pnc_25s.txt','motion_pnc_25s.txt'};
paralist.reg_file = [''];


% Yuan added
%-Analysis type (e.g., glm, seedfc etc.)
paralist.analysis_type = 'glm';
%-Data type (i.e., restfmri or taskfmri)
paralist.fmri_type = 'taskfmri';

% fMRI parameters
%-spm8 batch templates location
paralist.template_path = '/oak/stanford/groups/menon/scsnlscripts_vsochat/fmri/spm/spm8/analysis/batchtemplates';
%-SPM version
paralist.spmversion = 'spm8';

% =========================================================================
% HELP on Configuration Setup
% =========================================================================
%
% -------------------------- PARAMETER LIST -------------------------------
%                     
% subjlist_file: 
% Name of the text file containing the list of subjects. It is assumed that
% file exists in one of the Matlab search paths. If only one list is
% present, you are using one group analysis. If two lists are present, you
% are using two group analysis. 
%
% stats_folder: 
% Stats folder name. e.g., 'stats_spm5_arabic'.
%
% output_folder: 
% Folder where the group stats outputs is saved.
%
% reg_file: 
% The .txt file containing the covariate of interest. Could be multiple files
% e.g.  {'regressor1.txt','regressor2.txt', ...}
% 
% template_path:
% The folder path holding template batches. Normally, the path is set
% default. You should NOT change it unless your analysis configuration
% parameters are differet from template. Please use the Matlab batch GUI to
% generate your own batch file and put it in your own folder. The batch
% file name should ALWAYS be 'batch_1group' for one group analysis and
% 'batch_2group' for two group analysis.
%
% =========================================================================
