/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_cs.t_prisma_turnover_2
#----------------------------------------------------------------------------
# History:
#  1.0  01.03.2022    Ross, Ulrich            Init
#  1.1  09.05.2022    Ross, Ulrich            Add column "dwh_created_rcp 
#----------------------------------------------------------------------------
*/
CREATE TABLE P_LEW_PROCESS.T_EXPORT_LOG_PRISMA_2 (
	load_id NUMBER(38,0) NOT NULL,
	export_cluster_cd VARCHAR(20) NOT NULL COLLATE 'en-ci',
	process_name VARCHAR(100) NOT NULL COLLATE 'en-ci',
	report_dt DATE NOT NULL,
	max_load_id NUMBER(38,0) NOT NULL,
	dwh_created_rcp DATETIME,
  export_timestamp DATETIME NOT NULL
)
;