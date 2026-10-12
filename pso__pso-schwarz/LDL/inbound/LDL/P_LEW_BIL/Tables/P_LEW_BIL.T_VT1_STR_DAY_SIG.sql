/*
# History:
# 1.0     2023-10-18      Stephane Djiomou Tonga            Initial Version.
#-----------------------------------------------------------------------------
# Description:
# This table will persist the data contained in P_LEW_TMP.vt1 Table.
# Those Data are inserted during the execution of the AI Script aggr_load_t_agg_store_day_piece_perf_sig.py in BIL Project.
# The whole persisted data will be read on Sunday evening. After that, this Table will trunctate at the end of the execution 
#-----------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_BIL.T_VT1_STR_DAY_SIG (
	CLIENT_ID NUMBER(38,0),
	DWH_CAL_DT DATE
);