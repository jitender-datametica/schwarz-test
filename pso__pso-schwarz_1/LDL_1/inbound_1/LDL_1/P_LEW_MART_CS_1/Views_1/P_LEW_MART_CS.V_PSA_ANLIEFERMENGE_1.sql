/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_PSA_ANLIEFERMENGE_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.1  06.03.2023    Bialek, Aleksander           Filtering for UWg extended to cover also newly added UWGs (between 200 and 399), ADO: 448371, it4you:PRJ0015189
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_PSA_ANLIEFERMENGE_1
(
  client_id
, dat_adv
, orig_item_nr
, wh_id
, booking_dat
, anl_letzte_40_tag
, anl_letzte_40_tag_test
)
AS
   SELECT
     adv.client_id
   , adv.dat_adv
   , agg_wh.orig_item_nr
   , agg_wh.wh_id
   , agg_wh.booking_dat
   , CASE WHEN agg_store.booking_dat BETWEEN adv.dat_adv-1-40.0 AND adv.dat_adv+10
             THEN agg_store.qty_total_sfo_asis
             ELSE 0
        END                                                                       AS anl_letzte_40_tag
   , CASE WHEN agg_store.booking_dat BETWEEN adv.dat_adv-1-40.0 AND adv.dat_adv+10 AND s.client_id IS NOT NULL AND agg_store.client_id IS NOT NULL
             THEN agg_store.qty_total_sfo_asis
             ELSE 0
        END                                                                       AS anl_letzte_40_tag_test
   FROM p_lew_mart_cs.v_gen_agg_store_day_item_sfo_asis_1 agg_store
   INNER JOIN p_lew_bil_ac.v_store_to_warehouse_lastknown_1 wh
   ON  agg_store.client_id = wh.client_id
   AND agg_store.loc_sid_store = wh.loc_sid_store
   INNER JOIN (SELECT
     agg.client_id
   , agg.item_sid
   , agg.booking_dat
   , agg.wh_id
   , i.valid_from
   , i.orig_item_nr
   FROM p_lew_mart_cs.v_gen_agg_wh_day_item_sfo_asis_1 agg
   INNER JOIN p_lew_mart_cs.v_gen_item_asis_1 i
   ON agg.client_id = i.client_id
   AND agg.item_sid = i.item_sid
   INNER JOIN p_lew_bil_ac.v_adv_orig_item_advertising_1 adv
   ON agg.client_id = adv.client_id
   AND agg.currency_iso_cd = adv.currency_iso_cd
   AND i.client_id = adv.client_id
   /*AND i.dat_valid_from = adv.dat_valid_from*/
   AND i.orig_item_nr = adv.orig_item_nr
   AND agg.wh_id = adv.wh_id
   AND agg.booking_dat BETWEEN adv.dat_adv-1-40.0 AND adv.dat_adv+10

   WHERE i.subitemgroup_id BETWEEN 100 AND 399
   AND adv.currency_iso_cd = 'EUR'
   AND agg.sfotype_id IN (135, 145)
   GROUP BY 1,2,3,4,5,6
  )  agg_wh
   ON agg_store.client_id = agg_wh.client_id
   AND agg_store.item_sid_map = agg_wh.item_sid
   AND wh.src_wh_id = agg_wh.wh_id
   AND agg_store.booking_dat = agg_wh.booking_dat
   INNER JOIN p_lew_bil_ac.v_adv_orig_item_advertising_1 adv
   ON  agg_store.client_id = adv.client_id
   AND agg_store.currency_iso_cd = adv.currency_iso_cd
   AND agg_wh.client_id = adv.client_id
   /*AND wh.dat_valid_from = adv.dat_valid_from*/
   AND agg_wh.orig_item_nr = adv.orig_item_nr AND agg_wh.wh_id = adv.wh_id
   AND agg_wh.wh_id = adv.wh_id
   AND adv.currency_iso_cd = 'EUR'
   AND agg_store.booking_dat BETWEEN adv.dat_adv-1-40.0 AND adv.dat_adv+10
   INNER JOIN (SELECT
     client_id
   , loc_sid_store
   , src_orig_store_nr
   , dwh_actual_fg
   , test_store_fg
   , pseudo_store_fg
   FROM p_lew_mart_cs.v_gen_store_1
              GROUP BY 1,2,3,4,5,6) s
   ON agg_store.client_id = s.client_id
   AND agg_store.loc_sid_store = s.loc_sid_store
   AND s.dwh_actual_fg = 1
   AND s.test_store_fg = 0
   AND s.pseudo_store_fg = 0

   WHERE  agg_store.sfotype_id IN (135, 145)
;