CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_ITEMSALE_DAY_DELTA_2
AS
(SELECT
ejr.client_id
,ejr.store
,ejr.item_2
,ejr.receiptdate
,ejr.SUM_qty_weight
,ejr.SUM_qty_piece
,ejr.SUM_turnOVER_net
,ejr.timelastsold
,ejr.discount_value_net
,ejr.discount_pieces
,ejr.discount_turnOVER_net
,ejr.discount_weight_piece
,COALESCE(txj.discount_pieces_txj, 0) AS discount_pieces_txj
,NULL AS load_id
FROM (SELECT
client_id                                       AS client_id
,store                                           AS store
,item_2                                            AS item_2
,receiptdate                                     AS receiptdate
,SUM(SUM_qty_weight)                             AS SUM_qty_weight
,SUM(SUM_qty_piece)                              AS SUM_qty_piece
,SUM(SUM_turnOVER_net)                           AS SUM_turnOVER_net
,MAX(timelastsold)                               AS timelastsold
,SUM(discount_value_net)                         AS discount_value_net
,SUM(discount_pieces)                            AS discount_pieces
,SUM(discount_turnOVER_net)                      AS discount_turnOVER_net
,SUM(discount_weight_piece)                      AS discount_weight_piece
-- ,wfm_expo_spec.export_specification AS export_specification
FROM (SELECT
agg.client_id                                                              AS client_id
,loc.src_orig_store_nr                                                      AS store
,COALESCE(itmkey.dwh_orig_item_nr, itmkey.wawi_dwh_orig_item_nr)            AS item_2
,agg.dwh_cal_dt  AS receiptdate
,CASE WHEN CASE WHEN COALESCE(agg.discount_sid, -1) = -1       /* 21.08.2018, stephan krone: -1 is treated as former null */
                          THEN agg.sales_weight_qty
                          ELSE 0
                     END <> 0
THEN CASE WHEN COALESCE(agg.discount_sid, -1) = -1       /* 21.08.2018, stephan krone: -1 is treated as former null */
THEN agg.sales_weight_qty
ELSE 0
END + CASE WHEN COALESCE(agg.discount_sid, -1) = -1       /* 21.08.2018, stephan krone: -1 is treated as former null */
THEN agg.return_qty
ELSE 0
END + CASE WHEN COALESCE(agg.discount_sid, -1) = -1       /* 21.08.2018, stephan krone: -1 is treated as former null */
THEN agg.sales_piece_qty
ELSE 0
END ELSE 0.000
END                                                        AS SUM_qty_weight
,CASE WHEN COALESCE(agg.discount_sid, -1) = -1       /* 21.08.2018, stephan krone: -1 is treated as former null */
                          THEN agg.piece_weight_qty                     /* 21.08.2018, stephan krone: changed field from sales_weight_qty to piece_weight_qty */
                          ELSE 0
                     END + CASE WHEN COALESCE(agg.discount_sid, -1) = -1       /* 21.08.2018, stephan krone: -1 is treated as former null */
THEN agg.return_piece_weight_qty
ELSE 0
END AS SUM_qty_piece
,agg.sales_net_val + agg.return_net_val AS SUM_turnOVER_net
,CASE WHEN COALESCE(agg.discount_sid, -1) = -1       /* 21.08.2018, stephan krone: -1 is treated as former null */
                          THEN CAST(agg.last_sold_tmsp AS TIME)         /* 20.08.2018, eimi kimura: change timestamp('yyyy-mm_2-dd hh:mi:ss.nnnnn) to time('hh:mi:ss')*/
                          ELSE NULL
                     END AS timelastsold
,CASE WHEN     COALESCE(agg.discount_sid, -1) <> -1  /* 21.08.2018, stephan krone: -1 is treated as former null */
                               AND agg.discount_weight_qty > 0
                          THEN agg.discount_net_val * -1
                          ELSE 0
                     END AS discount_value_net
,CASE WHEN     COALESCE(agg.discount_sid, -1) <> -1  /* 21.08.2018, stephan krone: -1 is treated as former null */
                               AND agg.discount_weight_qty > 0
                          THEN agg.piece_weight_qty                     /* 21.08.2018, stephan krone: changed field from agg.sales_weight_qty to agg.piece_weight_qty */
                          ELSE 0
                     END AS discount_pieces
,CASE WHEN     COALESCE(agg.discount_sid, -1) <> -1  /* 21.08.2018, stephan krone: -1 is treated as former null */
                               AND agg.discount_weight_qty > 0          /* 21.08.2018, stephan krone: changed field from agg.piece_weight_qty to agg.sales_weight_qty */
                          THEN agg.sales_piece_qty + agg.sales_weight_qty - agg.return_qty
                          ELSE 0
                     END AS discount_weight_piece
,CASE WHEN     COALESCE(agg.discount_sid, -1) <> -1  /* 21.08.2018, stephan krone: -1 is treated as former null */
                               AND agg.discount_weight_qty > 0
                          THEN agg.piece_weight_qty                     /* 21.08.2018, stephan krone: changed field from agg.sales_weight_qty to agg.piece_weight_qty */
                          ELSE 0
                     END                                                                        AS qty_disc_piece_ejr_asis
,CASE WHEN     COALESCE(agg.discount_sid, -1) <> -1  /* 21.08.2018, stephan krone: -1 is treated as former null */
                               AND agg.discount_weight_qty > 0          /* 21.08.2018, stephan krone: changed field from agg.piece_weight_qty to agg.sales_weight_qty */
                          THEN agg.sales_piece_qty + agg.sales_weight_qty - agg.return_qty
                          ELSE 0
                     END                                                                        AS qty_disc_weight_piece_ejr_asis
,CASE WHEN COALESCE(agg.discount_sid, -1) = -1       /* 21.08.2018, stephan krone: -1 is treated as former null */
                          THEN agg.sales_piece_qty
                          ELSE 0
                     END                                                                        AS qty_piece_ejr_asis
,CASE WHEN COALESCE(agg.discount_sid, -1) = -1       /* 21.08.2018, stephan krone: -1 is treated as former null */
                          THEN agg.return_qty
                          ELSE 0
                     END                                                                        AS qty_return_ejr_asis
,CASE WHEN COALESCE(agg.discount_sid, -1) = -1       /* 21.08.2018, stephan krone: -1 is treated as former null */
                          THEN agg.sales_weight_qty
                          ELSE 0
                     END                                                                        AS qty_weight_ejr_asis
,CASE WHEN COALESCE(agg.discount_sid, -1) = -1       /* 21.08.2018, stephan krone: -1 is treated as former null */
                          THEN CAST(agg.last_sold_tmsp AS TIME)         /* 20.08.2018, eimi kimura: change timestamp('yyyy-mm_2-dd hh:mi:ss.nnnnn) to time('hh:mi:ss')*/
                          ELSE NULL
                     END                                                                        AS time_last_sold_ejr_asis
,CASE WHEN     COALESCE(agg.discount_sid, -1) <> -1  /* 21.08.2018, stephan krone: -1 is treated as former null */
                               AND agg.discount_weight_qty > 0
                          THEN agg.discount_net_val * -1
                          ELSE 0
                     END                                                                        AS val_discount_net_ejr_asis
,agg.return_net_val                                                         AS val_return_net_ejr_asis
,agg.sales_net_val                                                          AS val_rtl_net_ejr_asis
,CASE WHEN COALESCE(agg.discount_sid, -1) = -1       /* 21.08.2018, stephan krone: -1 is treated as former null */
                          THEN agg.piece_weight_qty                     /* 21.08.2018, stephan krone: changed field from sales_weight_qty to piece_weight_qty */
                          ELSE 0
                     END                                                                        AS qty_piece_weight_ejr_asis
,CASE WHEN COALESCE(agg.discount_sid, -1) = -1       /* 21.08.2018, stephan krone: -1 is treated as former null */
                          THEN agg.return_piece_weight_qty
                          ELSE 0
                     END                                                                        AS qty_rt_piece_weight_ejr_asis
,CASE WHEN COALESCE(agg.discount_sid, -1) <> -1  /* 21.08.2018, stephan krone: -1 is treated as former null */
                               AND agg.discount_weight_qty > 0
                          THEN agg.discount_base_net_val + agg.discount_net_val
                          ELSE 0
                     END                                                                        AS discount_turnOVER_net
FROM p_lew_bil_ac.v_agg_pos_store_item_day_2 agg

              /* change to get all item_sid combinations*/
INNER JOIN p_lew_core_ac.v_item_map_key_2 itmkey
ON agg.client_id = itmkey.client_id
AND agg.item_sid = itmkey.item_sid

INNER JOIN p_lew_bil_ac.v_item_2 itm
ON agg.client_id = itm.client_id
AND agg.item_sid = itm.item_sid
AND agg.dwh_cal_dt BETWEEN itm.dwh_valid_from AND itm.dwh_valid_to
  --AND tryCAST(itm.src_orig_item_nr AS BIGINT) IS NOT NULL

INNER JOIN p_lew_bil_ac.v_store_2 loc
ON agg.client_id = loc.client_id
AND agg.loc_sid_store = loc.loc_sid_store
AND agg.dwh_cal_dt BETWEEN loc.dwh_valid_from AND loc.dwh_valid_to

/*                     INNER JOIN p_lew_process_ac.v_wfm_export_specification_2 wfm_expo_spec
   ON agg.client_id = wfm_expo_spec.client_id
  AND (wfm_expo_spec.export_specification = :client OR wfm_expo_spec.country_lidl_cd =  :client)*/

-- deltalogic: reference on  export process table (current delta)
INNER JOIN (SELECT
deltaview.client_id
,deltaview.loc_sid
,deltaview.dwh_cal_dt
FROM p_lew_process_ac.v_wfm_export_agg_delta_2 deltaview
WHERE deltaview.process_name = 'export_wfm_itemsale_day'
  AND deltaview.process_specification = 'delta'
  AND deltaview.aggregate_name       = 't_agg_pos_store_item_day_2'
  AND deltaview.dwh_cal_dt BETWEEN CURRENT_DATE - 40 AND CURRENT_DATE - 1
GROUP BY  deltaview.client_id
     ,deltaview.loc_sid
     ,deltaview.dwh_cal_dt
) AS delta_agg
ON agg.client_id     = delta_agg.client_id
AND agg.dwh_cal_dt    = delta_agg.dwh_cal_dt
AND agg.loc_sid_store = delta_agg.loc_sid

 -- MAXimum time frame
WHERE agg.dwh_cal_dt BETWEEN CURRENT_DATE - 40 AND CURRENT_DATE -1

)aaa_2

GROUP BY client_id, store, item_2, receiptdate
)  ejr

LEFT JOIN (

/* TXJ part */
SELECT
client_ AS clients
,store AS store
,item_2 AS item_2
,receiptdate AS receiptdate
,SUM(discount_pieces_txj) AS discount_pieces_txj
FROM (SELECT
t520.client_id AS client_
,org.src_orig_store_nr AS store
,CAST(t520.item_nr AS BIGINT) AS item_2
,t520.dwh_cal_dt AS receiptdate
,t520.sales_qty AS discount_pieces_txj
,sales_val / CASE WHEN COALESCE(sales_qty, 0) = 0 THEN 1 ELSE sales_qty END AS price
FROM p_lew_core_ac.v_txj_520_2 t520

JOIN p_lew_bil_ac.v_store_2 org
ON org.client_id = t520.client_id
AND org.loc_sid_store = t520.loc_sid
AND t520.dwh_cal_dt BETWEEN org.dwh_valid_from AND org.dwh_valid_to


-- deltalogic: reference on  export process table (current delta)
INNER JOIN (SELECT
deltaview.client_id
,deltaview.loc_sid
,deltaview.dwh_cal_dt
FROM p_lew_process_ac.v_wfm_export_agg_delta_2 deltaview
WHERE deltaview.process_name = 'export_wfm_itemsale_day'
  AND deltaview.process_specification = 'delta'
  AND deltaview.aggregate_name       = 't_agg_pos_store_item_day_2'
-- MAXimum  time frame
  AND deltaview.dwh_cal_dt BETWEEN CURRENT_DATE - 40 AND CURRENT_DATE - 1
GROUP BY  deltaview.client_id
     ,deltaview.loc_sid
     ,deltaview.dwh_cal_dt
) AS delta_txj
ON t520.client_id          = delta_txj.client_id
AND t520.dwh_cal_dt = delta_txj.dwh_cal_dt
AND t520.loc_sid      = delta_txj.loc_sid
QUALIFY price < MAX(price)
OVER (PARTITION BY t520.client_id, org.src_orig_store_nr, t520.item_nr, t520.dwh_cal_dt)
) b

GROUP BY client_, store, item_2, receiptdate
) txj
ON txj.clients = ejr.client_id
AND txj.store = ejr.store
AND txj.item_2 = ejr.item_2
AND txj.receiptdate = ejr.receiptdate
)
;