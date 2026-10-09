#! /bin/sh 

#####NEEDS TO FIX IMPOSSIBILITY TO LOAD RELATIVELY THE CALIBRATION PARAMETERS IN JOB PART

#Load all the correct paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source ${SCRIPT_DIR}/../config/config.sh

	#PART WHICH COUPLES RIGHT CALIBRATION WITH THE BB RUNS. THE DATA ARE TAKEN FROM THE DATABASE IN bb.list
	while IFS= read -r line; do
		set -- $line   # splits line into $1 $2 ... $N

	  	i=1
	  	for field in "$@"; do
	  		if [ "$i" = "1" ]; then
  				Y=$field 
	  		elif [ "$i" = "2" ]; then
  				W=$field
			else
			    RNO=$field
			    echo "SENDING CALIBRATION OF RUN ${RNO} FROM WEEK ${W}/${Y} TO NODES!"
			    
			    WORKDIR=${ROO_FOLD}/phase_2/week_${Y}_${W}/bb_1600um
			    PARFILE_PATH=${ROO_FOLD}/phase_2/week_${Y}_${W}/bi207/calib_y${Y}_w${W}.csv
			    	
			    mkdir -p ${WORKDIR}/${RNO}
			    
			    sbatch -J cbb${RNO} \
			    	   -o ${WORKDIR}/${RNO}/job_%j_${RNO}.log \
			    	   ${SCRIPT_DIR}//job_apply_calib.sh ${W} \
			    	   				     ${Y} \
			    	   				     ${RNO} \
			    	   				     ${UDD_BB_FOLD} \
			    	   				     ${CTR_FOLD} \
			    	   				     ${ROO_FOLD} \
			    	   				     ${WORKDIR} \
			    	   				     ${C2E_FOLD} \
			    	   				     ${PARFILE_PATH} \
			    	   				     ${CONF_FOLD}
			fi
			
	    		i=$((i + 1))
	  	done
	done < ${BB_LIST}

