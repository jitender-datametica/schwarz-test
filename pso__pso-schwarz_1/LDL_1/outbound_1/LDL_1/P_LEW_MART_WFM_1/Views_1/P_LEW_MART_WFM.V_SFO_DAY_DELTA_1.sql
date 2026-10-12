/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_WFM.V_SFO_DAY_DELTA_1
#----------------------------------------------------------------------------
# History:
#  1.0  2023-06-12    Ulrich ross          Remove eLWIS logic
#                                          https://dev.azure.com/schwarzit/schwarzit.biaid/_boards/board/t/Data%20Extraction%20And%20Export/Stories/?workitem=488527
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_sfo_day_delta_1 AS SELECT t4.client_id,
 t4.src_country_lidl_cd AS country_lidl_cd,
 t4.src_orig_store_nr AS store,
 t4.dat_formdate AS receiptdate,
 t4.derived_item_nr AS item_1,
 CAST(SUM(CASE
    WHEN t4.sfotype_id IN (130, 140)
    THEN t4.qty_total_sfo_agg
    ELSE 0
    END) AS NUMERIC) AS sfo_pieces_130_140,
 CAST(SUM(CASE
    WHEN t4.sfotype_id IN (131, 141)
    THEN t4.qty_total_sfo_agg
    ELSE 0
    END) AS NUMERIC) AS sfo_pieces_131_141,
 CAST(SUM(CASE
    WHEN t4.sfotype_id IN (132, 142)
    THEN t4.qty_total_sfo_agg
    ELSE 0
    END) AS NUMERIC) AS sfo_pieces_132_142,
 CAST(SUM(CASE
    WHEN t4.sfotype_id IN (133, 143)
    THEN t4.qty_total_sfo_agg
    ELSE 0
    END) AS NUMERIC) AS sfo_pieces_133_143,
 CAST(SUM(CASE
    WHEN t4.sfotype_id IN (134, 144)
    THEN t4.qty_total_sfo_agg
    ELSE 0
    END) AS NUMERIC) AS sfo_pieces_134_144,
 CAST(SUM(CASE
    WHEN t4.sfotype_id IN (135, 145)
    THEN t4.qty_total_sfo_agg
    ELSE 0
    END) AS NUMERIC) AS sfo_pieces_135_145,
 CAST(SUM(CASE
    WHEN t4.sfotype_id IN (136, 146)
    THEN t4.qty_total_sfo_agg
    ELSE 0
    END) AS NUMERIC) AS sfo_pieces_136_146,
 CAST(SUM(CASE
    WHEN t4.sfotype_id IN (137, 147) AND (t4.price_wh_net_sfo <> 0 AND t4.price_new_net_sfo = 0 OR t4.price_wh_net_sfo = 0 AND t4.price_new_net_sfo <> 0)
    THEN t4.qty_total_sfo_agg
    ELSE 0
    END) AS NUMERIC) AS sfo_pieces_137_147_0pv,
 CAST(SUM(CASE
    WHEN t4.sfotype_id IN (137, 147) AND (t4.price_wh_net_sfo = 0 OR t4.price_new_net_sfo <> 0) AND (t4.price_wh_net_sfo <> 0 OR t4.price_new_net_sfo = 0)
    THEN t4.qty_total_sfo_agg
    ELSE 0
    END) AS NUMERIC) AS sfo_pieces_137_147_pv,
 CAST(SUM(CASE
    WHEN t4.sfotype_id IN (138, 148)
    THEN t4.qty_total_sfo_agg
    ELSE 0
    END) AS NUMERIC) AS sfo_pieces_138_148,
 CAST(SUM(CASE
    WHEN t4.sfotype_id IN (139, 149)
    THEN t4.qty_total_sfo_agg
    ELSE 0
    END) AS NUMERIC) AS sfo_pieces_139_149,
 CAST(SUM(CASE
    WHEN t4.sfotype_id IN (150, 160)
    THEN t4.qty_total_sfo_agg
    ELSE 0
    END) AS NUMERIC) AS sfo_pieces_150_160,
 CAST(SUM(CASE
    WHEN t4.sfotype_id IN (151, 161)
    THEN t4.qty_total_sfo_agg
    ELSE 0
    END) AS NUMERIC) AS sfo_pieces_151_161,
 CAST(SUM(CASE
    WHEN t4.sfotype_id IN (152, 162)
    THEN t4.qty_total_sfo_agg
    ELSE 0
    END) AS NUMERIC) AS sfo_pieces_152_162,
 CAST(SUM(CASE
    WHEN t4.sfotype_id IN (130, 140)
    THEN t4.val_retail_receiptline_net_sfo_agg
    ELSE 0
    END) AS NUMERIC) AS sfo_value_130_140,
 CAST(SUM(CASE
    WHEN t4.sfotype_id IN (131, 141)
    THEN t4.val_retail_receiptline_net_sfo_agg
    ELSE 0
    END) AS NUMERIC) AS sfo_value_131_141,
 CAST(SUM(CASE
    WHEN t4.sfotype_id IN (132, 142)
    THEN t4.val_retail_receiptline_net_sfo_agg
    ELSE 0
    END) AS NUMERIC) AS sfo_value_132_142,
 CAST(SUM(CASE
    WHEN t4.sfotype_id IN (133, 143)
    THEN t4.val_retail_receiptline_net_sfo_agg
    ELSE 0
    END) AS NUMERIC) AS sfo_value_133_143,
 CAST(SUM(CASE
    WHEN t4.sfotype_id IN (134, 144)
    THEN t4.val_retail_receiptline_net_sfo_agg
    ELSE 0
    END) AS NUMERIC) AS sfo_value_134_144,
 CAST(SUM(CASE
    WHEN t4.sfotype_id IN (135, 145)
    THEN t4.val_retail_receiptline_net_sfo_agg
    ELSE 0
    END) AS NUMERIC) AS sfo_value_135_145,
 CAST(SUM(CASE
    WHEN t4.sfotype_id IN (136, 146)
    THEN t4.val_retail_receiptline_net_sfo_agg
    ELSE 0
    END) AS NUMERIC) AS sfo_value_136_146,
 CAST(SUM(CASE
    WHEN t4.sfotype_id IN (137, 147) AND (t4.price_wh_net_sfo <> 0 AND t4.price_new_net_sfo = 0 OR t4.price_wh_net_sfo = 0 AND t4.price_new_net_sfo <> 0)
    THEN t4.val_retail_receiptline_net_sfo_agg
    ELSE 0
    END) AS NUMERIC) AS sfo_value_137_147_0pv,
 CAST(SUM(CASE
    WHEN t4.sfotype_id IN (137, 147) AND (t4.price_wh_net_sfo = 0 OR t4.price_new_net_sfo <> 0) AND (t4.price_wh_net_sfo <> 0 OR t4.price_new_net_sfo = 0)
    THEN t4.val_retail_receiptline_net_sfo_agg
    ELSE 0
    END) AS NUMERIC) AS sfo_value_137_147_pv,
 CAST(SUM(CASE
    WHEN t4.sfotype_id IN (138, 148)
    THEN t4.val_retail_receiptline_net_sfo_agg
    ELSE 0
    END) AS NUMERIC) AS sfo_value_138_148,
 CAST(SUM(CASE
    WHEN t4.sfotype_id IN (139, 149)
    THEN t4.val_retail_receiptline_net_sfo_agg
    ELSE 0
    END) AS NUMERIC) AS sfo_value_139_149,
 CAST(SUM(CASE
    WHEN t4.sfotype_id IN (150, 160)
    THEN t4.val_retail_receiptline_net_sfo_agg
    ELSE 0
    END) AS NUMERIC) AS sfo_value_150_160,
 CAST(SUM(CASE
    WHEN t4.sfotype_id IN (151, 161)
    THEN t4.val_retail_receiptline_net_sfo_agg
    ELSE 0
    END) AS NUMERIC) AS sfo_value_151_161,
 CAST(SUM(CASE
    WHEN t4.sfotype_id IN (152, 162)
    THEN t4.val_retail_receiptline_net_sfo_agg
    ELSE 0
    END) AS NUMERIC) AS sfo_value_152_162,
  (SELECT MAX(dwh_load_id)
  FROM ldl_p_lew_core_ac.v_store_form_1) AS load_id
FROM (SELECT ITM_MOV.sfo_type_id AS sfotype_id,
   ITM_MOV.client_id,
   CLNT.src_country_lidl_cd,
   LOC.src_orig_store_nr,
   ITM_MOV.dwh_cal_dt AS dat_formdate,
   ROUND(CAST(ITM.src_orig_item_nr AS BIGNUMERIC), 0) AS derived_item_nr,
   ITM.src_case_size,
   ITM_MOV.wh_net_price AS price_wh_net_sfo,
   ITM_MOV.new_net_price AS price_new_net_sfo,
   SUM(ITM_MOV.case_qty) AS qty_case_sfo_agg,
   SUM(CASE
     WHEN ITM_MOV.piece_qty IS NULL
     THEN 0
     ELSE ITM_MOV.piece_qty
     END) AS qty_piece_sfo_agg,
   SUM(ITM_MOV.total_qty) AS qty_total_sfo_agg,
   SUM(ITM_MOV.receipt_line_net_val) AS val_retail_receiptline_net_sfo_agg
  FROM ldl_p_lew_core_ac.v_store_form_1 AS ITM_MOV
   INNER JOIN (SELECT ITM_MOV0.client_id,
     ITM_MOV0.loc_sid_store,
     ITM_MOV0.dwh_cal_dt
    FROM ldl_p_lew_core_ac.v_store_form_1 AS ITM_MOV0
     INNER JOIN ldl_p_lew_process_ac.v_wfm_last_export_1 AS LAST_EXPO ON ITM_MOV0.dwh_updated > LAST_EXPO.last_export_tmsp
         AND LAST_EXPO.process_name = 'export_wfm_sfo_day' AND LAST_EXPO.process_specification = 'delta'
     INNER JOIN ldl_p_lew_process_ac.v_wfm_export_specification_1 AS EXPO_SPEC ON LAST_EXPO.export_specification =
         EXPO_SPEC.export_specification AND ITM_MOV0.client_id = EXPO_SPEC.client_id AND ITM_MOV0.dwh_cal_dt BETWEEN
        DATE_SUB(CURRENT_DATE, INTERVAL 40 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)) AND ITM_MOV0.sfo_type_id IN
        (130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 150, 151, 152, 140, 141, 142, 143, 144, 145, 146, 147, 148,
        149, 160, 161, 162)
    GROUP BY ITM_MOV0.client_id,
     ITM_MOV0.loc_sid_store,
     ITM_MOV0.dwh_cal_dt) AS delta_filter ON ITM_MOV.client_id = delta_filter.client_id AND ITM_MOV.loc_sid_store =
       delta_filter.loc_sid_store AND ITM_MOV.dwh_cal_dt = delta_filter.dwh_cal_dt AND ITM_MOV.sfo_type_id IN (130, 131
      , 132, 133, 134, 135, 136, 137, 138, 139, 150, 151, 152, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 160,
      161, 162)
   INNER JOIN ldl_p_lew_core_ac.v_location_1 AS LOC ON ITM_MOV.client_id = LOC.client_id AND ITM_MOV.loc_sid_store = LOC.loc_sid
       AND LOC.wh_store_mark = 'A'
   INNER JOIN ldl_p_lew_core_ac.v_item_1 AS ITM ON ITM_MOV.client_id = ITM.client_id AND ITM_MOV.item_sid = ITM.item_sid
   INNER JOIN ldl_p_lew_core_ac.v_client_1 AS CLNT ON ITM_MOV.client_id = CLNT.client_id
  WHERE ITM.src_orig_item_nr IS NOT NULL
  GROUP BY sfotype_id,
   ITM_MOV.client_id,
   CLNT.src_country_lidl_cd,
   LOC.src_orig_store_nr,
   dat_formdate,
   derived_item_nr,
   ITM.src_case_size,
   price_wh_net_sfo,
   price_new_net_sfo) AS t4
GROUP BY t4.client_id,
 t4.src_country_lidl_cd,
 t4.src_orig_store_nr,
 t4.dat_formdate,
 t4.derived_item_nr;