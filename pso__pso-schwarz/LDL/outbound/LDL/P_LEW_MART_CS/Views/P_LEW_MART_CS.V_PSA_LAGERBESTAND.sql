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


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_psa_lagerbestand (client_id, adv_dt, orig_item_nr, src_wh_id, valid_from,
store_cnt, anl_letzte_40_tag, anl_letzte_40_tag_test) AS SELECT ADV0.client_id,
 ADV0.dat_adv AS adv_dt,
 agg_wh.orig_item_nr,
 agg_wh.src_wh_id,
 agg_wh.valid_from,
  CASE
  WHEN AGG_STORE.dat_formdate BETWEEN DATE_SUB(ADV0.dat_adv, INTERVAL 40 DAY) AND (DATE_ADD(ADV0.dat_adv, INTERVAL 10
       DAY)) AND AGG_STORE.deliverytype_id = 1 AND (ROW_NUMBER() OVER (PARTITION BY CAST(ADV0.client_id AS STRING), ADV0
        .dat_adv, agg_wh.orig_item_nr, CAST(agg_wh.src_wh_id AS STRING), agg_wh.valid_from, CAST(AGG_STORE.loc_sid_store AS STRING)
        ORDER BY CASE
         WHEN AGG_STORE.dat_formdate BETWEEN DATE_SUB(ADV0.dat_adv, INTERVAL 40 DAY) AND (DATE_ADD(ADV0.dat_adv,
             INTERVAL 10 DAY)) AND AGG_STORE.deliverytype_id = 1
         THEN 1
         ELSE 0
         END IS NULL, CASE
         WHEN AGG_STORE.dat_formdate BETWEEN DATE_SUB(ADV0.dat_adv, INTERVAL 40 DAY) AND (DATE_ADD(ADV0.dat_adv,
             INTERVAL 10 DAY)) AND AGG_STORE.deliverytype_id = 1
         THEN 1
         ELSE 0
         END)) = 1
  THEN 1
  ELSE 0
  END AS store_cnt,
  CASE
  WHEN AGG_STORE.dat_formdate BETWEEN DATE_SUB(DATE_SUB(ADV0.dat_adv, INTERVAL 1 DAY), INTERVAL CAST(ROUND(40.0) AS INTEGER)
    DAY) AND (DATE_ADD(ADV0.dat_adv, INTERVAL 10 DAY))
  THEN AGG_STORE.qty_total_del_asis
  ELSE 0
  END AS anl_letzte_40_tag,
  CASE
  WHEN AGG_STORE.dat_formdate BETWEEN DATE_SUB(DATE_SUB(ADV0.dat_adv, INTERVAL 1 DAY), INTERVAL CAST(ROUND(40.0) AS INTEGER)
      DAY) AND (DATE_ADD(ADV0.dat_adv, INTERVAL 10 DAY)) AND s.client_id IS NOT NULL AND AGG_STORE.client_id
   IS NOT NULL
  THEN AGG_STORE.qty_total_del_asis
  ELSE 0
  END AS anl_letzte_40_tag_test
FROM ldl_p_lew_mart_cs.v_gen_agg_store_day_item_del_asis AS AGG_STORE
 INNER JOIN (SELECT client_id,
   loc_sid_store,
   src_wh_id
  FROM ldl_p_lew_bil_ac.v_store_to_warehouse_lastknown) AS stwl ON AGG_STORE.client_id = stwl.client_id AND AGG_STORE.loc_sid_store
    = stwl.loc_sid_store
 INNER JOIN (SELECT AGG.client_id,
   AGG.item_sid,
   AGG.dat_formdate,
   AGG.src_wh_id,
   I.valid_from,
   I.orig_item_nr
  FROM ldl_p_lew_mart_cs.v_gen_agg_wh_day_item_del_asis AS AGG
   INNER JOIN ldl_p_lew_mart_cs.v_gen_item_asis AS I ON AGG.client_id = I.client_id AND AGG.item_sid = I.item_sid
   INNER JOIN ldl_p_lew_bil_ac.v_adv_orig_item_advertising AS ADV ON AGG.client_id = ADV.client_id AND AGG.curr_cd_from
         = ADV.currency_iso_cd AND I.client_id = ADV.client_id /* AND i.dat_valid_from = adv.dat_valid_from */ AND I.orig_item_nr
        = ADV.orig_item_nr AND AGG.src_wh_id = ADV.wh_id AND AGG.dat_formdate BETWEEN DATE_SUB(DATE_SUB(ADV.dat_adv,
       INTERVAL 1 DAY), INTERVAL CAST(ROUND(40.0) AS INTEGER) DAY) AND (DATE_ADD(ADV.dat_adv, INTERVAL 10 DAY))
  WHERE I.subitemgroup_id BETWEEN 100 AND 399
   AND ADV.currency_iso_cd = 'EUR'
  GROUP BY AGG.client_id,
   AGG.src_wh_id,
   AGG.item_sid,
   AGG.dat_formdate,
   I.orig_item_nr,
   I.valid_from) AS agg_wh ON AGG_STORE.client_id = agg_wh.client_id AND AGG_STORE.item_sid_map = agg_wh.item_sid AND
    stwl.src_wh_id = agg_wh.src_wh_id AND AGG_STORE.dat_formdate = agg_wh.dat_formdate
 INNER JOIN ldl_p_lew_bil_ac.v_adv_orig_item_advertising AS ADV0 ON AGG_STORE.client_id = ADV0.client_id AND AGG_STORE.currency_iso_cd
          = ADV0.currency_iso_cd AND agg_wh.client_id = ADV0.client_id
        /* AND agg_wh.dat_valid_from = adv.dat_valid_from */ AND agg_wh.orig_item_nr = ADV0.orig_item_nr AND agg_wh.src_wh_id
       = ADV0.wh_id AND stwl.src_wh_id = ADV0.wh_id AND ADV0.currency_iso_cd = 'EUR' AND AGG_STORE.dat_formdate BETWEEN
   DATE_SUB(DATE_SUB(ADV0.dat_adv, INTERVAL 1 DAY), INTERVAL CAST(ROUND(40.0) AS INTEGER) DAY) AND (DATE_ADD(ADV0.dat_adv
     ,INTERVAL 10 DAY))
 LEFT JOIN (SELECT client_id,
   loc_sid_store,
   src_orig_store_nr,
   dwh_actual_fg,
   test_store_fg,
   pseudo_store_fg
  FROM ldl_p_lew_mart_cs.v_gen_store
  GROUP BY client_id,
   loc_sid_store,
   src_orig_store_nr,
   test_store_fg,
   pseudo_store_fg,
   dwh_actual_fg) AS s ON AGG_STORE.client_id = s.client_id AND AGG_STORE.loc_sid_store = s.loc_sid_store AND s.dwh_actual_fg
      = 1 AND s.test_store_fg = 0 AND s.pseudo_store_fg = 0;