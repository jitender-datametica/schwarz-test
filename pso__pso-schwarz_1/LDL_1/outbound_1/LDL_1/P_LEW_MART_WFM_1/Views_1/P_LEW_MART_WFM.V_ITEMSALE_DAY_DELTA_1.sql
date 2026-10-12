CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_itemsale_day_delta_1 AS
-- ,wfm_expo_spec.export_specification AS export_specification

/* 20.08.2018, eimi kimura: change timestamp('yyyy-mm_1-dd hh:mi:ss.nnnnn) to time('hh:mi:ss') */
/* 21.08.2018, stephan krone: -1 is treated as former null */
/* 21.08.2018, stephan krone: changed field from LDL.agg.sales_weight_qty to agg.piece_weight_qty */
/* 21.08.2018, stephan krone: -1 is treated as former null */
/* 21.08.2018, stephan krone: changed field from LDL.agg.piece_weight_qty to agg.sales_weight_qty */
/* 21.08.2018, stephan krone: -1 is treated as former null */
/* 21.08.2018, stephan krone: -1 is treated as former null */
/* 21.08.2018, stephan krone: -1 is treated as former null */
/* 21.08.2018, stephan krone: -1 is treated as former null */
/* 20.08.2018, eimi kimura: change timestamp('yyyy-mm_1-dd hh:mi:ss.nnnnn) to time('hh:mi:ss') */
/* 21.08.2018, stephan krone: -1 is treated as former null */
/* 21.08.2018, stephan krone: -1 is treated as former null */
/* 21.08.2018, stephan krone: changed field from sales_weight_qty to piece_weight_qty */
/* 21.08.2018, stephan krone: -1 is treated as former null */ /* change to get all item_sid combinations */
/* TXJ part */ SELECT ejr.client_id,
 ejr.store,
 ejr.item_1,
 ejr.receiptdate,
 ejr.sum_qty_weight,
 ejr.sum_qty_piece,
 ejr.sum_turnover_net,
 ejr.timelastsold,
 ejr.discount_value_net,
 ejr.discount_pieces,
 ejr.discount_turnover_net,
 ejr.discount_weight_piece,
 COALESCE(txj.discount_pieces_txj, 0) AS discount_pieces_txj,
 NULL AS load_id
FROM (SELECT AGG.client_id,
   LOC.src_orig_store_nr AS store,
   COALESCE(ITMKEY.dwh_orig_item_nr, ITMKEY.wawi_dwh_orig_item_nr) AS item_1,
   AGG.dwh_cal_dt AS receiptdate,
   SUM(CASE
     WHEN CASE
       WHEN COALESCE(AGG.discount_sid, - 1) = - 1 /* 21.08.2018, stephan krone: -1 is treated as former null */
       THEN AGG.sales_weight_qty
       ELSE 0
       END <> 0
     THEN CASE
        WHEN COALESCE(AGG.discount_sid, - 1) = - 1 /* 21.08.2018, stephan krone: -1 is treated as former null */
        THEN AGG.sales_weight_qty
        ELSE 0
        END + CASE
        WHEN COALESCE(AGG.discount_sid, - 1) = - 1 /* 21.08.2018, stephan krone: -1 is treated as former null */
        THEN AGG.return_qty
        ELSE 0
        END + CASE
       WHEN COALESCE(AGG.discount_sid, - 1) = - 1 /* 21.08.2018, stephan krone: -1 is treated as former null */
       THEN AGG.sales_piece_qty
       ELSE 0
       END
     ELSE 0.000
     END) AS sum_qty_weight,
   SUM(CASE
      WHEN COALESCE(AGG.discount_sid, - 1) = - 1 /* 21.08.2018, stephan krone: -1 is treated as former null */
      THEN AGG.piece_weight_qty /* 21.08.2018, stephan krone: changed field from sales_weight_qty to piece_weight_qty */
      ELSE 0
      END + CASE
      WHEN COALESCE(AGG.discount_sid, - 1) = - 1 /* 21.08.2018, stephan krone: -1 is treated as former null */
      THEN AGG.return_piece_weight_qty
      ELSE 0
      END) AS sum_qty_piece,
   SUM(AGG.sales_net_val + AGG.return_net_val) AS sum_turnover_net,
   MAX(CASE
     WHEN COALESCE(AGG.discount_sid, - 1) = - 1 /* 21.08.2018, stephan krone: -1 is treated as former null */
     THEN CAST(AGG.last_sold_tmsp AS TIME)
     ELSE NULL
     END) AS timelastsold,
   SUM(CASE
     WHEN COALESCE(AGG.discount_sid, - 1) <> - 1 /* 21.08.2018, stephan krone: -1 is treated as former null */ AND AGG.discount_weight_qty
        > 0
     THEN AGG.discount_net_val * - 1
     ELSE 0
     END) AS discount_value_net,
   SUM(CASE
     WHEN COALESCE(AGG.discount_sid, - 1) <> - 1 /* 21.08.2018, stephan krone: -1 is treated as former null */ AND AGG.discount_weight_qty
        > 0
     THEN AGG.piece_weight_qty
     /* 21.08.2018, stephan krone: changed field from LDL.agg.sales_weight_qty to agg.piece_weight_qty */
     ELSE 0
     END) AS discount_pieces,
   SUM(CASE
     WHEN COALESCE(AGG.discount_sid, - 1) <> - 1 /* 21.08.2018, stephan krone: -1 is treated as former null */ AND AGG.discount_weight_qty
        > 0
     THEN AGG.discount_base_net_val + AGG.discount_net_val
     ELSE 0
     END) AS discount_turnover_net,
   SUM(CASE
     WHEN COALESCE(AGG.discount_sid, - 1) <> - 1 /* 21.08.2018, stephan krone: -1 is treated as former null */ AND AGG.discount_weight_qty
        > 0 /* 21.08.2018, stephan krone: changed field from LDL.agg.piece_weight_qty to agg.sales_weight_qty */
     THEN AGG.sales_piece_qty + AGG.sales_weight_qty - AGG.return_qty
     ELSE 0
     END) AS discount_weight_piece
  FROM ldl_p_lew_bil_ac.v_agg_pos_store_item_day_1 AS AGG
   INNER JOIN ldl_p_lew_core_ac.v_item_map_key_1 AS ITMKEY ON AGG.client_id = ITMKEY.client_id AND AGG.item_sid = ITMKEY.item_sid
     
   INNER JOIN ldl_p_lew_bil_ac.v_item_1 AS ITM ON AGG.client_id = ITM.client_id AND AGG.item_sid = ITM.item_sid AND AGG.dwh_cal_dt
     BETWEEN ITM.dwh_valid_from AND ITM.dwh_valid_to -- AND tryCAST(itm.src_orig_item_nr AS INTEGER ) IS NOT NULL

   INNER JOIN ldl_p_lew_bil_ac.v_store_1 AS LOC ON AGG.client_id = LOC.client_id AND AGG.loc_sid_store = LOC.loc_sid_store
       AND AGG.dwh_cal_dt BETWEEN LOC.dwh_valid_from AND LOC.dwh_valid_to
     /* INNER JOIN LDL.p_lew_process_ac.v_wfm_export_specification_1 wfm_expo_spec
   ON agg.client_id = wfm_expo_spec.client_id
  AND (wfm_expo_spec.export_specification = :client OR wfm_expo_spec.country_lidl_cd =  :client) */
     -- deltalogic: reference on  export process table (current delta)

   INNER JOIN (SELECT client_id,
     loc_sid,
     dwh_cal_dt
    FROM ldl_p_lew_process_ac.v_wfm_export_agg_delta_1 AS DELTAVIEW
    WHERE process_name = 'export_wfm_itemsale_day'
     AND process_specification = 'delta'
     AND aggregate_name = 't_agg_pos_store_item_day_1'
     AND dwh_cal_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 40 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY))
    GROUP BY client_id,
     loc_sid,
     dwh_cal_dt) AS delta_agg ON AGG.client_id = delta_agg.client_id AND AGG.dwh_cal_dt = delta_agg.dwh_cal_dt AND AGG.loc_sid_store
      = delta_agg.loc_sid -- MAXimum time frame

  WHERE AGG.dwh_cal_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 40 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY))
  GROUP BY AGG.client_id,
   store,
   item_1,
   receiptdate) AS ejr
 LEFT JOIN (SELECT clients,
   store,
   item_1,
   receiptdate,
   SUM(discount_pieces_txj) AS discount_pieces_txj
  FROM (SELECT T520.client_id AS clients,
     ORG.src_orig_store_nr AS store,
     ROUND(CAST(T520.item_nr AS BIGNUMERIC), 0) AS item_1,
     T520.dwh_cal_dt AS receiptdate,
     T520.sales_qty AS discount_pieces_txj
    FROM ldl_p_lew_core_ac.v_txj_520_1 AS T520
     INNER JOIN ldl_p_lew_bil_ac.v_store_1 AS ORG ON T520.client_id = ORG.client_id AND T520.loc_sid = ORG.loc_sid_store
      AND T520.dwh_cal_dt BETWEEN ORG.dwh_valid_from AND ORG.dwh_valid_to
       -- deltalogic: reference on  export process table (current delta)

     INNER JOIN (SELECT client_id,
       loc_sid,
       dwh_cal_dt
      FROM ldl_p_lew_process_ac.v_wfm_export_agg_delta_1 AS DELTAVIEW
      WHERE process_name = 'export_wfm_itemsale_day'
       AND process_specification = 'delta'
       AND aggregate_name = 't_agg_pos_store_item_day_1' -- MAXimum  time frame

       AND dwh_cal_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 40 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY))
      GROUP BY client_id,
       loc_sid,
       dwh_cal_dt) AS delta_txj ON T520.client_id = delta_txj.client_id AND T520.dwh_cal_dt = delta_txj.dwh_cal_dt AND
       T520.loc_sid = delta_txj.loc_sid
    QUALIFY T520.sales_val / CASE
        WHEN COALESCE(T520.sales_qty, 0) = 0
        THEN 1
        ELSE T520.sales_qty
        END < (MAX(T520.sales_val / CASE
          WHEN COALESCE(T520.sales_qty, 0) = 0
          THEN 1
          ELSE T520.sales_qty
          END) OVER (PARTITION BY CAST(T520.client_id AS STRING), CAST(ORG.src_orig_store_nr AS STRING), T520.item_nr,
          T520.dwh_cal_dt RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS b
  GROUP BY clients,
   store,
   item_1,
   receiptdate) AS txj ON ejr.client_id = txj.clients AND ejr.store = txj.store AND ejr.item_1 = txj.item_1 AND ejr.receiptdate
    = txj.receiptdate;