/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_KZP_KASSENDATEN
#----------------------------------------------------------------------------
#  Version      When       Who                   What
#  1.0    2021-02-26    Wachauf, Christian    Add filter on v_gen_item_hist (only valid items considered)     
#  1.1    15.03.2021    Guenes, Oguzhan               Transfer to Snowflake.
#                                           https://jira.schwarz/browse/DDLE-1783
#                                           Create scripts for snowflake standardisation.
#  1.3    24.06.2021    Ross, Ulrich          Remove deleted_fg in subSelect for v_gen_item_hist to get all items 
#  1.4    16.08.2021    Ross,Ulrich           Erweiterung um LidlPlus Daten
#                                           (sales_net_lp_val_ejr_asis,discount_net_lp_val_ejr_asis,piece_weight_lp_qty_ejr_asis)
#                                           https://jira.schwarz/browse/DDLE-2558
#  1.5    30.03.2022    Ross, Ulrich        Fix missing Filialbestand while stores closed; User Story 306764
#----------------------------------------------------------------------------
*/




CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_kzp_kassendaten (client_id, country_iso_cd, cnt_discount_ejr_asis,
cnt_retail_ejr_asis, cnt_return_ejr_asis, dat_formdate, orig_item_nr, orig_store_nr, price_rtl_net_ejr_adjstd_asis,
price_rtl_ejr_asis, price_rtl_net_ejr_asis, qty_disc_piece_ejr_asis, qty_disc_weight_ejr_asis,
qty_disc_piece_weight_ejr_asis, qty_piece_ejr_asis, qty_return_ejr_asis, val_disc_rtl_gross_ejr_asis,
val_disc_rtl_net_ejr_asis, val_void_ejr_asis, val_void_net_ejr_asis, val_rtl_net_ejr_asis, val_return_net_ejr_asis,
qty_piece_weight_ejr_asis, qty_rt_piece_weight_ejr_asis, qty_rt_pc_wt_saleable_ejr_asis, sales_net_lp_val_ejr_asis,
discount_net_lp_val_ejr_asis, piece_weight_lp_qty_ejr_asis, currency_iso_cd) AS -- SALES_VALUE_NET_lp

-- DISCOUNT_PRICE_NET_lp
 -- SALES_AMOUNT_PIECES_lp
 -- Country
 SELECT AGG.client_id,
 T.src_country_lidl_cd AS country_iso_cd,
 SUM(AGG.cnt_discount_ejr_asis) AS cnt_discount_ejr_asis,
 SUM(AGG.cnt_retail_ejr_asis) AS cnt_retail_ejr_asis,
 SUM(AGG.cnt_return_ejr_asis) AS cnt_return_ejr_asis,
 AGG.dat_formdate,
 COALESCE(item.orig_item_nr, - 1) AS orig_item_nr,
 COALESCE(store.src_orig_store_nr, - 1) AS orig_store_nr,
 CAST(MAX(AGG.price_rtl_net_ejr_adjstd_asis) AS NUMERIC) AS price_rtl_net_ejr_adjstd_asis,
 CAST(MAX(AGG.price_rtl_ejr_asis) AS NUMERIC) AS price_rtl_ejr_asis,
 CAST(MAX(AGG.price_rtl_net_ejr_asis) AS NUMERIC) AS price_rtl_net_ejr_asis,
 CAST(SUM(AGG.qty_disc_piece_ejr_asis) AS NUMERIC) AS qty_disc_piece_ejr_asis,
 CAST(SUM(AGG.qty_disc_weight_ejr_asis) AS NUMERIC) AS qty_disc_weight_ejr_asis,
 CAST(SUM(AGG.qty_disc_piece_weigth_ejr_asis) AS NUMERIC) AS qty_disc_piece_weight_ejr_asis,
 CAST(SUM(AGG.qty_piece_ejr_asis) AS NUMERIC) AS qty_piece_ejr_asis,
 CAST(SUM(AGG.qty_return_ejr_asis) AS NUMERIC) AS qty_return_ejr_asis,
 CAST(SUM(AGG.val_disc_rtl_gross_ejr_asis) AS NUMERIC) AS val_disc_rtl_gross_ejr_asis,
 CAST(SUM(AGG.val_disc_rtl_net_ejr_asis) AS NUMERIC) AS val_disc_rtl_net_ejr_asis,
 CAST(SUM(AGG.val_void_ejr_asis) AS NUMERIC) AS val_void_ejr_asis,
 CAST(SUM(AGG.val_void_net_ejr_asis) AS NUMERIC) AS val_void_net_ejr_asis,
  CAST(SUM(AGG.val_rtl_net_ejr_asis) AS NUMERIC) - CAST(SUM(AGG.sales_net_lp_val_ejr_asis) AS NUMERIC) AS
 val_rtl_net_ejr_asis,
 CAST(SUM(AGG.val_return_net_ejr_asis) AS NUMERIC) AS val_return_net_ejr_asis,
  CAST(SUM(AGG.qty_piece_weight_ejr_asis) AS NUMERIC) - CAST(SUM(AGG.piece_weight_lp_qty_ejr_asis) AS NUMERIC) AS
 qty_piece_weight_ejr_asis,
 CAST(SUM(AGG.qty_rt_piece_weight_ejr_asis) AS NUMERIC) AS qty_rt_piece_weight_ejr_asis,
 CAST(SUM(AGG.qty_rt_pc_wt_saleable_ejr_asis) AS NUMERIC) AS qty_rt_pc_wt_saleable_ejr_asis,
 CAST(SUM(AGG.sales_net_lp_val_ejr_asis) AS NUMERIC) AS sales_net_lp_val_ejr_asis,
 CAST(SUM(AGG.discount_net_lp_val_ejr_asis) AS NUMERIC) AS discount_net_lp_val_ejr_asis,
 CAST(SUM(AGG.piece_weight_lp_qty_ejr_asis) AS NUMERIC) AS piece_weight_lp_qty_ejr_asis,
 AGG.currency_iso_cd
FROM ldl_p_lew_mart_cs.v_gen_agg_store_day_item_ejr_asis AS AGG
 INNER JOIN ldl_p_lew_core_ac.v_client AS C ON AGG.client_id = C.client_id
 INNER JOIN ldl_p_lew_core_ac.v_country AS T ON C.country_sid = T.country_sid
 LEFT JOIN (SELECT client_id,
   item_sid,
   orig_item_nr
  FROM ldl_p_lew_mart_cs.v_gen_item_hist
  WHERE DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) BETWEEN valid_from AND valid_until
  GROUP BY client_id,
   item_sid,
   orig_item_nr) AS item ON AGG.client_id = item.client_id AND AGG.item_id = item.item_sid
 INNER JOIN (SELECT client_id,
   src_orig_store_nr
  FROM ldl_p_lew_mart_cs.v_gen_kzp_store
  WHERE src_wh_id <> src_orig_store_nr
  GROUP BY client_id,
   src_orig_store_nr) AS store ON AGG.client_id = store.client_id AND AGG.orig_store_nr = store.src_orig_store_nr
GROUP BY AGG.client_id,
 country_iso_cd,
 AGG.dat_formdate,
 orig_item_nr,
 orig_store_nr,
 AGG.currency_iso_cd;


