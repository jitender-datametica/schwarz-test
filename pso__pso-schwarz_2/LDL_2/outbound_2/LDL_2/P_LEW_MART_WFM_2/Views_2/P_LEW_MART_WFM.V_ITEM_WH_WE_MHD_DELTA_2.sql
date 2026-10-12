/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_WFM.V_ITEM_WH_WE_MHD_DELTA_2
#----------------------------------------------------------------------------
# History:        
#  1.0  26.08.2021    Martin Murtenthaler        VTWG-334
#  2.0  06.10.2021    Martin Murtenthaler        Having Clause
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_item_wh_we_mhd_delta_2 (client_id OPTIONS(description='Landeskennzeichen'),
country_lidl_cd OPTIONS(description='ISO-Code Land_2'), wh_id OPTIONS(description='Warehouse'), orig_item_nr
OPTIONS(description='Artikelnummer'), entry_dt OPTIONS(description='Eingangsdatum'), dat_min_durability_rcv
OPTIONS(description='Haltbarkeitsdatum'), receive_piece_qty OPTIONS(description='Wareneingaenge'))
OPTIONS(DESCRIPTION = `WARENEINGAENGE`) AS SELECT t13.client_id,
 t13.src_country_lidl_cd AS country_lidl_cd,
 t13.src_wh_id AS wh_id,
 t13.orig_item_nr,
 t13.entry_dt,
 t13.dat_min_durability_rcv,
 t13.summe
FROM (SELECT REC.client_id,
   CLI.src_country_lidl_cd,
   REC.src_wh_id,
   ROUND(SAFE_CAST(COALESCE(ITM.src_orig_item_nr, ITM.config_item_cd, ITM.src_matnr) AS BIGNUMERIC), 0) AS orig_item_nr
   ,
   REC.entry_dt,
   COALESCE(REC.dat_min_durability_rcv, sales.mini) AS dat_min_durability_rcv,
   SUM(CASE
     WHEN REC.status_tg > 3 AND REC.receipt_pos_margin_rel_fg = 1 AND REC.customer_nr IS NULL
     THEN REC.receive_piece_qty
     ELSE NULL
     END) AS summe
  FROM ldl_p_lew_bil_ac.v_mov_item_receive_wh_2 AS REC
   INNER JOIN ldl_p_lew_core_ac.v_item_2 AS ITM ON REC.client_id = ITM.client_id AND REC.item_sid = ITM.item_sid
   INNER JOIN ldl_p_lew_core_ac.v_client_2 AS CLI ON REC.client_id = CLI.client_id
   LEFT JOIN (ldl_p_lew_core_ac.v_item_movement_record_pos_2 AS MOV INNER JOIN (SELECT client_id,
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
       FROM ldl_p_lew_core_ac.v_sales_receipt_record_pos_2
       WHERE delivery_act_qty <> 0
        AND dwh_cal_dt > (SELECT DATE_SUB(DATE(MIN(last_export_tmsp)), INTERVAL 180 DAY)
          FROM ldl_p_lew_process_ac.v_wfm_last_export_2 AS EXLAST
          WHERE process_name = 'export_wfm_item_wh_we_mhd'
           AND process_specification = 'delta')
       GROUP BY client_id,
        sales_receipt_record_cd,
        item_sid,
        ref_record_cd,
        ref_record_pos_id,
        uom_cd_sales
       HAVING batchsum <> 0 AND batchmin > DATE '1900-01-01' AND batchmin = batchmax OR batchmin IS NULL AND nobatchsum
            <> 0 AND nobatchmin > DATE '1900-01-01' AND nobatchmin = nobatchmax) AS x
     GROUP BY client_id,
      order_record_id,
      ref_record_pos_id,
      uom_cd_sales
     HAVING mini = maxi) AS sales_2 ON MOV.client_id = sales.client_id AND MOV.order_record_id = sales.order_record_id AND
       MOV.order_record_pos_id = sales.ref_record_pos_id AND MOV.uom_cd_capt = sales.uom_cd_sales) ON REC.client_id =
        MOV.client_id AND REC.item_sid = MOV.item_sid AND REC.location_item_receipt_id = MOV.item_movement_record_id AND
      REC.location_item_receipt_pos_id = MOV.item_movement_record_pos_id AND REC.entry_dt = MOV.dwh_cal_dt
   INNER JOIN (SELECT EXPOSPECS.client_id,
     EXPOLAST.last_export_tmsp
    FROM ldl_p_lew_process_ac.v_wfm_export_specification_2 AS EXPOSPECS
     INNER JOIN ldl_p_lew_process_ac.v_wfm_last_export_2 AS EXPOLAST ON EXPOSPECS.export_specification = EXPOLAST.export_specification
         AND EXPOLAST.process_name = 'export_wfm_item_wh_we_mhd' AND EXPOLAST.process_specification = 'delta') AS expo
   ON REC.client_id = expo.client_id AND REC.dwh_created >= expo.last_export_tmsp
  WHERE REC.receipt_type_id <= 3
   AND REC.entry_dt >= date_sub(date_add(date_sub(date_sub(current_date(), interval 2 MONTH), interval extract(DAYOFYEAR from date_sub(current_date(), interval 2 MONTH)) DAY), interval 1 DAY), interval 22 MONTH)
    
  GROUP BY REC.client_id,
   CLI.src_country_lidl_cd,
   REC.src_wh_id,
   orig_item_nr,
   REC.entry_dt,
   dat_min_durability_rcv
  HAVING summe <> 0) AS t13;


