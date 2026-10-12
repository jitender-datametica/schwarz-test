/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_APOLLO.V_FACT_LDL_CLIENT_LOB_MONTH_1
#----------------------------------------------------------------------------
# History:
#  1.0  11.04.2023    Aparna Rayanki           Initial Version
#  1.1  08.05.2023    Aparna Rayanki           PDM changes to column names
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW nfpow_fe_mstr_apollo.v_fact_ldl_client_lob_month_1 (ldl_client_id, lob_cd, cal_month, cal_year,
curr_cd, ldl_total_adjust_sales_net_val, ldl_prev_1y_total_adjust_sales_net_val, dwh_created_tmsp, dwh_updated_tmsp,
dwh_src_tmsp) AS SELECT *
FROM nfpow_core.t_fact_ldl_client_lob_month_1 AS MAIN;