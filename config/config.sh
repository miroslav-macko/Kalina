#!/usr/bin/env bash
set -euo pipefail

#This configuration file contains all the important setup of paths. The comments also specify whether they should be changed or not.

########################################
#PATHS USED IN TWO OR MORE STAGES
#ROO_FOLD  (DECIDED BY THE USER): OUTPUT FOLDER WHERE THE RESULTS WILL BE STORED (ALL 3 STAGES)
#CTR_FOLD  (DECIDED BY THE USER): PATH TO YAROSLAVA'S CALIBRATION PIPELINES
#CONF_FOLD (DON´T CHANGE)       : FOLDER IN WHICH CONFIGURATION FILES CAN BE FOUND

	ROO_FOLD=/sps/nemo/scratch/mmacko/TEST_KAL
	CTR_FOLD=/pbs/home/m/mmacko/BB/YAROSLAVA/study_Falaise/scripts_for_calibration/real_data/newest_version_of_working_pipelines
	CONF_FOLD="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

########################################
#1. PATHS USED ONLY IN UDDtoROOT
#UDD_BI_FOLD (DON´T CHANGE)       : FOLDER CONTAINING ALL UDD BANK DATA FROM THE BI-207 CALIBRATION 
#CUT_FOLD    (DECIDED BY THE USER): FOLDER WITH YAROSLAVA'S CalibrationCutsModule
#BI207_LIST  (USER FILLS THE LIST): LIST CONTAINING ALL THE BI-207 RUNS TO TURN INTO ROOT

	UDD_BI_FOLD=/sps/nemo/snemo/snemo_data/reco_data/UDD/delta-tdc-10us-v3
	CUT_FOLD=/pbs/home/m/mmacko/BB/YAROSLAVA/Calibration_Constants_Extraction/build/CalibrationCutsModule
	BI207_LIST=${CONF_FOLD}/bi207.list

########################################
#2. PATHS USED ONLY IN extr_params
#SNC_FOLD    (DECIDED BY THE USER): PATH TO YAROSLAVA'S SNCalib MODULE TO EXTRACT CALIBRATION CONSTANTS
#BI207W_LIST (USER FILLS THE LIST): LIST CONTAINING ALL THE BI-207 WEEKS TO EXTRACT CALIBRATION PARAMETERS FROM

	SNC_FOLD=/pbs/home/m/mmacko/BB/YAROSLAVA/Calibration_Constants_Extraction/build/SNCalib
	BI207W_LIST=${CONF_FOLD}/bi207_weeks.list

########################################
#3. PATHS USED ONLY IN apply_calib
#UDD_BB_FOLD (DON´T CHANGE): FOLDER CONTAINING ALL UDD BANK DATA FROM THE BB RUNS 
#C2E_FOLD (DECIDED BY THE USER): FOLDER WITH YAROSLAVA'S MODULE FOR ENERGY APPLICATION
#BB_LIST  (USER FILLS THE LIST): LIST CONTAINING ALL THE BB RUNS WHICH SHOULD BE CALIBRATED

	UDD_BB_FOLD=/sps/nemo/snemo/snemo_data/reco_data/UDD/delta-tdc-1600us-v3
	C2E_FOLD=/pbs/home/m/mmacko/BB/YAROSLAVA/Energy_Calibration/build/Charge2EnergyModule
	BB_LIST=${CONF_FOLD}/bb.list
