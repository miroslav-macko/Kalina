#! /bin/sh 

#Load all the correct paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source ${SCRIPT_DIR}/../config/config.sh
   	       
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
				       -o ${WORKDIR}/job_%j_${Y}_${W}_extr_params.log \
				       ${SCRIPT_DIR}/job_extr_params.sh ${W} \
				       			    		${Y} \
				       			    		${SNC_FOLD} \
				       			    		${WORKDIR} \
				       			    		${CONF_FOLD}
			fi
			
	    		i=$((i + 1))
	  	done
	done < ${BI207W_LIST}
