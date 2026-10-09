#! /bin/sh 
#SBATCH --mem=1G
#SBATCH --licenses=sps
#SBATCH --time=10:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

	W=${1}
	Y=${2}
	i=${3}
	UDD_BB_FOLD=${4}
	CTR_FOLD=${5}
	ROO_FOLD=${6}
	WORKDIR=${7}
	C2E_FOLD=${8}
	PARFILE_PATH=${9}
	CONF_FOLD=${10}
	
	export C2E_FOLD
	export PARFILE_PATH
	
	#Loading the Falaise version from the configuration file
	source ${CONF_FOLD}/load_falaise.sh
	
	cd ${WORKDIR}/${i}
		
	echo ""
	echo "UDD->pCD CONVERSION:"
	echo ""
	
	flreconstruct -i ${UDD_BB_FOLD}/snemo_run-${i}_udd.brio \
	              -p ${CTR_FOLD}/1D-pipeline.conf \
	              -o ${WORKDIR}/${i}/${i}_pCD.brio
	              
	echo ""
	echo "pCD->PTD CONVERSION:"
	echo ""
	
	flreconstruct -i ${WORKDIR}/${i}/${i}_pCD.brio \
	              -p ${CTR_FOLD}/2D-CMRMN-CPT-GT-pipeline.conf \
	              -o ${WORKDIR}/${i}/${i}_PTD.brio
	              
	rm ${WORKDIR}/${i}/${i}_pCD.brio
	              
	echo ""
	echo "CALIBRATION = REPLACING CHARGE BY ENERGY:"
	echo ""
	
	### I NEED TO SOLVE THIS BETTER NOT USING SED
	sed "s|@@@@@PARFILE|${PARFILE_PATH}|g" ${C2E_FOLD}/charge2energy.conf > ${WORKDIR}/charge2energy.conf
	
	flreconstruct -i ${WORKDIR}/${i}/${i}_PTD.brio \
	              -p ${WORKDIR}/charge2energy.conf \
	              -o ${WORKDIR}/${i}/${i}_cal.brio
	              
	rm ${WORKDIR}/${i}/${i}_PTD.brio
