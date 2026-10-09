#! /bin/sh 

#IN calibrationcuts.conf YOU SHOULD FIX HARDCODED SOURCE POSITION TEXT FILE TO RELATIVE

#UDD_FOLD - FOLDER WITH ALL UDD BANK DATA FROM THE BI-207 CALIBRATION
UDD_FOLD=/sps/nemo/snemo/snemo_data/reco_data/UDD/delta-tdc-10us-v3
#CUT_FOLD - FOLDER WITH YAROSLAVA'S CalibrationCutsModule
CUT_FOLD=/pbs/home/m/mmacko/BB/YAROSLAVA/Calibration_Constants_Extraction/build/CalibrationCutsModule
#CTR_FOLD - FOLDER WITH YAROSLAVA'S CALIBRATION PIPELINES
CTR_FOLD=/pbs/home/m/mmacko/BB/YAROSLAVA/study_Falaise/scripts_for_calibration/real_data/newest_version_of_working_pipelines
#ROO_FOLD - AN OUTPUT FOLDER
ROO_FOLD=/sps/nemo/scratch/mmacko/TEST_KAL

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
			    
			    sbatch -J cu${RNO} \
			    	   -o ${WORKDIR}/${RNO}/job_%j_${RNO}_cuts.log \
			           ./job_cuts.sh ${W} ${Y} ${RNO} ${UDD_FOLD} ${CUT_FOLD} ${WORKDIR} ${CTR_FOLD}
			fi
			
	    		i=$((i + 1))
	  	done
	done < bi207.list
