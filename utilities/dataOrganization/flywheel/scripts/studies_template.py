''' studies template for fly wheel download script
whenever a study protocol is added that we are collecting data from the scanner for, it must be added to this file as a dictionary entry.
Use this format;

'study_name':{'acquistion_for_download_1':[['file_extension1','path/to/download1filename'],['file_extension2','path/to/download2filename'] . . .],
              'acquistion_for_download_2':[['file_extension1','path/to/download1filename'],['file_extension2','path/to/download2filename'] . . .],
              .
              .
              .
              'acquistion_for_download_n':[['file_extension1','path/to/download1filename'],['file_extension2','path/to/download2filename'] . . .]
              },

if you do not know the name of the file you are downloading, (for example if you are downloading pfiles) use * to fill in the 'path/to/downloadfilename'.
This will just keep the filename of whatever file the script finds on flywheel. You will see examples of this syntax below.

There is also a studies rules dictionary at the bottom, this currently only specifies the number of dummy scans files in the protocol to move
to the unused folder.
'''

studies_template = {'met':{'resting':[['.nii.gz','fmri/resting/unnormalized/I.nii.gz']],
                           'grid1':[['.nii.gz','fmri/grid1/unnormalized/I.nii.gz']],
                           'grid2':[['.nii.gz','fmri/grid2/unnormalized/I.nii.gz']],
                           'grid3':[['.nii.gz','fmri/grid3/unnormalized/I.nii.gz']],
                           'grid4':[['.nii.gz','fmri/grid4/unnormalized/I.nii.gz']],
                           'sym1':[['.nii.gz','fmri/sym1/unnormalized/I.nii.gz']],
                           'sym2':[['.nii.gz','fmri/sym2/unnormalized/I.nii.gz']],
                           'sym3':[['.nii.gz','fmri/sym3/unnormalized/I.nii.gz']],
                           'sym4':[['.nii.gz','fmri/sym4/unnormalized/I.nii.gz']],
			   'resting_pepolar':[['.nii.gz','fmri/resting_pepolar/unnormalized/I.nii.gz']],
			   'sym1_pepolar':[['.nii.gz','fmri/sym1_pepolar/unnormalized/I.nii.gz']],
		           'sym2_pepolar':[['.nii.gz','fmri/sym2_pepolar/unnormalized/I.nii.gz']],
			   'sym3_pepolar':[['.nii.gz','fmri/sym3_pepolar/unnormalized/I.nii.gz']],
			   'sym4_pepolar':[['.nii.gz','fmri/sym4_pepolar/unnormalized/I.nii.gz']],
			   'grid1_pepolar':[['.nii.gz','fmri/grid1_pepolar/unnormalized/I.nii.gz']],
			   'grid2_pepolar':[['.nii.gz','fmri/grid2_pepolar/unnormalized/I.nii.gz']],
			   'grid3_pepolar':[['.nii.gz','fmri/grid3_pepolar/unnormalized/I.nii.gz']],
			   'grid4_pepolar':[['.nii.gz','fmri/grid4_pepolar/unnormalized/I.nii.gz']],
                           'ORIG 3D_Volume':[['.dicom','anatomical/orig_3D_Volume/*']],
                           'ORIG T2':[['.dicom','anatomical/orig_T2/*']],
                           '3D_Volume':[['.dicom','anatomical/3D_Volume/*']],
                           'T2':[['.dicom','anatomical/T2/*']],
                           'HARDI_150_R=2':[['.nii.gz','dwi/dwi_raw.nii.gz'],['.bvec','dwi/dwi_raw.bvec'],['.bval','dwi/dwi_raw.bval']]},
              'asdmemory':{'resting_1':[['.7','fmri/resting_1/Pfiles/*']],
                           'encoding_1':[['.7','fmri/encoding_1/Pfiles/*']],
                           'encoding_2':[['.7','fmri/encoding_2/Pfiles/*']],
                           'resting_2':[['.7','fmri/resting_2/Pfiles/*']],
                           'retrieval_1':[['.7','fmri/retrieval_1/Pfiles/*']],
                           'retrieval_2':[['.7','fmri/retrieval_2/Pfiles/*']],
                           'retrieval_3':[['.7','fmri/retrieval_3/Pfiles/*']],
                           'retrieval_4':[['.7','fmri/retrieval_4/Pfiles/*']],
                           'localizer':[['.7','fmri/localizer/Pfiles/*']],
                           '3D_volume_structural':[['.dicom','anatomical/*']],
                           '3D_volume':[['.dicom','anatomical/*']],
                           'HARDI_150_R=2':[['.nii.gz','dwi/dwi_raw.nii.gz'],['.bvec','dwi/dwi_raw.bvec'],['.bval','dwi/dwi_raw.bval']]},
                   'adhd':{'resting_state_1':[['.nii.gz','fmri/resting_state_1/unnormalized_unc/I.nii.gz']],
                           'resting_state_1_blipdown':[['.nii.gz','fmri/resting_state_1_blipdown/unnormalized_unc/I.nii.gz']],
                           'level1_run1':[['.nii.gz','fmri/level1_run1/unnormalized_unc/I.nii.gz']],
                           'level1_run1_blipdown':[['.nii.gz','fmri/level1_run1_blipdown/unnormalized_unc/I.nii.gz']],
                           'level1_run2':[['.nii.gz','fmri/level1_run2/unnormalized_unc/I.nii.gz']],
                           'level1_run2_blipdown':[['.nii.gz','fmri/level1_run2_blipdown/unnormalized_unc/I.nii.gz']],
                           'level1_run3':[['.nii.gz','fmri/level1_run3/unnormalized_unc/I.nii.gz']],
                           'level1_run3_blipdown':[['.nii.gz','fmri/level1_run3_blipdown/unnormalized_unc/I.nii.gz']],
                           'level1_run4':[['.nii.gz','fmri/level1_run4/unnormalized_unc/I.nii.gz']],
                           'level1_run4_blipdown':[['.nii.gz','fmri/level1_run4_blipdown/unnormalized_unc/I.nii.gz']],
                           'level2_run1':[['.nii.gz','fmri/level2_run1/unnormalized_unc/I.nii.gz']],
                           'level2_run1_blipdown':[['.nii.gz','fmri/level2_run1_blipdown/unnormalized_unc/I.nii.gz']],
                           'level2_run2':[['.nii.gz','fmri/level2_run2/unnormalized_unc/I.nii.gz']],
                           'level2_run2_blipdown':[['.nii.gz','fmri/level2_run2_blipdown/unnormalized_unc/I.nii.gz']],
                           'level2_run3':[['.nii.gz','fmri/level2_run3/unnormalized_unc/I.nii.gz']],
                           'level2_run3_blipdown':[['.nii.gz','fmri/level2_run3_blipdown/unnormalized_unc/I.nii.gz']],
                           'level2_run4':[['.nii.gz','fmri/level2_run4/unnormalized_unc/I.nii.gz']],
                           'level2_run4_blipdown':[['.nii.gz','fmri/level2_run4_blipdown/unnormalized_unc/I.nii.gz']],
                           'level2_run5':[['.nii.gz','fmri/level2_run5/unnormalized_unc/I.nii.gz']],
                           'level2_run5_blipdown':[['.nii.gz','fmri/level2_run5_blipdown/unnormalized_unc/I.nii.gz']],
                           'level3_run1':[['.nii.gz','fmri/level3_run1/unnormalized_unc/I.nii.gz']],
                           'level3_run1_blipdown':[['.nii.gz','fmri/level3_run1_blipdown/unnormalized_unc/I.nii.gz']],
                           'level3_run2':[['.nii.gz','fmri/level3_run2/unnormalized_unc/I.nii.gz']],
                           'level3_run2_blipdown':[['.nii.gz','fmri/level3_run2_blipdown/unnormalized_unc/I.nii.gz']],
                           'level3_run3':[['.nii.gz','fmri/level3_run3/unnormalized_unc/I.nii.gz']],
                           'level3_run3_blipdown':[['.nii.gz','fmri/level3_run3_blipdown/unnormalized_unc/I.nii.gz']],
                           'level3_run4':[['.nii.gz','fmri/level3_run4/unnormalized_unc/I.nii.gz']],
                           'level3_run4_blipdown':[['.nii.gz','fmri/level3_run4_blipdown/unnormalized_unc/I.nii.gz']],
                           'level3_run5':[['.nii.gz','fmri/level3_run5/unnormalized_unc/I.nii.gz']],
                           'level3_run5_blipdown':[['.nii.gz','fmri/level3_run5_blipdown/unnormalized_unc/I.nii.gz']],
                           'level3_run6':[['.nii.gz','fmri/level3_run6/unnormalized_unc/I.nii.gz']],
                           'level3_run6_blipdown':[['.nii.gz','fmri/level3_run6_blipdown/unnormalized_unc/I.nii.gz']],
			                     'Ax FSPGR BRAVO':[['.dicom','anatomical/*']],
                           '3D_volume_structural':[['.dicom','anatomical/*']],
                           '3D_volume':[['.dicom','anatomical/*']],
                           'HARDI_150_R=2':[['.nii.gz','dwi/dwi_raw.nii.gz'],['.bvec','dwi/dwi_raw.bvec'],['.bval','dwi/dwi_raw.bval']]},                    
                    'hwc':{'resting_state_1':[['.7','fmri/resting_state_1/Pfiles/*']],
                           'SST_1':[['.7','fmri/SST_1/Pfiles/*']],
                           'SST_2':[['.7','fmri/SST_2/Pfiles/*']],
                           'Emotion_match_1':[['.7','fmri/Emotion_match_1/Pfiles/*']],
                           'Emotion_regulation_1':[['.7','fmri/Emotion_regulation_1/Pfiles/*']],
                           'Emotion_regulation_2':[['.7','fmri/Emotion_regulation_2/Pfiles/*']],
                           'BART_1':[['.7','fmri/BART_1/Pfiles/*']],
                           '3D_volume_structural':[['.dicom','anatomical/*']],
                           '3D_volume':[['.dicom','anatomical/*']],
                           'HARDI_150_R=2':[['.nii.gz','dwi/dwi_raw.nii.gz'],['.bvec','dwi/dwi_raw.bvec'],['.bval','dwi/dwi_raw.bval']]},
               'mathwhiz':{'addition_1':[['.7','fmri/addition_1/Pfiles/*']],
                           'addition_2':[['.7','fmri/addition_2/Pfiles/*']],
                           'addition_3':[['.7','fmri/addition_3/Pfiles/*']],
                           'addition_4':[['.7','fmri/addition_4/Pfiles/*']],
                           'resting_state_1':[['.7','fmri/resting_1/Pfiles/*']],
                           'T2_Coronal_ETI_25':[['.nii.gz','anatomical/T2.nii.gz']],
                           '3D_volume_structural':[['.dicom','anatomical/*']],
                           '3D_volume':[['.dicom','anatomical/*']],
                           'HARDI_150_R=2':[['.nii.gz','dwi/dwi_raw.nii.gz'],['.bvec','dwi/dwi_raw.bvec'],['.bval','dwi/dwi_raw.bval']]},
             'smp':{'arithmetic_addition_1':[['.7','fmri/arithmetic_addition_1/Pfiles/*']],
                           'comparison_num':[['.7','fmri/comparison_num/Pfiles/*']],
                           'comparison_dot':[['.7','fmri/comparison_dot/Pfiles/*']],
                           'arithmetic_addition_2':[['.7','fmri/arithmetic_addition_2/Pfiles/*']],
                           'word_1':[['.7','fmri/word_1/Pfiles/*']],
                           'number_1':[['.7','fmri/number_1/Pfiles/*']],
                           'equation_1':[['.7','fmri/equation_1/Pfiles/*']],
                           'letter_1':[['.7','fmri/letter_1/Pfiles/*']],
                           'addblock_1':[['.7','fmri/addblock_1/Pfiles/*']],
                           'addevent_1':[['.7','fmri/addevent_1/Pfiles/*']],
                           'addevent_2':[['.7','fmri/addevent_2/Pfiles/*']],
                           'equation_2':[['.7','fmri/equation_2/Pfiles/*']],
                           'letter_2':[['.7','fmri/letter_2/Pfiles/*']],
                           'number_2':[['.7','fmri/number_2/Pfiles/*']],
                           'resting_state_1':[['.7','fmri/resting_state_1/Pfiles/*']],
                           'resting_state_2':[['.7','fmri/resting_state_2/Pfiles/*']],
                           'resting_1':[['.7','fmri/resting_1/Pfiles/*']],
                           'resting_2':[['.7','fmri/resting_2/Pfiles/*']],
                           'subblock_1':[['.7','fmri/subblock_1/Pfiles/*']],
                           'word_2':[['.7','fmri/word_2/Pfiles/*']],
                           '3D_volume_structural':[['.dicom','anatomical/*']],
                           '3D_volume':[['.dicom','anatomical/*']],
                           'HARDI_150_R=2':[['.nii.gz','dwi/dwi_raw.nii.gz'],['.bvec','dwi/dwi_raw.bvec'],['.bval','dwi/dwi_raw.bval']]}}


studies_rules = {'met':{'unused_num':16,'permissions':['daelsaid','changh','zwnadell','rudoler','lchen32','florasch','jkboram','shelbyka']},
           'asdmemory':{'unused_num':2,'permissions':['zwnadell','lchen32','ahmadalz']},
	              'adhd':{'unused_num':0,'permissions':['kduberg','wdcai']},
                 'hwc':{'unused_num':2,'permissions':['kduberg','wdcai','mcsnyder']},
            'mathwhiz':{'unused_num':2,'permissions':['shelbyk','jkboram','changh']},
          'smpmathfun':{'unused_num':2,'permissions':['jkboram','florasch']},
              'smpsmp':{'unused_num':2,'permissions':['jkboram','florasch']},
              'smp':{'unused_num':2,'permissions':['jkboram','florasch']},
              'mathfun':{'unused_num':2,'permissions':['jkboram','florasch']}}
