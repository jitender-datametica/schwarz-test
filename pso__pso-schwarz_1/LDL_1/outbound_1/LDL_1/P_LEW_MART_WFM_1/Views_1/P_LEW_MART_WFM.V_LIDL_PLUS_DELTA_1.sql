/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_WFM.V_LIDL_PLUS_DELTA_1
#----------------------------------------------------------------------------
# History:
#  1.0  14.12.2023    Camila Arango               Init, User Story 532106
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_lidl_plus_delta_1 (client_id, country_iso_cd, store, item_1, receiptdate,
coupon_type, lidl_plus_qty, lidl_plus_turnover, lidl_plus_discount) AS SELECT AGG.client_id,
 CLI.country_cd AS country_iso_cd,
 LOC.src_orig_store_nr AS store,
 COALESCE(ITMKEY.dwh_orig_item_nr, ITMKEY.wawi_dwh_orig_item_nr) AS item_1,
 AGG.dwh_cal_dt AS receiptdate,
 T1.orig_coupon_type_descr AS coupon_type,
 ROUND(SUM(DISTINCT AGG.receipt_item_discount_piece_weight_qty_uniq), 2) AS lidl_plus_qty,
 ROUND(SUM(DISTINCT AGG.receipt_total_net_val_uniq), 4) AS lidl_plus_turnover,
 ROUND(SUM(DISTINCT AGG.discount_val), 4) AS lidl_plus_discount
FROM ldl_p_lew_mart_lidl_digital.t_agg_rcpt_coupon_promo_discount_ldpl_day_1 AS AGG
 INNER JOIN ldl_p_lew_process_ac.v_wfm_last_export_1 AS EX ON AGG.dwh_updated >= EX.last_export_tmsp AND EX.process_name =
    'export_wfm_lidl_plus' AND EX.process_specification = 'delta'
 INNER JOIN ldl_p_lew_process_ac.v_wfm_export_specification_1 AS EXPO_SPEC ON EX.export_specification = EXPO_SPEC.export_specification
    AND AGG.client_id = EXPO_SPEC.client_id
 INNER JOIN ldl_p_lew_core.t_client_1 AS CLI ON AGG.client_id = CLI.client_id
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key_1 AS ITMKEY ON AGG.client_id = ITMKEY.client_id AND AGG.item_sid = ITMKEY.item_sid
   
 INNER JOIN ldl_p_lew_bil_ac.v_item_1 AS ITM ON AGG.client_id = ITM.client_id AND AGG.item_sid = ITM.item_sid AND AGG.dwh_cal_dt
   BETWEEN ITM.dwh_valid_from AND ITM.dwh_valid_to
 INNER JOIN ldl_p_lew_bil_ac.v_store_1 AS LOC ON AGG.client_id = LOC.client_id AND AGG.loc_sid = LOC.loc_sid_store AND AGG
   .dwh_cal_dt BETWEEN LOC.dwh_valid_from AND LOC.dwh_valid_to
 INNER JOIN ldl_p_lew_core.t_ref_orig_coupon_type_1 AS T1_1 ON AGG.coupon_type_id = T1.orig_coupon_type_sid
WHERE AGG.dwh_cal_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 40 DAY) AND (CURRENT_DATE)
GROUP BY AGG.client_id,
 country_iso_cd,
 store,
 item_1,
 receiptdate,
 coupon_type;