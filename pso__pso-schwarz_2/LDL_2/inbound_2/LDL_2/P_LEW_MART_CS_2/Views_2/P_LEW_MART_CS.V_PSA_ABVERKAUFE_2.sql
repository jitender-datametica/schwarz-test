/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_PSA_ABVERKAUFE_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.1  06.03.2023    Bialek, Aleksander           Filtering for UWg extended to cover also newly added UWGs (between 200 and 399), ADO: 448371, it4you:PRJ0015189
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_PSA_ABVERKAUFE_2
(client_id
, orig_item_nr
, dat_adv
, wh_id
, dat_valid_from
, avk_wt_1_tag_test
, avk_wt_3_tag_test
, avk_wt_7_tag_test
, avk_wt_1_tag
, avk_wt_3_tag
, avk_wt_7_tag
)
AS
   SELECT
     adv.client_id
   , i.orig_item_nr
   , adv.dat_adv
   , wh.src_wh_id          AS wh_id
   , i.valid_from          AS dat_valid_from
   , CASE WHEN (CASE WHEN adv.client_id IS NOT NULL AND agg_store.dat_formdate BETWEEN adv.dat_adv-5 AND adv.dat_adv
          THEN ((agg_store.qty_piece_ejr_asis + agg_store.qty_weight_ejr_asis) + agg_store.qty_return_ejr_asis)
          ELSE 0 END) = 0 THEN NULL ELSE (CASE WHEN adv.client_id IS NOT NULL AND agg_store.dat_formdate BETWEEN adv.dat_adv-5 AND adv.dat_adv
     THEN ((agg_store.qty_piece_ejr_asis + agg_store.qty_weight_ejr_asis) + agg_store.qty_return_ejr_asis)
     ELSE 0 END) END AS avk_wt_1_tag_test
   , CASE WHEN (CASE WHEN adv.client_id IS NOT NULL AND agg_store.dat_formdate BETWEEN adv.dat_adv-5 AND adv.dat_adv+2
          THEN ((agg_store.qty_piece_ejr_asis + agg_store.qty_weight_ejr_asis) + agg_store.qty_return_ejr_asis)
          ELSE 0 END) = 0 THEN NULL ELSE (CASE WHEN adv.client_id IS NOT NULL AND agg_store.dat_formdate BETWEEN adv.dat_adv-5 AND adv.dat_adv+2
     THEN ((agg_store.qty_piece_ejr_asis + agg_store.qty_weight_ejr_asis) + agg_store.qty_return_ejr_asis)
     ELSE 0 END) END AS avk_wt_3_tag_test
   , CASE WHEN (CASE WHEN adv.client_id IS NOT NULL AND agg_store.dat_formdate BETWEEN adv.dat_adv-5 AND adv.dat_adv+6
          THEN ((agg_store.qty_piece_ejr_asis + agg_store.qty_weight_ejr_asis) + agg_store.qty_return_ejr_asis)
          ELSE 0 END) = 0 THEN NULL ELSE (CASE WHEN adv.client_id IS NOT NULL AND agg_store.dat_formdate BETWEEN adv.dat_adv-5 AND adv.dat_adv+6
     THEN ((agg_store.qty_piece_ejr_asis + agg_store.qty_weight_ejr_asis) + agg_store.qty_return_ejr_asis)
     ELSE 0 END) END AS avk_wt_7_tag_test
   , CASE WHEN (CASE WHEN agg_store.dat_formdate BETWEEN adv.dat_adv-5 AND adv.dat_adv
          THEN ((agg_store.qty_piece_ejr_asis + agg_store.qty_weight_ejr_asis) + agg_store.qty_return_ejr_asis)
     ELSE 0 END) = 0 THEN NULL ELSE (CASE WHEN agg_store.dat_formdate BETWEEN adv.dat_adv-5 AND adv.dat_adv
     THEN ((agg_store.qty_piece_ejr_asis + agg_store.qty_weight_ejr_asis) + agg_store.qty_return_ejr_asis)
     ELSE 0 END) END AS avk_wt_1_tag
   , CASE WHEN (CASE WHEN agg_store.dat_formdate BETWEEN adv.dat_adv-5 AND adv.dat_adv+2
          THEN ((agg_store.qty_piece_ejr_asis + agg_store.qty_weight_ejr_asis) + agg_store.qty_return_ejr_asis)
     ELSE 0 END) = 0 THEN NULL ELSE (CASE WHEN agg_store.dat_formdate BETWEEN adv.dat_adv-5 AND adv.dat_adv+2
     THEN ((agg_store.qty_piece_ejr_asis + agg_store.qty_weight_ejr_asis) + agg_store.qty_return_ejr_asis)
     ELSE 0 END) END AS avk_wt_3_tag
   , CASE WHEN (CASE WHEN agg_store.dat_formdate BETWEEN adv.dat_adv-5 AND adv.dat_adv+6
          THEN ((agg_store.qty_piece_ejr_asis + agg_store.qty_weight_ejr_asis) + agg_store.qty_return_ejr_asis)
          ELSE 0 END) = 0 THEN NULL ELSE (CASE WHEN agg_store.dat_formdate BETWEEN adv.dat_adv-5 AND adv.dat_adv+6
          THEN ((agg_store.qty_piece_ejr_asis + agg_store.qty_weight_ejr_asis) + agg_store.qty_return_ejr_asis)
     ELSE 0 END) END AS avk_wt_7_tag
   FROM p_lew_mart_cs.v_gen_agg_store_day_item_ejr_asis_2 agg_store
   INNER JOIN p_lew_bil_ac.v_store_to_warehouse_lastknown_2 wh
   ON  agg_store.client_id = wh.client_id
   AND agg_store.store_id = wh.loc_sid_store
   INNER JOIN (SELECT
     agg.client_id
   , agg.item_sid
   , agg.dwh_cal_dt
   , agg.wh_id
   , i.valid_from
   , i.orig_item_nr
   FROM p_lew_mart_cs.v_gen_agg_wh_day_item_ejr_asis_2 agg
   INNER JOIN p_lew_mart_cs.v_gen_item_asis_2 i
   ON agg.client_id = i.client_id
   AND agg.item_sid = i.item_sid
   INNER JOIN p_lew_bil_ac.v_adv_orig_item_advertising_2 adv
   ON  agg.client_id = adv.client_id
   /*AND a15.dat_valid_from = adv.dat_valid_from*/
   AND i.orig_item_nr = adv.orig_item_nr
   AND agg.wh_id = adv.wh_id
   AND agg.dwh_cal_dt BETWEEN adv.dat_adv-5 AND adv.dat_adv+6

   WHERE adv.currency_iso_cd = 'EUR'
   AND i.subitemgroup_id BETWEEN 100 AND 399

   GROUP BY 1,2,3,4,5,6
   )  agg_wh
   ON agg_store.client_id = agg_wh.client_id
   AND agg_store.item_id = agg_wh.item_sid
   AND wh.src_wh_id = agg_wh.wh_id
   AND agg_store.dat_formdate = agg_wh.dwh_cal_dt
   INNER JOIN (SELECT
     client_id
   , loc_sid_store
   , src_orig_store_nr
   , dwh_actual_fg
   , test_store_fg
   , pseudo_store_fg
   FROM p_lew_mart_cs.v_gen_store_2
              GROUP BY 1,2,3,4,5,6) s
   ON agg_store.client_id = s.client_id
   AND agg_store.store_id = s.loc_sid_store
   AND s.dwh_actual_fg = 1
   AND s.test_store_fg = 0
   AND s.pseudo_store_fg = 0
   INNER JOIN p_lew_mart_cs.v_gen_item_asis_2 i
   ON agg_store.client_id = i.client_id
   AND agg_store.item_id = i.item_sid
   INNER JOIN p_lew_bil_ac.v_adv_orig_item_advertising_2 adv
   ON agg_store.client_id = adv.client_id
   AND agg_store.currency_iso_cd = adv.currency_iso_cd
   AND i.client_id = adv.client_id
   /*AND a15.dat_valid_from = adv.dat_valid_from*/
   AND i.orig_item_nr = adv.orig_item_nr
   AND wh.client_id = adv.client_id
   AND wh.src_wh_id = adv.wh_id
   AND agg_store.dat_formdate BETWEEN adv.dat_adv-5 AND adv.dat_adv+6
   AND wh.src_wh_id = adv.wh_id

   WHERE adv.currency_iso_cd = 'EUR'
   AND i.subitemgroup_id BETWEEN 100 AND 399
;