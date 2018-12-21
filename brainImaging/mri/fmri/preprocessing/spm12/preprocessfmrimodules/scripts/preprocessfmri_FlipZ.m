function preprocessfmri_FlipZ (OutputDir, ImgPrefix)
  unix(sprintf('fslreorient2std %s %s', ...
    fullfile(OutputDir, [ImgPrefix, 'I']), fullfile(OutputDir, ['f', ImgPrefix, 'I'])));
  unix(sprintf('gunzip -fq %s', fullfile(OutputDir, ['f', ImgPrefix, 'I.nii.gz'])));
   unix(sprintf('fslreorient2std %s %s', ...
    fullfile(OutputDir, 'meanI'), fullfile(OutputDir, 'meanI')));
  unix(sprintf('gunzip -fq %s', fullfile(OutputDir, 'meanI.nii.gz')));
  
end
