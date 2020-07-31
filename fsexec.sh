#! /bin/bash

#setup freesurfer path vars, make output is as expected
local_freesurf_dir='/usr/local/freesurfer'
export FREESURFER_HOME="$local_freesurf_dir"
source $FREESURFER_HOME/SetUpFreeSurfer.sh
printf "Setting up environment for FreeSurfer/FS-FAST (and FSL)
FREESURFER_HOME   $FREESURFER_HOME
FSFAST_HOME       $FSFAST_HOME
FSF_OUTPUT_FORMAT $FSF_OUTPUT_FORMAT
SUBJECTS_DIR      $SUBJECTS_DIR
MNI_DIR           $MNI_DIR
"
# export PATH=$PATH:$FREESURFER_HOME
echo "$PATH"
#get number of CPU processors
n_proc=$(eval "nproc --all")
#n_proc=4
echo "$n_proc"

#duplicate subject n_proc times
eval "python copy_subject.py duplicate1 $((n_proc-1))"

recon_phase='-autorecon1'
output_subject_dir='.'

#parallel
start=$SECONDS
eval "ls -d duplicate* | parallel --jobs 4 recon-all -i {}/001.dcm -s {}out -sd ${output_subject_dir} $recon_phase" 
wait
	duration=$(( SECONDS - start ))
echo "Time for $n_proc subjects(secs) = $((duration))"


#serial
# for i in $( eval echo {1..$n_proc})
# do
# input_subject_dir="duplicate${i}"
# output_subject_name="duplicate${i}_out"
#echo "recon-all -i ${input_subject_dir}/001.dcm -s ${output_subject_name} -sd ${output_subject_dir}" 
#done

