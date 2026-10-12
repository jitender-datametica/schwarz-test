CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_return_day_delta AS
/* 21.08.2018, Stephan Krone: Eliminated CAST to NUMERIC(18,4) */
/* 21.08.2018, Stephan Krone: Eliminated CAST to NUMERIC(18,4) */
/* 21.08.2018, Stephan Krone: Eliminated CAST to NUMERIC(18,4) */
/* 21.08.2018, Stephan Krone: Eliminated CAST to NUMERIC(18,4) */
/* 21.08.2018, Stephan Krone: -1 is treated as former NULL */
/* 22.08.2018, Stephan Krone: changed field from LDL.agg.piece_weight_qty to sales_weight_qty */ SELECT client_id,
 store,
 item,
 receiptdate,
 sum_qty_weight,
 sum_qty_piece,
 sum_turnover_net,
 CAST(NULL AS BIGNUMERIC) AS load_id
FROM (SELECT AGG.client_id,
   STORE0.src_orig_store_nr AS store,
   ROUND(CAST(ITM.src_orig_item_nr AS BIGNUMERIC), 0) AS item,
   AGG.dwh_cal_dt AS receiptdate,
   SUM(CASE
     WHEN CASE
       WHEN COALESCE(AGG.discount_sid, - 1) = - 1 /* 21.08.2018, Stephan Krone: -1 is treated as former NULL */
       THEN AGG.sales_weight_qty
       /* 22.08.2018, Stephan Krone: changed field from LDL.agg.piece_weight_qty to sales_weight_qty */
       ELSE 0
       END <> 0
     THEN CASE
      WHEN COALESCE(AGG.discount_sid, - 1) = - 1 /* 21.08.2018, Stephan Krone: -1 is treated as former NULL */
      THEN AGG.return_qty
      ELSE 0
      END
     ELSE 0.000
     END) AS sum_qty_weight,
   SUM(CASE
     WHEN COALESCE(AGG.discount_sid, - 1) = - 1 /* 21.08.2018, Stephan Krone: -1 is treated as former NULL */
     THEN AGG.return_piece_weight_qty
     ELSE 0
     END) AS sum_qty_piece,
   SUM(AGG.return_gross_val) AS sum_turnover,
   SUM(AGG.return_net_val) AS sum_turnover_net
  FROM ldl_p_lew_bil_ac.v_agg_pos_store_item_day AS AGG
   INNER JOIN ldl_p_lew_bil_ac.v_item AS ITM ON AGG.client_id = ITM.client_id AND AGG.item_sid = ITM.item_sid AND
      CURRENT_DATE BETWEEN ITM.dwh_valid_from AND ITM.dwh_valid_to AND ITM.deleted_fg = 0
   INNER JOIN ldl_p_lew_core_ac.v_location AS STORE0 ON AGG.loc_sid_store = STORE0.loc_sid AND AGG.client_id = STORE0.client_id
       AND STORE0.wh_store_mark = 'A' -- deltalogic: reference on  export process table (current delta)

   INNER JOIN (SELECT client_id,
     loc_sid,
     dwh_cal_dt
    FROM ldl_p_lew_process_ac.v_wfm_export_agg_delta AS DELTAVIEW
    WHERE process_name = 'export_wfm_return_day'
     AND process_specification = 'delta'
     AND aggregate_name = 't_agg_pos_store_item_day'
     AND dwh_cal_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 40 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY))
    GROUP BY client_id,
     loc_sid,
     dwh_cal_dt) AS delta_agg ON AGG.client_id = delta_agg.client_id AND AGG.dwh_cal_dt = delta_agg.dwh_cal_dt AND AGG.loc_sid_store
      = delta_agg.loc_sid -- takeover restrictions from wawi export

  WHERE AGG.dwh_cal_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 40 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY))
   AND (CASE
       WHEN COALESCE(AGG.discount_sid, - 1) = - 1 /* 21.08.2018, Stephan Krone: -1 is treated as former NULL */
       THEN AGG.return_qty
       ELSE 0
       END <> 0 OR CASE
       WHEN COALESCE(AGG.discount_sid, - 1) = - 1 /* 21.08.2018, Stephan Krone: -1 is treated as former NULL */
       THEN AGG.return_piece_weight_qty
       ELSE 0
       END <> 0)
  GROUP BY AGG.client_id,
   store,
   item,
   receiptdate) AS ejr;