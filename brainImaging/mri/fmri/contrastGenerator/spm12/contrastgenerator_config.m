%_This is the config file for Contrast_Generator.m

% %---mlsubmit parameters----
% %-Please specify parallel or nonparallel
% %-e.g. for individualstats, set to 1 (parallel)
% %-for groupstats, set to 0 (nonparallel)
paralist.parallel = '0';

% %-Please specify project directory
paralist.projectdir = '/oak/stanford/groups/menon/projects/shelbyka/2017_TD_MD_mathfun/'; 

% %-SPM version
paralist.spmversion =  'spm12';

%-----------------FILL OUT ALL THREE VARIABLES APPROPRIATLY----------
%How many Conditions do you have in a SINGLE session (should have same number of
%conditions in each session)? 
paralist.numcontrasts = 7;

%How many sessions/runs will this be looking at? Sessons must be SAME size.
paralist.numsessions = 1;

%If you want to compaire WITHIN sessions set variable to 1 else set
%variable to zero
paralist.comparewithin = 1;

%If you are running ArtRepair and do not want to have movement correction
%make the movement correction to 0, 
%If you do want to factor in movement components sent variable to 6
paralist.movementcorrection = 6;

%% Define your contrasts
% Make sure the even numbered contrasts are the opposite of the
% odd numbered contrasts. (i.e. all-rest; rest-all)

%-Specify the names of the contrasts:
paralist.contrastnames = {'math','music','emotion'};

% paralist.contrastnames = {'CC','CC_neg','CE','CE_neg','EC','EC_neg','EE','EE_neg','cashout','cashout_neg','pump_lose','pump_lose_neg','trash','trash_neg','CC-CE','CE-CC','CC-EC','EC-CC','CC-EE','EE-CC','CE-EC','EC-CE','CE-EE','EE-CE','EC-EE','EE-EC'};

% Contrasts defined in numbers, just based on your conditions. 
% There should be as many vectors as contrast names
% Each vector should be as long as the number of conditions.
% Each vector should sum to 0 unless contrasting with rest state
% If you named every other contrast the reverse of the previous one be sure to 
% do the same when making your contrast matrices

paralist.contrast{1} = [1 0 0 0 0 0 0]; %[c1 c2 c3 ...] according to order in task design
paralist.contrast{2} = [-1 0 0 0 0 0 0];
paralist.contrast{3} = [0 1 0 0 0 0 0];
paralist.contrast{4} = [0 -1 0 0 0 0 0];
paralist.contrast{5} = [0 0 1 0 0 0 0];
paralist.contrast{6} = [0 0 -1 0 0 0 0];
paralist.contrast{7} = [0 0 0 1 0 0 0];
paralist.contrast{8} = [0 0 0 -1 0 0 0];
paralist.contrast{9} = [0 0 0 0 1 0 0];
paralist.contrast{10} = [0 0 0 0 -1 0 0];
paralist.contrast{11} = [0 0 0 0 0 1 0];
paralist.contrast{12} = [0 0 0 0 0 -1 0];
paralist.contrast{13} = [0 0 0 0 0 0 1];
paralist.contrast{14} = [0 0 0 0 0 0 -1];
paralist.contrast{15} = [1 -1 0 0 0 0 0];
paralist.contrast{16} = [-1 1 0 0 0 0 0];
paralist.contrast{17} = [1 0 -1 0 0 0 0];
paralist.contrast{18} = [-1 0 1 0 0 0 0];
paralist.contrast{19} = [1 0 0 -1 0 0 0];
paralist.contrast{20} = [-1 0 0 1 0 0 0];
paralist.contrast{21} = [0 1 -1 0 0 0 0];
paralist.contrast{22} = [0 -1 1 0 0 0 0];
paralist.contrast{23} = [0 1 0 -1 0 0 0];
paralist.contrast{24} = [0 -1 0 1 0 0 0];
paralist.contrast{25} = [0 0 1 -1 0 0 0];
paralist.contrast{26} = [0 0 -1 1 0 0 0];

