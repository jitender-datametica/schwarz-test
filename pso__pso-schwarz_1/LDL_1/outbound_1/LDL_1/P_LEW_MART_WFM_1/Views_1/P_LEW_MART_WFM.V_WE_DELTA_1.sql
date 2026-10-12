/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_WFM.V_WE_DELTA_1
#----------------------------------------------------------------------------
# History:
#  1.0  26.08.2021    Martin Murtenthaler        VTWG-334
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_we_delta_1 (client_id OPTIONS(description='Landeskennzeichen'),
country_lidl_cd OPTIONS(description='ISO-Code Land_1'), wh_id OPTIONS(description='Warehouse'), orig_item_nr
OPTIONS(description='Artikelnummer'), entry_dt OPTIONS(description='Eingangsdatum'), dat_min_durability_rcv
OPTIONS(description='Haltbarkeitsdatum'), receive_piece_qty OPTIONS(description='Wareneingaenge'))
OPTIONS(DESCRIPTION = `WARENEINGAENGE`) AS SELECT REC.client_id,
 CLI.src_country_lidl_cd AS country_lidl_cd,
 REC.src_wh_id AS wh_id,
 ROUND(SAFE_CAST(COALESCE(ITM.src_orig_item_nr, ITM.config_item_cd, ITM.src_matnr) AS BIGNUMERIC), 0) AS orig_item_nr,
 REC.entry_dt,
 COALESCE(REC.dat_min_durability_rcv, sales.mini) AS dat_min_durability_rcv,
 SUM(CASE
   WHEN REC.status_tg > 3 AND REC.receipt_pos_margin_rel_fg = 1 AND REC.customer_nr IS NULL
   THEN REC.receive_piece_qty
   ELSE NULL
   END) AS receive_piece_qty
FROM ldl_p_lew_bil_ac.v_mov_item_receive_wh_1 AS REC
 INNER JOIN ldl_p_lew_core_ac.v_item_1 AS ITM ON REC.client_id = ITM.client_id AND REC.item_sid = ITM.item_sid
 INNER JOIN ldl_p_lew_core_ac.v_client_1 AS CLI ON REC.client_id = CLI.client_id
 LEFT JOIN (p_lew_core.t_item_movement_record_pos_1 AS MOV INNER JOIN (SELECT client_id,
    ROUND(SAFE_CAST(ref_record_cd AS NUMERIC), 0) AS order_record_id,
    ref_record_pos_id,
    uom_cd_sales,
    MIN(COALESCE(batchmin, nobatchmin)) AS mini,
    MAX(COALESCE(batchmin, nobatchmin)) AS maxi
   FROM (SELECT client_id,
      sales_receipt_record_cd,
      item_sid,
      ref_record_cd,
      ref_record_pos_id,
      uom_cd_sales,
      SUM(CASE
        WHEN batch_cd IS NOT NULL
        THEN delivery_act_qty
        ELSE NULL
        END) AS batchsum,
      MIN(CASE
        WHEN batch_cd IS NOT NULL
        THEN COALESCE(best_before_dt, DATE '1900-01-01')
        ELSE NULL
        END) AS batchmin,
      MAX(CASE
        WHEN batch_cd IS NOT NULL
        THEN COALESCE(best_before_dt, DATE '1900-01-01')
        ELSE NULL
        END) AS batchmax,
      SUM(CASE
        WHEN batch_cd IS NULL
        THEN delivery_act_qty
        ELSE NULL
        END) AS nobatchsum,
      MIN(CASE
        WHEN batch_cd IS NULL
        THEN COALESCE(best_before_dt, DATE '1900-01-01')
        ELSE NULL
        END) AS nobatchmin,
      MAX(CASE
        WHEN batch_cd IS NULL
        THEN COALESCE(best_before_dt, DATE '1900-01-01')
        ELSE NULL
        END) AS nobatchmax
     FROM ldl_p_lew_core.t_sales_receipt_record_pos_1
     WHERE delivery_act_qty <> 0
      AND dwh_cal_dt > (SELECT CASE
          WHEN COUNT(*) > 0
          THEN DATE '1900-01-01'
          ELSE DATE_SUB(CURRENT_DATE, INTERVAL 180 DAY)
          END
        FROM ldl_p_lew_process_ac.v_wfm_export_specification_1 AS EXSPECS
         LEFT JOIN ldl_p_lew_process_ac.v_wfm_last_export_1 AS EXLAST ON EXSPECS.export_specification = EXLAST.export_specification
             AND EXLAST.process_name = 'export_wfm_we' AND EXLAST.process_specification = 'delta'
        WHERE EXSPECS.client_id IN (1, 21, 33, 34)
         AND EXLAST.export_specification IS NULL)
     GROUP BY client_id,
      sales_receipt_record_cd,
      item_sid,
      ref_record_cd,
      ref_record_pos_id,
      uom_cd_sales
     HAVING batchsum <> 0 AND batchmin > DATE '1900-01-01' AND batchmin = batchmax OR batchmin IS NULL AND nobatchsum <>
          0 AND nobatchmin > DATE '1900-01-01' AND nobatchmin = nobatchmax) AS x
   GROUP BY client_id,
    order_record_id,
    ref_record_pos_id,
    uom_cd_sales
   HAVING mini = maxi) AS sales_1 ON MOV.client_id = sales.client_id AND MOV.order_record_id = sales.order_record_id AND
     MOV.order_record_pos_id = sales.ref_record_pos_id AND MOV.uom_cd_capt = sales.uom_cd_sales) ON REC.client_id = MOV
      .client_id AND REC.item_sid = MOV.item_sid AND REC.location_item_receipt_id = MOV.item_movement_record_id AND REC
    .location_item_receipt_pos_id = MOV.item_movement_record_pos_id AND REC.entry_dt = MOV.dwh_cal_dt
 INNER JOIN (SELECT EXPOSPECS.client_id,
   COALESCE(EXPOLAST.last_export_tmsp, CAST('1900-01-01 00:00:00' AS DATETIME)) AS last_export_tmsp
  FROM ldl_p_lew_process_ac.v_wfm_export_specification_1 AS EXPOSPECS
   LEFT JOIN ldl_p_lew_process_ac.v_wfm_last_export_1 AS EXPOLAST ON EXPOSPECS.export_specification = EXPOLAST.export_specification
       AND EXPOLAST.process_name = 'export_wfm_we' AND EXPOLAST.process_specification = 'delta') AS expo ON REC.client_id
    = expo.client_id AND REC.dwh_created >= expo.last_export_tmsp
WHERE REC.receipt_type_id <= 3
GROUP BY REC.client_id,
 CLI.src_country_lidl_cd,
 REC.src_wh_id,
 orig_item_nr,
 REC.entry_dt,
 dat_min_durability_rcv;