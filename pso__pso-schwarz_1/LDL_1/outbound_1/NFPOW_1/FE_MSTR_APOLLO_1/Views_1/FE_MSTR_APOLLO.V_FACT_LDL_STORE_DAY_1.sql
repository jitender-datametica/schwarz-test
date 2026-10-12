/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_APOLLO.V_FACT_LDL_STORE_DAY_1
#----------------------------------------------------------------------------
# History:
#  1.0  11.04.2023    Aparna Rayanki           Initial Version
#  1.1  08.05.2023    Aparna Rayanki           PDM changes to column names
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW nfpow_fe_mstr_apollo.v_fact_ldl_store_day_1 (lob_cd, ldl_store_sid, cal_dt, ldl_client_id, curr_cd
, ldl_total_adjust_sales_net_val, dwh_created_tmsp, dwh_updated_tmsp, dwh_src_tmsp) AS SELECT *
FROM nfpow_core.t_fact_ldl_store_day_1 AS MAIN;