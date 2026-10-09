#! /bin/sh 

#IN calibrationcuts.conf YOU SHOULD FIX HARDCODED SOURCE POSITION TEXT FILE TO RELATIVE

#Load all the correct paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source ${SCRIPT_DIR}/../config/config.sh

#PART WHICH TAKES CALIBRATION RUNS AND PUT THEM TO THE RIGHT WEEK. IT TAKES INFORMATION FROM DATABASE IN bi207.list
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
			    echo "CALIBRATION OF RUN ${RNO} FROM WEEK ${W}/${Y} SENT TO NODES!"
			    
			    WORKDIR=${ROO_FOLD}/phase_2/week_${Y}_${W}/bi207
			    
			    mkdir -p ${WORKDIR}/${RNO}
			    
			    sbatch -J utr${RNO} \
			    	   -o ${WORKDIR}/${RNO}/job_%j_${RNO}_UDDtoROOT.log \
			           ${SCRIPT_DIR}/job_UDDtoROOT.sh ${W} \
			           				  ${Y} \
			           				  ${RNO} \
			           				  ${UDD_BI_FOLD} \
			           				  ${CUT_FOLD} \
			           				  ${WORKDIR} \
			           				  ${CTR_FOLD} \
			           				  ${CONF_FOLD}
			fi
			
	    		i=$((i + 1))
	  	done
	done < ${BI207_LIST}
