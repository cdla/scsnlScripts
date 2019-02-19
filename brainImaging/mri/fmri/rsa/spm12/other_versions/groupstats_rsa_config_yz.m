% This is the configuration template file for group analysis
% More information can be found in the HELP section below
% _________________________________________________________________________
% 2009-2010 Stanford Cognitive and Systems Neuroscience Laboratory
%
% $Id: tianwen Chen  groupstats_config.m.template 2010-01-02 $

% -------------------------------------------------------------------------

% /oak/stanford/groups/menon /Users/yuanzh/Desktop/Sherlock

%-Please specify parallel or nonparallel
%-e.g. for individualstats, set to 1 (parallel)
%-for groupstats, set to 0 (nonparallel)
paralist.parallel = '0';

%-Please specify the full file path to the csv holding subjects to be analyzed
% For two group stats, specify two subject list file paths. I.e.
% {'group1.csv', 'group2.csv'}.
paralist.subjlist_file = {'/oak/stanford/groups/menon/projects/shelbyka/2017_TD_MD_mathfun/data/subjectlist/september2018/group_21TD_pre.csv'};
%{'/oak/stanford/groups/menon/projects/shelbyka/2017_TD_MD_mathfun/data/subjectlist/september2018/group_21TD_pre.csv', ...
%    '/oak/stanford/groups/menon/projects/shelbyka/2017_TD_MD_mathfun/data/subjectlist/september2018/group_21TD_post.csv'};  


%---- csv file example ----
%- PID, visit, session
%- 7014, 1 ,1

%-Please specify project directory
paralist.projectdir = '/oak/stanford/groups/menon/projects/shelbyka/2017_TD_MD_mathfun';

%-Please specify the folder name containing individualstats results 
paralist.stats_folder  = '13_all_correct_vs_rest_comp_dot_VS_13_all_correct_vs_rest_comp_num';

% Plese specify the folder name to put the groupstats analysis results
paralist.output_folder = 'rsa_dot_vs_num_pre_vs_post_TD';

% Please specify the file holding regressors
% If there is no regressor, comment the first line and uncomment the second line

%paralist.reg_file = {'Anxiety.txt','Age.txt','Gender.txt'};
%paralist.reg_file = [];
paralist.reg_file = {'fluency_test_21.txt'};

%paralist.contrastNames
paralist.contrastNames = {'dot_vs_num','dot_vs_num_neg'};


% Yuan added
%-Analysis type (e.g., glm, seedfc etc.)
paralist.analysis_type = 'rsa';

%-Data type (i.e., restfmri or taskfmri)
paralist.fmri_type = 'taskfmri';

% fMRI parameters
%-spm8 batch templates location
paralist.template_path = '/oak/stanford/groups/menon/scsnlscripts/brainImaging/mri/fmri/glmActivation/groupStats/spm12/batchtemplates/'; %'/oak/stanford/groups/menon/scsnlscripts_vsochat/fmri/spm/spm8/analysis/batchtemplates';

%-SPM version
paralist.spmversion = 'spm12';

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
