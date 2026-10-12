/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_APOLLO.V_FACT_LDL_CLIENT_ITEM_DAY_2
#----------------------------------------------------------------------------
# History:
#  1.0  11.04.2023    Aparna Rayanki           Initial Version
#  1.1  08.08.2024    Ulrich Meister           KFL_CONSOLIDATED_PROMO_ITEM_TYPE_CD added
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW nfpow_fe_mstr_apollo.v_fact_ldl_client_item_day_2 (lob_cd, ldl_client_id, ldl_item_sid, cal_dt,
curr_cd, kfl_consolidated_promo_item_type_cd, ldl_rcv_qty, ldl_buying_rcv_net_val, ldl_retail_rcv_net_val,
dwh_created_tmsp, dwh_updated_tmsp, dwh_src_tmsp) AS SELECT *
FROM nfpow_core.t_fact_ldl_client_item_day_2 AS MAIN;