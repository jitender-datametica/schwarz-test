
/*
#----------------------------------------------------------------------------
# Description:
# Static view for Reporting.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     27.11.2023      Aparna Rayanki          Initial Version
#  2.0     27.02.2024      Simeon Nikolaev         Added COMPENSATION_WEEK_FG
#
#-----------------------------------------------------------------------------
*/



CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_REF_RECONSTRUCTION_WEEK(
	STORAGE_TEST_EXEC_SID
	,ORIG_STORE_NR
	,TEST_WEEK
	,RECONSTRUCTION_WEEK_FG
	,EXCLUDED_WEEK_FG
	,COMPENSATION_WEEK_FG
) AS
SELECT STORAGE_TEST_EXEC_SID
	,ORIG_STORE_NR
	,TEST_WEEK
	,RECONSTRUCTION_WEEK_FG
	,EXCLUDED_WEEK_FG
	,COMPENSATION_WEEK_FG
	FROM FE_MSTR_TOOLBOX_SPIEGEL.T_REF_RECONSTRUCTION_WEEK
;
