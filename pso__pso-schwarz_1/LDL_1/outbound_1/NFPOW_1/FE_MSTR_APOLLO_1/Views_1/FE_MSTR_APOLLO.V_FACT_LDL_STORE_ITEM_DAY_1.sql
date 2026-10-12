/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_APOLLO.V_FACT_LDL_STORE_ITEM_DAY_1
#----------------------------------------------------------------------------
# History:
#  1.0  11.04.2023    Aparna Rayanki           Initial Version
#  1.1  08.05.2023    Aparna Rayanki           PDM changes to column names
#  1.2  12.06.2023    Aparna Rayanki           Changes to KFL_SALES_NET_VAL
#  1.3  15.06.2023    Aparna Rayanki           added KFL_PCH_NET_VAL
#  1.4  08.08.2024    Ulrich Meister           added KFL_CONSOLIDATED_PROMO_ITEM_TYPE_CD
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW nfpow_fe_mstr_apollo.v_fact_ldl_store_item_day_1 (lob_cd, ldl_store_sid, ldl_item_sid, cal_dt,
ldl_client_id, curr_cd, kfl_consolidated_promo_item_type_cd, ldl_writeoff_net_val, kfl_total_writeoff_net_val,
kfl_part_writeoff_net_val, kfl_buying_sales_net_val, kfl_sales_net_val, ldl_adjust_sales_net_val, ldl_adjust_sales_qty,
ldl_return_net_val, ldl_return_qty, ldl_pch_net_val, kfl_pch_net_val, dwh_created_tmsp, dwh_updated_tmsp, dwh_src_tmsp)
AS SELECT lob_cd,
 ldl_store_sid,
 ldl_item_sid,
 cal_dt,
 ldl_client_id,
 curr_cd,
 kfl_consolidated_promo_item_type_cd,
 ldl_writeoff_net_val,
 kfl_total_writeoff_net_val,
 kfl_part_writeoff_net_val,
 kfl_buying_sales_net_val,
  CASE
  WHEN lob_cd = 'KFL'
  THEN ldl_adjust_sales_net_val
  ELSE NULL
  END AS kfl_sales_net_val,
 ldl_adjust_sales_net_val,
 ldl_adjust_sales_qty,
 ldl_return_net_val,
 ldl_return_qty,
 ldl_pch_net_val,
 kfl_pch_net_val,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_src_tmsp
FROM nfpow_core.t_fact_ldl_store_item_day_1 AS MAIN;