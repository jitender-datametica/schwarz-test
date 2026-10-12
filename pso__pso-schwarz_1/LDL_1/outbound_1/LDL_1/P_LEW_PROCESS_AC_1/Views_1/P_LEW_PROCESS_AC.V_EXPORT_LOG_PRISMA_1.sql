/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_cs.t_prisma_turnover_1
#----------------------------------------------------------------------------
# History:
#  1.0  01.03.2022    Ross, Ulrich            Init
#  1.1  09.05.2022    Ross, Ulrich            Add column dwh_created_rcp
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_export_log_prisma_1 (load_id, export_cluster_cd, process_name, report_dt,
max_load_id, dwh_created_rcp, export_timestamp) AS SELECT load_id,
 export_cluster_cd,
 process_name,
 report_dt,
 max_load_id,
 dwh_created_rcp,
 export_timestamp
FROM ldl_p_lew_process.t_export_log_prisma_1;