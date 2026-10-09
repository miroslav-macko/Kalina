#! /bin/sh 
#SBATCH --mem=1G
#SBATCH --licenses=sps
#SBATCH --time=15:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

	W=${1}
	Y=${2}
	i=${3}
	UDD_FOLD=${4}
	CUT_FOLD=${5}
	WORKDIR=${6}
	CTR_FOLD=${7}
	
	DATADIR=${WORKDIR}/${i}
	
	export CUT_FOLD
	export DATADIR
	
	source ${THRONG_DIR}/config/supernemo_profile.bash
	snswmgr_load_stack falaise@2026-02-09
	
	cd ${DATADIR}
	
	echo "WORK DIRECTORY CREATED!"
	
	echo ""
	echo "UDD->pCD CONVERSION:"
	echo ""
	
	flreconstruct -i ${UDD_FOLD}/snemo_run-${i}_udd.brio \
	              -p ${CTR_FOLD}/1D-pipeline.conf \
	              -o ${DATADIR}/${i}_pCD.brio
	              
	echo ""
	echo "pCD->PTD CONVERSION:"
	echo ""
	
	flreconstruct -i ${DATADIR}/${i}_pCD.brio \
	              -p ${CTR_FOLD}/2D-CMRMN-CPT-GT-pipeline.conf \
	              -o ${DATADIR}/${i}_PTD.brio
	              
	rm  ${DATADIR}/${i}_pCD.brio  
	              
	echo ""
	echo "CALIB EVENT CUT SELECTION (PTD->ROOT):"
	echo ""
	
	#Produce .root file with selected events ready for fitting and extraction of calibration paramaters
	flreconstruct -i ${DATADIR}/${i}_PTD.brio \
		      -p ${CUT_FOLD}/calibration_cuts.conf
	
	#rm  ${DATADIR}/${i}_PTD.brio
