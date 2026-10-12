/* 
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_KZP_FILIALANLIEFERUNGEN_2
#----------------------------------------------------------------------------
# History:
# V#   When          Who                   What
# 1.0  26.02.2021    Wachauf, Christian    Add filter on v_gen_item_hist_2 (only valid items considered)     
# 1.1  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                          https://jira.schwarz/browse/DDLE-1783
#                                          Create scripts for snowflake standardisation.
# 1.3  24.06.2021    Ross, Ulrich          Remove deleted_fg in subSelect for v_gen_item_hist_2 to get all items 
# 1.4  30.03.2022    Ross, Ulrich          Fix missing Filalanlieferungen while stores closed; User Story 306764
#----------------------------------------------------------------------------
*/



CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_kzp_filialanlieferungen_2 (client_id, country_iso_cd, dat_formdate, cy_month,
deliverytype_id, orig_item_nr, src_orig_store_nr, qty_total_del_asis, val_rtl_rl_del_asis, val_rtl_rl_net_del_asis,
qty_piece_del_asis, val_piece_del_asis, val_piece_net_del_asis, val_pr_diff_del, val_pr_diff_net_del, currency_iso_cd)
AS SELECT AGG.client_id,
 T.src_country_lidl_cd AS country_iso_cd,
 AGG.dat_formdate,
 AGG.cy_month,
 AGG.deliverytype_id,
 COALESCE(item.orig_item_nr, - 1) AS orig_item_nr,
 COALESCE(store.src_orig_store_nr, - 1) AS src_orig_store_nr,
 CAST(SUM(AGG.qty_total_del_asis) AS NUMERIC) AS qty_total_del_asis,
 CAST(SUM(AGG.val_rtl_rl_del_asis) AS NUMERIC) AS val_rtl_rl_del_asis,
 CAST(SUM(AGG.val_rtl_rl_net_del_asis) AS NUMERIC) AS val_rtl_rl_net_del_asis,
 CAST(SUM(AGG.qty_piece_del_asis) AS NUMERIC) AS qty_piece_del_asis,
 CAST(SUM(AGG.val_piece_del_asis) AS NUMERIC) AS val_piece_del_asis,
 CAST(SUM(AGG.val_piece_net_del_asis) AS NUMERIC) AS val_piece_net_del_asis,
 COALESCE(CAST(SUM(AGG.val_pr_diff_del) AS NUMERIC), 0) AS val_pr_diff_del,
 COALESCE(CAST(SUM(AGG.val_pr_diff_net_del) AS NUMERIC), 0) AS val_pr_diff_net_del,
 AGG.currency_iso_cd
FROM ldl_p_lew_mart_cs.v_gen_agg_store_day_item_del_asis_2 AS AGG
 LEFT JOIN (SELECT client_id,
   item_sid,
   orig_item_nr
  FROM ldl_p_lew_mart_cs.v_gen_item_hist_2
  WHERE DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) BETWEEN valid_from AND valid_until
  GROUP BY client_id,
   item_sid,
   orig_item_nr) AS item_2 ON AGG.client_id = item.client_id AND AGG.item_sid_map -- Country_2
 = item.item_sid
 INNER JOIN ldl_p_lew_core_ac.v_client_2 AS C ON item.client_id = C.client_id
 INNER JOIN ldl_p_lew_core_ac.v_country_2 AS T ON C.country_sid = T.country_sid
 INNER JOIN (SELECT client_id,
   loc_sid_store,
   src_orig_store_nr
  FROM ldl_p_lew_mart_cs.v_gen_kzp_store_2
  WHERE src_wh_id <> src_orig_store_nr
  GROUP BY client_id,
   loc_sid_store,
   src_orig_store_nr) AS store ON AGG.client_id = store.client_id AND AGG.loc_sid_store = store.loc_sid_store
GROUP BY AGG.client_id,
 country_iso_cd,
 AGG.dat_formdate,
 AGG.cy_month,
 AGG.deliverytype_id,
 orig_item_nr,
 src_orig_store_nr,
 AGG.currency_iso_cd;

