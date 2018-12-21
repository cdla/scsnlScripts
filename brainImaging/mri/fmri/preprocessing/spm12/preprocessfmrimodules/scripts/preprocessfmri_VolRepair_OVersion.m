function [VolFlag] = preprocessfmri_VolRepair_OVersion(OutputDir, DataType, ImgPrefix)

VolFlag = 0;

nifti4Dto3D_rui(OutputDir, ImgPrefix);

DataType = 'nii';

imgfiles = spm_select('FPList', OutputDir, ['^', ImgPrefix, 'I_.*\.nii']);
realignfile = spm_select('FPList', OutputDir, 'rp_I.txt');

%fprintf('imgfiles are %s \n',imgfiles);
subflag = scsnl_art_global_OVersion(imgfiles, realignfile, 1, 2, 0);
%subflag = art_global(imgfiles, realignfile, 1, 2);

delete([ImgPrefix,'I_*.nii']);

if subflag == 1
  VolFlag = 1;
else
  nifti3Dto4D (OutputDir, ['v', ImgPrefix])
end

end
