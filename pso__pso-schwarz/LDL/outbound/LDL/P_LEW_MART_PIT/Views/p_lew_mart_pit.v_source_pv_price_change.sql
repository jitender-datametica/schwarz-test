/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for P_LEW_MART_PIT.V_SOURCE_PV_PRICE_CHANGE
#-------------------------------------------------------------------------------
# Describtion: Create View for V_SOURCE_PV_PRICE_CHANGE
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2024-01-04 Andreas Kurz		Initial version
#									No additional Logic included
#  1.1 	2024-08-08 Andreas Kurz		Distinct was removed
#  1.2  2025-01-28 Nikolai Toknov	Restore view
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001; -- new Clone
USE SCHEMA 		P_LEW_MART_PIT;
 */
/* 
---------------------------------------------------------------------
0. Create View Table in V_SOURCE_PV_PRICE_CHANGE
------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_pit.v_source_pv_price_change
OPTIONS(DESCRIPTION = `PIT SOURCE VIEW FOR PV PRICE CHANGE TABLE`) AS SELECT pc.client_id,
 pc.store_sid,
 pc.day_dt,
 pc.orig_item_nr,
 pc.item_sid,
 pc.pcwo_reason_id,
 pc.pcwo_reason_desc,
 pc.pch_day_pricegroup_fg,
 pc.discount_value_promodesigner,
 pc.discount_value_lidlplus,
 pc.pch_baseline_fg,
 pc.dwh_created_ts,
 pc.dwh_updated_ts
FROM (SELECT client_id,
   loc_sid_store AS store_sid,
   dwh_cal_dt AS day_dt,
   orig_item_nr,
   item_sid,
   pcwo_reason_id,
   pcwo_reason_desc,
   pch_day_pricegroup_fg,
   discount_value_promodesigner,
   discount_value_lidlplus,
   pch_baseline_fg,
   dwh_load_id,
   dwh_created AS dwh_created_ts,
   dwh_updated AS dwh_updated_ts
  FROM ldl_p_lew_bil.t_store_day_item_price_change) AS pc
 INNER JOIN (SELECT DISTINCT client_id,
   country_orig_descr,
   country_int_descr,
   country_nat_descr,
   country_descr,
   country_iso_cd,
   lang_sid,
   curr_sid,
   curr_cd,
   exchange_rate_to_eur,
   valid_from_dt,
   ctr_ex_elvis_country_fg,
   ctr_ex_elvis_country_migration_date_from,
   ctr_ex_elvis_country_migration_date_to,
   ctr_adv_week_start_weekday_id
  FROM ldl_p_lew_mart_pit.t_dim_client
  WHERE pit_country_fg = 1
   AND deleted_fg = 0
   AND reject_fg = 0
   AND current_fg = 1) AS cl ON pc.client_id = cl.client_id;