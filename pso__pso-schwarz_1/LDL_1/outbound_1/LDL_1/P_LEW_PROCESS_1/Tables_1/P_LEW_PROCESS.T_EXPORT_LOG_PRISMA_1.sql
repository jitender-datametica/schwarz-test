/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_cs.t_prisma_turnover_1
#----------------------------------------------------------------------------
# History:
#  1.0  01.03.2022    Ross, Ulrich            Init
#  1.1  09.05.2022    Ross, Ulrich            Add column "dwh_created_rcp 
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_export_log_prisma_1 (
load_id BIGNUMERIC(38,0) NOT NULL,
export_cluster_cd STRING(20) COLLATE 'und:ci' NOT NULL,
process_name STRING(100) COLLATE 'und:ci' NOT NULL,
report_dt DATE NOT NULL,
max_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created_rcp DATETIME,
export_timestamp DATETIME NOT NULL
);