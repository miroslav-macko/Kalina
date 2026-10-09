#! /bin/sh 

#SNC_FOLD SHOULD LINK TO YAROSLAVA'S SNCalib MODULE TO EXTRACT CALIBRATION CONSTANTS
SNC_FOLD=/pbs/home/m/mmacko/BB/YAROSLAVA/Calibration_Constants_Extraction/build/SNCalib
#ROO_FOLD IS AN OUTPUT FOLDER
ROO_FOLD=/sps/nemo/scratch/mmacko/TEST_KAL
   	       
	#PART WHICH TAKES CALIBRATION WEEKS AND MERGES THEM. IT TAKES INFORMATION FROM DATABASE IN bi207_weeks.list
	while IFS= read -r line; do
		set -- $line   # splits line into $1 $2 ... $N

	  	i=1
	  	for field in "$@"; do
	  		if [ "$i" = "1" ]; then
  				Y=$field 
	  		elif [ "$i" = "2" ]; then
  				W=$field
  				
  				WORKDIR=${ROO_FOLD}/phase_2/week_${Y}_${W}/bi207
				
  				echo "SENDING CALIBRATION PARAMETER EXTRACTION FROM WEEK ${W}/${Y} TO NODES!"
  				
				sbatch -J p${W}_${Y} \
					-o ${WORKDIR}/job_%j_${Y}_${W}_params.log \
				       ./job_params.sh $W $Y $SNC_FOLD $WORKDIR
			fi
			
	    		i=$((i + 1))
	  	done
	done < bi207_weeks.list
