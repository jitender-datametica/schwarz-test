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


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_psa_anliefermenge_1 (client_id, dat_adv, orig_item_nr, wh_id, booking_dat,
anl_letzte_40_tag, anl_letzte_40_tag_test) AS SELECT ADV0.client_id,
 ADV0.dat_adv,
 agg_wh.orig_item_nr,
 agg_wh.wh_id,
 agg_wh.booking_dat,
  CASE
  WHEN AGG_STORE.booking_dat BETWEEN DATE_SUB(DATE_SUB(ADV0.dat_adv, INTERVAL 1 DAY), INTERVAL CAST(ROUND(40.0) AS INTEGER)
    DAY) AND (DATE_ADD(ADV0.dat_adv, INTERVAL 10 DAY))
  THEN AGG_STORE.qty_total_sfo_asis
  ELSE 0
  END AS anl_letzte_40_tag,
  CASE
  WHEN AGG_STORE.booking_dat BETWEEN DATE_SUB(DATE_SUB(ADV0.dat_adv, INTERVAL 1 DAY), INTERVAL CAST(ROUND(40.0) AS INTEGER)
      DAY) AND (DATE_ADD(ADV0.dat_adv, INTERVAL 10 DAY)) AND s.client_id IS NOT NULL AND AGG_STORE.client_id
   IS NOT NULL
  THEN AGG_STORE.qty_total_sfo_asis
  ELSE 0
  END AS anl_letzte_40_tag_test
FROM ldl_p_lew_mart_cs.v_gen_agg_store_day_item_sfo_asis_1 AS AGG_STORE
 INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_lastknown_1 AS WH ON AGG_STORE.client_id = WH.client_id AND AGG_STORE.loc_sid_store
    = WH.loc_sid_store
 INNER JOIN (SELECT AGG.client_id,
   AGG.item_sid,
   AGG.booking_dat,
   AGG.wh_id,
   I.valid_from,
   I.orig_item_nr
  FROM ldl_p_lew_mart_cs.v_gen_agg_wh_day_item_sfo_asis_1 AS AGG
   INNER JOIN ldl_p_lew_mart_cs.v_gen_item_asis_1 AS I ON AGG.client_id = I.client_id AND AGG.item_sid = I.item_sid
   INNER JOIN ldl_p_lew_bil_ac.v_adv_orig_item_advertising_1 AS ADV ON AGG.client_id = ADV.client_id AND AGG.currency_iso_cd
          = ADV.currency_iso_cd AND I.client_id = ADV.client_id /* AND i.dat_valid_from = adv.dat_valid_from */ AND I.orig_item_nr
        = ADV.orig_item_nr AND AGG.wh_id = ADV.wh_id AND AGG.booking_dat BETWEEN DATE_SUB(DATE_SUB(ADV.dat_adv, INTERVAL
       1 DAY), INTERVAL CAST(ROUND(40.0) AS INTEGER) DAY) AND (DATE_ADD(ADV.dat_adv, INTERVAL 10 DAY))
  WHERE I.subitemgroup_id BETWEEN 100 AND 399
   AND ADV.currency_iso_cd = 'EUR'
   AND AGG.sfotype_id IN (135, 145)
  GROUP BY AGG.client_id,
   AGG.wh_id,
   AGG.item_sid,
   AGG.booking_dat,
   I.orig_item_nr,
   I.valid_from) AS agg_wh ON AGG_STORE.client_id = agg_wh.client_id AND AGG_STORE.item_sid_map = agg_wh.item_sid AND WH
    .src_wh_id = agg_wh.wh_id AND AGG_STORE.booking_dat = agg_wh.booking_dat
 INNER JOIN ldl_p_lew_bil_ac.v_adv_orig_item_advertising_1 AS ADV0 ON AGG_STORE.client_id = ADV0.client_id AND AGG_STORE.currency_iso_cd
         = ADV0.currency_iso_cd AND agg_wh.client_id = ADV0.client_id /* AND wh.dat_valid_from = adv.dat_valid_from */
     AND agg_wh.orig_item_nr = ADV0.orig_item_nr AND agg_wh.wh_id = ADV0.wh_id AND ADV0.currency_iso_cd = 'EUR' AND
   AGG_STORE.booking_dat BETWEEN DATE_SUB(DATE_SUB(ADV0.dat_adv, INTERVAL 1 DAY), INTERVAL CAST(ROUND(40.0) AS INTEGER)
    DAY) AND (DATE_ADD(ADV0.dat_adv, INTERVAL 10 DAY))
 INNER JOIN (SELECT client_id,
   loc_sid_store,
   src_orig_store_nr,
   dwh_actual_fg,
   test_store_fg,
   pseudo_store_fg
  FROM ldl_p_lew_mart_cs.v_gen_store_1
  GROUP BY client_id,
   loc_sid_store,
   src_orig_store_nr,
   test_store_fg,
   pseudo_store_fg,
   dwh_actual_fg) AS s ON AGG_STORE.client_id = s.client_id AND AGG_STORE.loc_sid_store = s.loc_sid_store AND s.dwh_actual_fg
      = 1 AND s.test_store_fg = 0 AND s.pseudo_store_fg = 0
WHERE AGG_STORE.sfotype_id IN (135, 145);