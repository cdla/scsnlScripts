#!/bin/bash

#################
# The amount of time to allot for each job
JOBTIME='01:00:00'
#################
# Job priority
JOBQOS='normal'
#################
# Number of nodes to request
JOBNNODES=1
#################
# Amount of memory to allocate per CPU
JOBMEM=4000
#################
# Partition to run your job on
# Options are:
#   - owners: access to all nodes
#   - menon: access to our lab nodes
#   - normal: the normal queue
JOBPARTITION='menon'
#################
JOBPARALLEL=1
#################
#set a job name
JOBNAME=$1
################
SCSNLSCRIPTSPATH='/oak/stanford/groups/menon/scsnlscripts_vsochat'
#################


######### PLEASE DO NOT CHANGE BELOW THIS LINE 

#################
#check if the user the configuration file exist
if [ ! -f $2 ]; then
    echo 'ERROR: Configuration file' $2 'not found!'
    exit 1
fi
#################

#################
#check if the user has specified a matlab script name at the command prompt
mlext='.m'
if [[ "$1" == *"$mlext"* ]]; then
    echo 'ERROR: Incorrect script name. Please remove .m from the script name' $1 
    exit 1
fi
#################

echo '********************************************************'
echo 'Running matlab script' $1
echo 'Reading configuration parameters from' $2

#################
#find spm version requested
strspmver=$(grep -nw ${2} -e 'paralist.spmversion')
if [ -z "$strspmver" ]; then
    echo 'ERROR: Variable paralist.spmversion not found in configuration file' $2 
    exit 1
fi
IFS="'"
tokens=($strspmver)
spmver=${tokens[1]}
#################

#################
#find project directory
strprojdir=$(grep -nw ${2} -e 'paralist.projectdir')
if [ -z "$strprojdir" ]; then
    echo 'ERROR: Variable paralist.projectdir not found in configuration file' $2 
    exit 1
fi
IFS="'"
tokens=($strprojdir)
projectdir=${tokens[1]}
#################

################# 
#find parallel or nonparallel 
strparallel=$(grep -nw ${2} -e 'paralist.parallel') 
if [ -z "$strparallel" ]; then 
    echo 'ERROR: Variable paralist.parallel not found in configuration file' $2  
    exit 1 
fi 
IFS="'" 
tokens=($strparallel) 
parallel=${tokens[1]}
echo 'parallel =' $parallel 
################# 

#################
#load modules
module load matlab
module load biology
module load fsl
module load freesurfer
#################

#################
#parallel or nonparallel job submit
if [ $parallel -eq 1 ]
then
	#################
	#determine the number of subjects
	strsubjlist=$(grep -nw ${2} -e 'paralist.subjectlist')
	if [ -z "$strsubjlist" ]; then
    		echo 'ERROR: Variable paralist.subjectlist not found in configuration file' $2 
    		exit 1
	fi
	IFS="'"
	tokens=($strsubjlist)
	numsubjects=$(cat ${tokens[1]} |wc -l)
	if [ ! -f ${tokens[1]} ]; then
    		echo 'ERROR: Subject list file' ${tokens[1]} 'not found!'
    		exit 1
	fi
	echo 'Reading subject list from ' ${tokens[1]}
	numsubjects=$(expr ${numsubjects} - 1)
	if [ "$numsubjects" -lt 1 ]; then
    		echo 'ERROR: Subjects list' ${tokens[1]} 'is empty'  
    		exit 1
	fi
	#################

	#################
	#read subjects list
	count=0
	while IFS=, read -r subj visit sess
	do
    		subject[$count]=$(echo PID-$subj'_visit'$visit'_session'$sess)
    		echo ${subject[$count]}
    		#echo $subj'_'$visit'_'$sess
    		count=$(expr $count + 1)
	done < ${tokens[1]}
	#################

	#################
	#submit one job per subject

	echo 'Processing' ${numsubjects} 'subjects'
	subjnum=1 
	for (( i = 1; i <= $numsubjects; i++ ))
	do
    		echo ${subject[$subjnum]}

    		echo 'Submitting job for Subject' ${subject[$subjnum]%?}
    		JOBOUTPUT=$(echo $projectdir'Jobs/'$1-%j'_'${subject[$subjnum]%?}'.out')
    		JOBERROR=$(echo $projectdir'Jobs/'$1-%j'_'${subject[$subjnum]%?}'.err')

    		echo 'Saving job output to ' $JOBOUTPUT' and '$JOBERROR
    		sbatch -J $JOBNAME -o $JOBOUTPUT -e $JOBERROR -t $JOBTIME -N $JOBNNODES --qos=$JOBQOS --mem-per-cpu=$JOBMEM -p $JOBPARTITION --wrap="matlab -nosplash -noFigureWindows -nodisplay -r $'addpath(genpath(\'$SCSNLSCRIPTSPATH/fmri/spm/$spmver\')); addpath(genpath(\'$SCSNLSCRIPTSPATH/mri/spm/$spmver\')); which $1; $1($i,\'$2\'); exit;'"    		
            sleep 10
    		subjnum=$(expr $subjnum + 1)
	done
elif [ $parallel -eq 0 ]
then
	#submit job
	JOBOUTPUT=$(echo $projectdir'/Jobs/'$1-%j'.out')
	JOBERROR=$(echo $projectdir'/Jobs/'$1-%j'.err')
	echo 'Saving job output to ' $JOBOUTPUT' and '$JOBERROR
    
	sbatch -J $JOBNAME -o $JOBOUTPUT -e $JOBERROR -t $JOBTIME -N $JOBNNODES --qos=$JOBQOS --mem-per-cpu=$JOBMEM -p $JOBPARTITION --wrap="matlab -nosplash -noFigureWindows -nodisplay -r $'addpath(genpath(\'$SCSNLSCRIPTSPATH/fmri/spm/$spmver\')); addpath(genpath(\'$SCSNLSCRIPTSPATH/mri/spm/$spmver\')); which $1; $1(\'$2\'); exit;'"
fi
echo '********************************************************'
#################


