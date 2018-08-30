function timeseries_preextract(P)% This script will pre-extract the timecourses from the data to speed up% the process% Parameter Structure/File Containing Parameter Structure with the following fields:%      subject: the subject number%    directory: either the first-level SPM.mat directory, or if you are%               only estimating a PPI model, then the first-level PPI%               directory.%          VOIs: name of VOI file ('.nii', '.img', '.mat'). Checks for%               file before executing program. If you use a .mat file,%               it should be 3 columns containing the ijk voxel%               indices OR be a VOI.mat file from SPM.%               **This can also be a structure. If it is a structure, there%               are three/four fields:%       Region: name of output file(s), reqires two names for analysis%               with two VOI, regions should be separated by a space%               inside the ' '. Output directory will be Region. (if 2 regions,%               then the two regions will be separated by a _ in the directory name.%     contrast: contrast to adjust for. Adjustments remove the effect %               of the null space of the contrast. Set to 0 for no adjustment. Set to a%               number, if you know the contrast number. Set to a contrast name, if you%               know the name. The default is: 'Omnibus F-test for PPI Analyses'.% % Written by Donald G McLaren, PhD on April 1, 2014 -- BETA VERSION%   GRECC, Bedford VAMC%   Department of Neurology, Massachusetts General Hospital and Havard%   Medical School%%   License: This m-file is ditributed under the GNU General Public Licence as published by the%   Free Software Foundation (either version 2, as given in file%   spm_LICENCE.man, available in the SPM download) as a derivative work; %   however, m-file dependencies - developed separately -- may have their own license. %   See specific m-file for the license.%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%toolboxdir=fileparts(which('PPPI'));addpath(toolboxdir);%%ind= find(toolboxdir == filesep);if max(ind)==numel(toolboxdir)    addpath(toolboxdir(1:ind(end-1)-1));else    addpath(toolboxdir(1:ind(end)-1));end%% Input Parser -- Will create variables for the specified options%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%if ~strcmp(spm('Ver'),'SPM8')    disp('PROGRAM ABORTED:')    disp('  You must use SPM8 to process your data; however, you can use SPM.mat files')    disp('  generated with SPM2 or SPM5. In these cases, simply specify the option SPMver')    disp('  in single qoutes followed by a comma and the version number.')    disp(' ')    disp('Make sure to add SPM8 to your MATLAB path before re-running.')    returnenderrorvals={};try    P.subject=P.subject;catch    errorvals{end+1}='Program will exit. Subject is not specified.';endif exist('P','var') && isfield(P,'subject') && ~ischar(P.subject);    errorvals{end+1}='Program will exit. Subject must be a string.';end%Check SPM directorytry    if isempty(P.directory)        invokecatchstatement    end    if exist([P.directory filesep 'SPM.mat'],'file')~=2        errorvals{end+1}='Program will exit. Directory is incorrect or does not contain an SPM.mat file.';        SPM.swd=pwd;        SPMexist=0;    else        SPMexist=1;        load([P.directory filesep 'SPM.mat']);    endcatch    SPMexist=0;    errorvals{end+1}='Program will exit. Directory is not specified.';end%Check for zipping filestry    if ~isnumeric(P.zipfiles) || P.zipfiles~=1        P.zipfiles=0;    endcatch    P.zipfiles=0;end%Check if contrast adjustment is present. Defaults to omnibus.errorval={};try    if (~iscellstr(P.contrast) && ~isnumeric(P.contrast)) || isempty(P.contrast)        P.contrast={'Omnibus F-test for PPI Analyses'};    endcatch    P.contrast={'Omnibus F-test for PPI Analyses'};endif isnumeric(P.contrast) && P.contrast==0    disp('     Contrast          : No adjustment')elseif isnumeric(P.contrast) && P.contrast<=length(SPM.xCon)    disp(['     Contrast          : ' SPM.xCon(P.contrast).name])    P.contrast=P.contrast;elseif isnumeric(P.contrast) && P.contrast>length(SPM.xCon)    errorval=['Program will exit. Your contrast: ' num2str(P.contrast) ' does not exist.'];    returnelse    if iscellstr(P.contrast)        match=0;        for i=1:length(SPM.xCon)            if strcmp(P.contrast,SPM.xCon(i).name)                disp(['     Contrast          : ' SPM.xCon(i).name])                P.contrast=i;                match=1;                break;            end        end        if ~match            for i=1:length(SPM.xCon)                if strcmpi('Omnibus F-test for PPI Analyses',SPM.xCon(i).name)                    disp(['     Contrast          : ' SPM.xCon(i).name])                    P.contrast=i;                    match=1;                    break;                end            end        end        if ~match            try                P.contrast=defContrasts(SPM,0,-1);                xCon = spm_FcUtil('Set',P.contrast.name,P.contrast.STAT,'c',P.contrast.c,SPM.xX.xKXs);                init=length(SPM.xCon);                if init~=0                    SPM.xCon(init+1) = xCon;                elseif init==0                    SPM.xCon = xCon;                else                    triggercatchstatement                end                SPM = spm_contrasts(SPM,init+1);                P.contrast=init+1;                disp(['     Contrast          : ' SPM.xCon(P.contrast).name])            catch                errorval='Program will exit. Contrast cannot be defined.';                return;            end        end    else        errorval='Program will exit. This should not be possible.';        return;    endendif ~isempty(errorval) || ~isempty(errorvals)    disp('One or more inputs are not correct.')    for ee=1:numel(errorval)        disp(['ERROR ' num2str(ee) ':' errorval{ee}])    end    for ee=1:numel(errorvals)        disp(['ERROR ' num2str(ee) ':' errorval{ee}])    end    disp('errorvals saved to errorvals.mat')    save errorvals errorvals errorval    return;else    cd(P.directory)    try        [path structfile ext]=fileparts(structfile);        if isempty(path)            path=pwd;        end        save([pwd filesep P.subject '_preextract_PPI_structure_ ' date '.mat'],'P');    endend%% Check for zipped files.try    load SPM.mat    for ii=1:numel(SPM.xY.VY)        a{ii}=SPM.xY.VY(ii).fname;    end    a=unique(a);    filesgz={}; filesbz={};    for ii=1:numel(a)        if ~exist(a{ii},'file')            if exist([a{ii} '.gz'],'file')==2                try                    system(sprintf('gunzip -c %s',[a{ii} '.gz']))                    filesgz{end+1}=a{ii};                catch                    if usejava('jvm')                        try                            gunzip([a{ii} '.gz']);                            filesgz{end+1}=a{ii};                        catch                            if ~exist(a{ii},'file')                                disp('SPM.xY.VY points to the wrong locations OR files need to be manuallyunzipped, before processing.')                                error('gunzip is not a valid command in MATLAB or *NIX. OR, Files do not exist')                            end                        end                    else                        if ~exist(a{ii},'file')                            disp('SPM.xY.VY points to the wrong locations OR files need to be manuallyunzipped, before processing.')                            error('gunzip is not a valid command. This was setup for *NIX. OR, Files do not exist')                        end                    end                end            end        else            if isfield(P,'zipfiles') && isnumeric(P.zipfiles) && P.zipfiles==1                filesgz{end+1}=a{ii};            end        end        if ~exist(a{ii},'file')            error('SPM.xY.VY points to the wrong locations')        end    end    for ii=1:numel(a)        if ~exist(a{ii},'file')            if exist([a{ii} '.bz2'],'file')==2                try                    system(sprintf('bunzip2 %s',[a{ii} '.bz2']));                    filesbz{end+1}=a{ii};                catch                    error('bunzip2 is a valid command. This was setup for *NIX.')                end            end            if ~exist(a{ii},'file')==2                error('SPM.xY.VY points to the wrong locations')            end        else            if isfield(P,'zipfiles') && isnumeric(P.zipfiles) && P.zipfiles==1                filesgz{end+1}=a{ii};            end        end    endcatch    error('Checking for zipped files failed')end%% ProgramSessions=numel(SPM.Sess);D=extractTS(SPM.xY.VY,P.VOIs);B=extractTS(SPM.Vbeta,P.VOIs);%Begin Session Loop%==========================================================================fldnames=fieldnames(D);for ss=1:Sessions    for vois=1:numel(fldnames)        yy=D.(fldnames{vois}).allVox;        clear xY.y xY.yy xY.u xY.v xY.s xY.X0        xY.Sess=ss;        if ~isnumeric(P.contrast)            xY.Ic=str2double(P.contrast);        else            xY.Ic=P.contrast;        end        yy=spm_filter(SPM.xX.K,SPM.xX.W*yy);        beta=B.(fldnames{vois}).allVox;        if xY.Ic~=0            yy=yy-spm_FcUtil('Y0',SPM.xCon(xY.Ic),SPM.xX.xKXs,beta);        end        [xY,yy]=get_confounds(SPM,xY,yy);        [m n]   = size(yy);        if m > n            [v s v] = svd(yy'*yy);            s       = diag(s);            v       = v(:,1);            u       = yy*v/sqrt(s(1));        else            [u s u] = svd(yy*yy');            s       = diag(s);            u       = u(:,1);            v       = yy'*u/sqrt(s(1));        end        d       = sign(sum(v));        u       = u*d;        v       = v*d;        Y       = u*sqrt(s(1)/n);                % set in structure        %-----------------------------------------------------------------------        xY.y     = yy;        xY.yy    = transpose(mean(transpose(yy))); %average (not in spm_regions)        xY.u    = Y; %eigenvariate        xY.v    = v;        xY.s    = s;        save([P.subject '_session' num2str(ss) '_' fldnames{vois} '.mat'],'xY', '-v6')        clear xY beta y d u v Y s    endendtry    zipfiles(filesgz,filesbz)catchendend%% Check for zipped files.function zipfiles(filesgz,filesbz)try    if ~isempty(filesgz)        for ii=1:numel(filesgz)            try                 if exist([filesgz{ii} '.gz'],'file')                    delete(filesgz{ii});                else                    system(sprintf('gzip %s',filesgz{ii}));                end            catch                if usejava('jvm')                    try                        gzip(filesgz{ii})                    catch                        break                    end                else                    break                end            end        end    end    if ~isempty(filesbz)        for ii=1:numel(filesbz)            try                system(sprintf('bzip2 %s',filesbz{ii}));            catch                break            end        end    endcatch   error('Zipping files failed') endendfunction [M h ind] = FastRead(fn,msk)% Alternative tool for reading in NIFTI data.  Seems to perform a little% better than openIMG.m%% Written by Aaron Schultz (aschultz@martinos.org)%% Last Updated Dec. 11 2012;%% Copyright (C) 2012,  Aaron P. Schultz%% Supported in part by the NIH funded Harvard Aging Brain Study (P01AG036694) and NIH R01-AG027435 %% This program is free software: you can redistribute it and/or modify% it under the terms of the GNU General Public License as published by% the Free Software Foundation, either version 3 of the License, or% any later version.% % This program is distributed in the hope that it will be useful,% but WITHOUT ANY WARRANTY; without even the implied warranty of% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the% GNU General Public License for more details.if isstruct(fn)    h = fn;else    h = spm_vol(char(fn));endif mean(mean(std(reshape([h.mat],4,4,numel(h)),[],3)))~=0    error('Images are not all the same orientation');endI.v = h(1);FullIndex = 1:prod(I.v.dim);if nargin > 1    if ischar(msk)        mh = spm_vol(msk);        mask = resizeVol(mh,h(1));        FullIndex = find(mask==1);    else        FullIndex = msk;    endend[x y z] = ind2sub(I.v.dim,FullIndex);M = zeros(numel(h),numel(x));persisText();for ii = 1:numel(h);    persisText([num2str(ii) ' of ' num2str(numel(h))]);    M(ii,:) = spm_sample_vol(h(ii),x,y,z,0);endpersisText();% toc% tic% m = openIMG(fn);% m = reshapeWholeBrain(size(m),m);% tocendfunction D = extractTS(fn, seeds)%  Extract a time series from a 4D Nifti file.%% INPUTS:% fn:     Path to 4D nifti file.% seeds:  Cell Array of Inputs { {'Label1' [mni coords] [seed diameter]} ...}% opt:    If opt = 1, the time series will be extracted.%         If opt = 0, only the matrix indcies of the seed will be%         computed.%% OUTPUTS% D.fn =  A new filename based on the location and size of the seed.% D.vox_loc = location of the seed in 3D matrix coordinates.% D.vec_loc = location of the seed in vector coordinates.% D.ts =  The time series as computed by the first eigen vector method.% D.tsm = The time series as computed by a simple mean of the values in% the seed at each time point.%% Example: %    extractTS(rsscan{1}, { ...%         {'PCC'  [  0 -53  26] [8]} ...%         {'mPFC' [  0  52 -06] [8]} ...%         {'lLPC' [-48 -62  36] [8]} ...%         {'LRPC' [ 46 -62  32] [8]} ...%         });%% Written by Aaron Schultz (aschultz@martinos.org)%% Last Updated Dec. 11 2012;%% Copyright (C) 2012,  Aaron P. Schultz%% Supported in part by the NIH funded Harvard Aging Brain Study (P01AG036694) and NIH R01-AG027435 %% This program is free software: you can redistribute it and/or modify% it under the terms of the GNU General Public License as published by% the Free Software Foundation, either version 3 of the License, or% any later version.% % This program is distributed in the hope that it will be useful,% but WITHOUT ANY WARRANTY; without even the implied warranty of% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the% GNU General Public License for more details.%% Modifie by Donald McLaren, PhD (mclaren.donald@gmail.com) on 4/1/2014% for timeseries_preextract.m for gPPI Toolboxif nargin == 2    opt = 1;endif isstruct(fn)    V1 = fn;else    V1 = spm_vol(fn);end[tmp XYZmm] = spm_read_vols(V1(1));if opt == 1        if numel(fn)==1 && exist([fileparts(fn) '/ExtraRegressors.mat'],'file')>0        load([fileparts(fn) '/ExtraRegressors.mat']);        [row, col] = find(R==1);        ind = setdiff(1:numel(V1),row);    else        ind = 1:numel(V1);    end    M2 = FastRead(V1(ind));endfor zz = 1:length(seeds)    if isnumeric(seeds{zz}{2});        rad = seeds{zz}{3}/2;        dist = sqrt(sum((XYZmm' - repmat(seeds{zz}{2},size(XYZmm,2),1)).^2,2));        ind = find(dist <= rad);        if numel(ind)==0;            ind = find(dist==min(dist));        end        D.(seeds{zz}{1}).fn = ['Mask_' num2str(seeds{zz}{3}) 'mm_' num2str(seeds{zz}{2}(1)) '_' num2str(seeds{zz}{2}(2)) '_' num2str(seeds{zz}{2}(3)) '.nii'];    elseif ischar(seeds{zz}{2});        h = spm_vol(seeds{zz}{2});        mi = resizeVol(h,V1(1));        ind = find(mi==1);        [aa1 aa2] = fileparts(seeds{zz}{2});        D.(seeds{zz}{1}).fn = ['Mask_' aa2];    else        warning(['Seed #' num2str(ii) ' was not specified correctly.']);        continue    end        dd = XYZmm(:,ind)';    clear dd2;    [dd2(:,1) dd2(:,2) dd2(:,3)] = ind2sub(V1(1).dim,ind);        D.(seeds{zz}{1}).mni_loc = dd;    D.(seeds{zz}{1}).vox_loc = dd2;    D.(seeds{zz}{1}).vec_loc = ind;    D.(seeds{zz}{1}).ts = [];        if opt == 1        y = M2(:,ind);        y(:,all(isnan(y),1))=[]; %removes nan        D.(seeds{zz}{1}).tsm = mean(y,2);        D.(seeds{zz}{1}).allVox = y;        D.(seeds{zz}{1}).tsv = QuickSVD(y);    end endend