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


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_psa_abverkaufe_2 (client_id, orig_item_nr, dat_adv, wh_id, dat_valid_from,
avk_wt_1_tag_test, avk_wt_3_tag_test, avk_wt_7_tag_test, avk_wt_1_tag, avk_wt_3_tag, avk_wt_7_tag) AS SELECT ADV0.client_id
 ,
 I0.orig_item_nr,
 ADV0.dat_adv,
 WH.src_wh_id AS wh_id,
 I0.valid_from AS dat_valid_from,
  CASE
  WHEN CASE
    WHEN ADV0.client_id IS NOT NULL AND AGG_STORE.dat_formdate BETWEEN DATE_SUB(ADV0.dat_adv, INTERVAL 5 DAY) AND ADV0.dat_adv
      
    THEN AGG_STORE.qty_piece_ejr_asis + AGG_STORE.qty_weight_ejr_asis + AGG_STORE.qty_return_ejr_asis
    ELSE 0
    END = 0
  THEN NULL
  ELSE CASE
   WHEN ADV0.client_id IS NOT NULL AND AGG_STORE.dat_formdate BETWEEN DATE_SUB(ADV0.dat_adv, INTERVAL 5 DAY) AND ADV0.dat_adv
     
   THEN AGG_STORE.qty_piece_ejr_asis + AGG_STORE.qty_weight_ejr_asis + AGG_STORE.qty_return_ejr_asis
   ELSE 0
   END
  END AS avk_wt_1_tag_test,
  CASE
  WHEN CASE
    WHEN ADV0.client_id IS NOT NULL AND AGG_STORE.dat_formdate BETWEEN DATE_SUB(ADV0.dat_adv, INTERVAL 5 DAY) AND (DATE_ADD(ADV0
        .dat_adv, INTERVAL 2 DAY))
    THEN AGG_STORE.qty_piece_ejr_asis + AGG_STORE.qty_weight_ejr_asis + AGG_STORE.qty_return_ejr_asis
    ELSE 0
    END = 0
  THEN NULL
  ELSE CASE
   WHEN ADV0.client_id IS NOT NULL AND AGG_STORE.dat_formdate BETWEEN DATE_SUB(ADV0.dat_adv, INTERVAL 5 DAY) AND (DATE_ADD(ADV0
       .dat_adv, INTERVAL 2 DAY))
   THEN AGG_STORE.qty_piece_ejr_asis + AGG_STORE.qty_weight_ejr_asis + AGG_STORE.qty_return_ejr_asis
   ELSE 0
   END
  END AS avk_wt_3_tag_test,
  CASE
  WHEN CASE
    WHEN ADV0.client_id IS NOT NULL AND AGG_STORE.dat_formdate BETWEEN DATE_SUB(ADV0.dat_adv, INTERVAL 5 DAY) AND (DATE_ADD(ADV0
        .dat_adv, INTERVAL 6 DAY))
    THEN AGG_STORE.qty_piece_ejr_asis + AGG_STORE.qty_weight_ejr_asis + AGG_STORE.qty_return_ejr_asis
    ELSE 0
    END = 0
  THEN NULL
  ELSE CASE
   WHEN ADV0.client_id IS NOT NULL AND AGG_STORE.dat_formdate BETWEEN DATE_SUB(ADV0.dat_adv, INTERVAL 5 DAY) AND (DATE_ADD(ADV0
       .dat_adv, INTERVAL 6 DAY))
   THEN AGG_STORE.qty_piece_ejr_asis + AGG_STORE.qty_weight_ejr_asis + AGG_STORE.qty_return_ejr_asis
   ELSE 0
   END
  END AS avk_wt_7_tag_test,
  CASE
  WHEN CASE
    WHEN AGG_STORE.dat_formdate BETWEEN DATE_SUB(ADV0.dat_adv, INTERVAL 5 DAY) AND ADV0.dat_adv
    THEN AGG_STORE.qty_piece_ejr_asis + AGG_STORE.qty_weight_ejr_asis + AGG_STORE.qty_return_ejr_asis
    ELSE 0
    END = 0
  THEN NULL
  ELSE CASE
   WHEN AGG_STORE.dat_formdate BETWEEN DATE_SUB(ADV0.dat_adv, INTERVAL 5 DAY) AND ADV0.dat_adv
   THEN AGG_STORE.qty_piece_ejr_asis + AGG_STORE.qty_weight_ejr_asis + AGG_STORE.qty_return_ejr_asis
   ELSE 0
   END
  END AS avk_wt_1_tag,
  CASE
  WHEN CASE
    WHEN AGG_STORE.dat_formdate BETWEEN DATE_SUB(ADV0.dat_adv, INTERVAL 5 DAY) AND (DATE_ADD(ADV0.dat_adv, INTERVAL 2
       DAY))
    THEN AGG_STORE.qty_piece_ejr_asis + AGG_STORE.qty_weight_ejr_asis + AGG_STORE.qty_return_ejr_asis
    ELSE 0
    END = 0
  THEN NULL
  ELSE CASE
   WHEN AGG_STORE.dat_formdate BETWEEN DATE_SUB(ADV0.dat_adv, INTERVAL 5 DAY) AND (DATE_ADD(ADV0.dat_adv, INTERVAL 2 DAY
      ))
   THEN AGG_STORE.qty_piece_ejr_asis + AGG_STORE.qty_weight_ejr_asis + AGG_STORE.qty_return_ejr_asis
   ELSE 0
   END
  END AS avk_wt_3_tag,
  CASE
  WHEN CASE
    WHEN AGG_STORE.dat_formdate BETWEEN DATE_SUB(ADV0.dat_adv, INTERVAL 5 DAY) AND (DATE_ADD(ADV0.dat_adv, INTERVAL 6
       DAY))
    THEN AGG_STORE.qty_piece_ejr_asis + AGG_STORE.qty_weight_ejr_asis + AGG_STORE.qty_return_ejr_asis
    ELSE 0
    END = 0
  THEN NULL
  ELSE CASE
   WHEN AGG_STORE.dat_formdate BETWEEN DATE_SUB(ADV0.dat_adv, INTERVAL 5 DAY) AND (DATE_ADD(ADV0.dat_adv, INTERVAL 6 DAY
      ))
   THEN AGG_STORE.qty_piece_ejr_asis + AGG_STORE.qty_weight_ejr_asis + AGG_STORE.qty_return_ejr_asis
   ELSE 0
   END
  END AS avk_wt_7_tag
FROM ldl_p_lew_mart_cs.v_gen_agg_store_day_item_ejr_asis_2 AS AGG_STORE
 INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_lastknown_2 AS WH ON AGG_STORE.client_id = WH.client_id AND AGG_STORE.store_id
    = WH.loc_sid_store
 INNER JOIN (SELECT AGG.client_id,
   AGG.item_sid,
   AGG.dwh_cal_dt,
   AGG.wh_id,
   I.valid_from AS dat_valid_from,
   I.orig_item_nr
  FROM ldl_p_lew_mart_cs.v_gen_agg_wh_day_item_ejr_asis_2 AS AGG
   INNER JOIN ldl_p_lew_mart_cs.v_gen_item_asis_2 AS I ON AGG.client_id = I.client_id AND AGG.item_sid = I.item_sid
   INNER JOIN ldl_p_lew_bil_ac.v_adv_orig_item_advertising_2 AS ADV ON AGG.client_id = ADV.client_id
       /* AND a15.dat_valid_from = adv.dat_valid_from */ AND I.orig_item_nr = ADV.orig_item_nr AND AGG.wh_id = ADV.wh_id
       AND AGG.dwh_cal_dt BETWEEN DATE_SUB(ADV.dat_adv, INTERVAL 5 DAY) AND (DATE_ADD(ADV.dat_adv, INTERVAL 6 DAY))
  WHERE ADV.currency_iso_cd = 'EUR'
   AND I.subitemgroup_id BETWEEN 100 AND 399
  GROUP BY AGG.client_id,
   AGG.item_sid,
   AGG.dwh_cal_dt,
   AGG.wh_id,
   I.orig_item_nr,
   I.valid_from) AS agg_wh ON AGG_STORE.client_id = agg_wh.client_id AND AGG_STORE.item_id = agg_wh.item_sid AND WH.src_wh_id
     = agg_wh.wh_id AND AGG_STORE.dat_formdate = agg_wh.dwh_cal_dt
 INNER JOIN (SELECT client_id,
   loc_sid_store,
   src_orig_store_nr,
   dwh_actual_fg,
   test_store_fg,
   pseudo_store_fg
  FROM ldl_p_lew_mart_cs.v_gen_store_2
  GROUP BY client_id,
   loc_sid_store,
   src_orig_store_nr,
   test_store_fg,
   pseudo_store_fg,
   dwh_actual_fg) AS s ON AGG_STORE.client_id = s.client_id AND AGG_STORE.store_id = s.loc_sid_store AND s.dwh_actual_fg
      = 1 AND s.test_store_fg = 0 AND s.pseudo_store_fg = 0
 INNER JOIN ldl_p_lew_mart_cs.v_gen_item_asis_2 AS I0 ON AGG_STORE.client_id = I0.client_id AND AGG_STORE.item_id = I0.item_sid
   
 INNER JOIN ldl_p_lew_bil_ac.v_adv_orig_item_advertising_2 AS ADV0 ON AGG_STORE.client_id = ADV0.client_id AND AGG_STORE.currency_iso_cd
         = ADV0.currency_iso_cd AND I0.client_id = ADV0.client_id /* AND a15.dat_valid_from = adv.dat_valid_from */ AND
      I0.orig_item_nr = ADV0.orig_item_nr AND WH.client_id = ADV0.client_id AND WH.src_wh_id = ADV0.wh_id AND AGG_STORE
   .dat_formdate BETWEEN DATE_SUB(ADV0.dat_adv, INTERVAL 5 DAY) AND (DATE_ADD(ADV0.dat_adv, INTERVAL 6 DAY))
WHERE ADV0.currency_iso_cd = 'EUR'
 AND I0.subitemgroup_id BETWEEN 100 AND 399;