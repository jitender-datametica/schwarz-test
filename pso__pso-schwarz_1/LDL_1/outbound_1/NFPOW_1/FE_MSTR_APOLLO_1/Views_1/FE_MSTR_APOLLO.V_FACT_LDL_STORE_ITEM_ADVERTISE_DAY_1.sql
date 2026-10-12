/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_APOLLO.V_FACT_LDL_STORE_ITEM_ADVERTISE_DAY_1
#----------------------------------------------------------------------------
# History:
#  1.0  11.04.2023    Aparna Rayanki           Initial Version
#  1.1  13.06.2023    Aparna Rayanki           Added KFL sales_1 7 qty metric
#  1.2  05.07.2023    Aparna Rayanki           Added KFL stock metrics
#  1.3  08.08.2024    Ulrich Meister           added KFL_CONSOLIDATED_PROMO_ITEM_TYPE_CD
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW nfpow_fe_mstr_apollo.v_fact_ldl_store_item_advertise_day_1 (lob_cd, ldl_store_sid, ldl_item_sid,
adv_dt, ldl_client_id, curr_cd, kfl_consolidated_promo_item_type_cd, ldl_adv_stock_qty, kfl_adv_stock_qty,
ldl_adjust_adv_sales_1_qty, ldl_adjust_adv_sales_3_qty, ldl_adjust_adv_sales_7_qty, kfl_adjust_adv_sales_7_qty,
ldl_adjust_adv_sales_17_qty, ldl_adjust_adv_sales_17_net_val, dwh_created_tmsp, dwh_updated_tmsp, dwh_src_tmsp) AS
SELECT *
FROM nfpow_core.t_fact_ldl_store_item_advertise_day_1 AS MAIN;