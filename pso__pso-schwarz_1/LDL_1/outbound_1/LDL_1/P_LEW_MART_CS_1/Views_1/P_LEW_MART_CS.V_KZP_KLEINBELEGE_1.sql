/* 
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS.V_KZP_KLEINBELEGE_1
#----------------------------------------------------------------------------
# History:
#
#  V#   When       Who                         What
#  1.0  26.02.2021    Wachauf, Christian       Add filter on v_gen_item_hist_1 (only valid items considered) and item_Deleted_fg    
#  1.1  15.03.2021    Guenes, Oguzhan          Transfer to Snowflake.
#                                              https://jira.schwarz/browse/DDLE-1783
#                                              Create scripts for snowflake standardisation.
#  1.2  24.06.2021    Ross, Ulrich             Remove deleted_fg in subSelect for v_gen_item_hist_1 to get all items 
#  1.3  30.03.2022    Ross, Ulrich             Fix missing Kleinbelege while stores closed; User Story 306764
#----------------------------------------------------------------------------
*/



CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_kzp_kleinbelege_1 (client_id, country_iso_cd, dat_formdate, cy_month,
orig_item_nr, orig_store_nr, qty_total_sfo_asis, qty_total_sfo_wrtoff_zero_asis, sfotype_id, val_rtl_rcptline_sfo_asis,
val_rtl_rcptline_net_sfo_asis, val_wrtoff_zero_asis, val_wrtoff_zero_net_asis, price_wh_sfo_asis, price_wh_net_sfo_asis
, price_str_sfo_asis, price_str_net_sfo_asis, currency_iso_cd) AS -- Country_1
 SELECT AGG.client_id,
 T.src_country_lidl_cd AS country_iso_cd,
 AGG.booking_dat AS dat_formdate,
 AGG.cy_month,
 COALESCE(item.orig_item_nr, - 1) AS orig_item_nr,
 COALESCE(store.src_orig_store_nr, - 1) AS orig_store_nr,
 SUM(AGG.qty_total_sfo_asis) AS qty_total_sfo_asis,
 SUM(AGG.qty_total_sfo_wrtoff_zero_asis) AS qty_total_sfo_wrtoff_zero_asis,
 AGG.sfotype_id,
 CAST(SUM(AGG.val_rtl_rcptline_sfo_asis) AS NUMERIC) AS val_rtl_rcptline_sfo_asis,
 CAST(SUM(AGG.val_rtl_rl_net_sfo_asis) AS NUMERIC) AS val_rtl_rcptline_net_sfo_asis,
 CAST(SUM(AGG.val_wrtoff_zero_asis) AS NUMERIC) AS val_wrtoff_zero_asis,
 CAST(SUM(AGG.val_wrtoff_zero_net_asis) AS NUMERIC) AS val_wrtoff_zero_net_asis,
 CAST(MAX(AGG.price_wh_sfo_asis) AS NUMERIC) AS price_wh_sfo_asis,
 CAST(MAX(AGG.price_wh_net_sfo_asis) AS NUMERIC) AS price_wh_net_sfo_asis,
 CAST(MAX(AGG.price_str_sfo_asis) AS NUMERIC) AS price_str_sfo_asis,
 CAST(MAX(AGG.price_str_net_sfo_asis) AS NUMERIC) AS price_str_net_sfo_asis,
 AGG.currency_iso_cd
FROM ldl_p_lew_mart_cs.v_gen_agg_store_day_item_sfo_asis_1 AS AGG
 INNER JOIN ldl_p_lew_core_ac.v_client_1 AS C ON AGG.client_id = C.client_id
 INNER JOIN ldl_p_lew_core_ac.v_country_1 AS T ON C.country_sid = T.country_sid
 LEFT JOIN (SELECT client_id,
   item_sid,
   orig_item_nr
  FROM ldl_p_lew_mart_cs.v_gen_item_hist_1
  WHERE DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) BETWEEN valid_from AND valid_until
  GROUP BY client_id,
   item_sid,
   orig_item_nr) AS item_1 ON AGG.client_id = item.client_id AND AGG.item_sid_map = item.item_sid
 INNER JOIN (SELECT client_id,
   src_orig_store_nr
  FROM ldl_p_lew_mart_cs.v_gen_kzp_store_1
  GROUP BY client_id,
   src_orig_store_nr) AS store ON AGG.client_id = store.client_id AND AGG.src_orig_store_nr = store.src_orig_store_nr
GROUP BY AGG.client_id,
 country_iso_cd,
 dat_formdate,
 AGG.cy_month,
 orig_item_nr,
 orig_store_nr,
 AGG.sfotype_id,
 AGG.currency_iso_cd;

