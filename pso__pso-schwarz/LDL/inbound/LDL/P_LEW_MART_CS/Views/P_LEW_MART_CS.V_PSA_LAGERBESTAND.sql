/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_PSA_LAGERBESTAND
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.1  06.03.2023    Bialek, Aleksander           filtering for UWg extended to cover also newly added UWGs (between 200 and 399), ADO: 448371, it4you:PRJ0015189
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_PSA_LAGERBESTAND
(
  client_id
, adv_dt
, orig_item_nr
, src_wh_id
, valid_from
, store_cnt
, anl_letzte_40_tag
, anl_letzte_40_tag_test
)
AS
   SELECT
     adv.client_id
   , adv.dat_adv                       AS adv_dt
   , agg_wh.orig_item_nr
   , agg_wh.src_wh_id
   , agg_wh.valid_from
   , CASE WHEN agg_store.dat_formdate BETWEEN adv.dat_adv - 40 AND adv.dat_adv + 10
                 AND agg_store.deliverytype_id = 1
                 AND ROW_NUMBER () OVER (PARTITION BY adv.client_id
				                                    , adv.dat_adv
													, agg_wh.orig_item_nr
													, agg_wh.src_wh_id
													, agg_wh.valid_from
													, agg_store.loc_sid_store
                                         ORDER BY (CASE WHEN agg_store.dat_formdate BETWEEN adv.dat_adv - 40  AND adv.dat_adv + 10 AND agg_store.deliverytype_id = 1 THEN 1 ELSE 0 END ) DESC NULLS LAST ) = 1
             THEN 1
             ELSE 0
        END AS store_cnt
   , CASE WHEN agg_store.dat_formdate BETWEEN adv.dat_adv-1-40.0 AND adv.dat_adv+10
             THEN agg_store.qty_total_del_asis
             ELSE 0
        END AS anl_letzte_40_tag
   , CASE WHEN agg_store.dat_formdate BETWEEN adv.dat_adv-1-40.0 AND adv.dat_adv+10
                 AND s.client_id IS NOT NULL
                 AND agg_store.client_id IS NOT NULL
             THEN agg_store.qty_total_del_asis
             ELSE 0
        END AS anl_letzte_40_tag_test
   FROM p_lew_mart_cs.v_gen_agg_store_day_item_del_asis agg_store
   INNER JOIN (SELECT
     client_id
   , loc_sid_store
   , src_wh_id
   FROM p_lew_bil_ac.v_store_to_warehouse_lastknown
              ) stwl
   ON agg_store.client_id = stwl.client_id
   AND agg_store.loc_sid_store = stwl.loc_sid_store
   INNER JOIN (SELECT
     agg.client_id
   , agg.item_sid
   , agg.dat_formdate
   , agg.src_wh_id
   , i.valid_from
   , i.orig_item_nr
   FROM p_lew_mart_cs.v_gen_agg_wh_day_item_del_asis agg
   INNER JOIN p_lew_mart_cs.v_gen_item_asis i
   ON agg.client_id = i.client_id
   AND agg.item_sid = i.item_sid
   INNER JOIN p_lew_bil_ac.v_adv_orig_item_advertising adv
   ON agg.client_id = adv.client_id
   AND agg.curr_cd_from = adv.currency_iso_cd
   AND i.client_id = adv.client_id
   /*AND i.dat_valid_from = adv.dat_valid_from*/
   AND i.orig_item_nr = adv.orig_item_nr
   AND agg.src_wh_id = adv.wh_id
   AND agg.dat_formdate BETWEEN adv.dat_adv-1-40.0 AND adv.dat_adv+10

   WHERE i.subitemgroup_id BETWEEN 100 AND 399
   AND adv.currency_iso_cd = 'EUR'
   GROUP BY 1
   ,2
   ,3
   ,4
   ,5
   ,6
)  agg_wh
   ON agg_store.client_id = agg_wh.client_id
   AND agg_store.item_sid_map = agg_wh.item_sid
   AND stwl.src_wh_id = agg_wh.src_wh_id
   AND agg_store.dat_formdate = agg_wh.dat_formdate
   INNER JOIN p_lew_bil_ac.v_adv_orig_item_advertising adv
   ON agg_store.client_id = adv.client_id
   AND agg_store.currency_iso_cd = adv.currency_iso_cd
   AND agg_wh.client_id = adv.client_id
   /*AND agg_wh.dat_valid_from = adv.dat_valid_from*/
   AND agg_wh.orig_item_nr = adv.orig_item_nr
   AND agg_wh.src_wh_id = adv.wh_id
   AND stwl.src_wh_id = adv.wh_id
   AND adv.currency_iso_cd = 'EUR'
   AND agg_store.dat_formdate BETWEEN adv.dat_adv-1-40.0 AND adv.dat_adv+10
   LEFT OUTER JOIN (SELECT
     client_id
   , loc_sid_store
   , src_orig_store_nr
   , dwh_actual_fg
   , test_store_fg
   , pseudo_store_fg
   FROM p_lew_mart_cs.v_gen_store
                   GROUP BY 1
				   ,2
				   ,3
				   ,4
				   ,5
				   ,6) s
   ON agg_store.client_id = s.client_id
   AND agg_store.loc_sid_store = s.loc_sid_store
   AND s.dwh_actual_fg = 1
   AND s.test_store_fg = 0
   AND s.pseudo_store_fg = 0
;