#! /bin/sh 
#SBATCH --mem=1G
#SBATCH --licenses=sps
#SBATCH --time=1:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

	W=$1
	Y=$2
	SNC_FOLD=$3
	WORKDIR=$4

	source ${THRONG_DIR}/config/supernemo_profile.bash
	snswmgr_load_stack falaise@2026-02-09
	
	#Merge .root files from the same week - events ready for fitting and extraction of calibration parameters
	hadd ${WORKDIR}/merged_y${Y}_w${W}.root ${WORKDIR}/*/extracted_data.root

	#Extract calibration parameters from the merged file
	${SNC_FOLD}/sncalib -V \
	 -i ${WORKDIR}/merged_y${Y}_w${W}.root \
	 -o ${WORKDIR}/calib_y${Y}_w${W}.csv \
	 -p ${SNC_FOLD}/params.conf 
