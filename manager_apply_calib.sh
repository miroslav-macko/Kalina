#! /bin/sh 

#####NEEDS TO FIX IMPOSSIBILITY TO LOAD RELATIVELY THE CALIBRATION PARAMETERS IN JOB PART

#UDD_FOLD - FOLDER WITH ALL UDD BANK DATA FROM THE BI-207 CALIBRATION
UDD_FOLD=/sps/nemo/snemo/snemo_data/reco_data/UDD/delta-tdc-1600us-v3
#CTR_FOLD - FOLDER WITH YAROSLAVA'S CALIBRATION PIPELINES
CTR_FOLD=/pbs/home/m/mmacko/BB/YAROSLAVA/study_Falaise/scripts_for_calibration/real_data/newest_version_of_working_pipelines
#ROO_FOLD IS AN OUTPUT FOLDER
ROO_FOLD=/sps/nemo/scratch/mmacko/TEST_KAL
#C2E_FOLD - FOLDER WITH YAROSLAVA'S MODULE FOR ENERGY APPLICATION
C2E_FOLD=/pbs/home/m/mmacko/BB/YAROSLAVA/Energy_Calibration/build/Charge2EnergyModule

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
			    	   ./job_apply_calib.sh ${W} ${Y} ${RNO} ${UDD_FOLD} ${CTR_FOLD} ${ROO_FOLD} ${WORKDIR} ${C2E_FOLD} ${PARFILE_PATH}
			fi
			
	    		i=$((i + 1))
	  	done
	done < bb.list

