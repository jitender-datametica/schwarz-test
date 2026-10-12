CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_RETURN_DAY_DELTA_2
AS
(SELECT
ejr.client_id
,ejr.store
,ejr.item_2
,ejr.receiptdate
,ejr.sum_qty_weight
,ejr.sum_qty_piece
,ejr.sum_turnover_net
,CAST(NULL AS INTEGER) load_id
FROM (SELECT
clients                 AS client_id
,Store                      AS store
,Item_2                       AS item_2
,Receiptdate                AS receiptdate
,SUM(sum_qty_weight)        AS sum_qty_weight      /* 21.08.2018, Stephan Krone: Eliminated CAST to DECIMAL(18,4) */
,SUM(sum_qty_piece)         AS sum_qty_piece        /* 21.08.2018, Stephan Krone: Eliminated CAST to DECIMAL(18,4) */
,SUM(sum_turnover)          AS sum_turnover         /* 21.08.2018, Stephan Krone: Eliminated CAST to DECIMAL(18,4) */
,SUM(sum_turnover_net)      AS sum_turnover_net     /* 21.08.2018, Stephan Krone: Eliminated CAST to DECIMAL(18,4) */
FROM (SELECT
agg.client_id                                                           AS clients
,store.src_orig_store_nr                                                 AS Store
,CAST(itm.src_orig_item_nr AS BIGINT)                                    AS Item_2
,agg.dwh_cal_dt   AS receiptdate
,CASE WHEN CASE
                       WHEN COALESCE(agg.discount_sid, -1) = -1         /* 21.08.2018, Stephan Krone: -1 is treated as former NULL */
                       THEN agg.sales_weight_qty                       /* 22.08.2018, Stephan Krone: changed field from agg.piece_weight_qty to sales_weight_qty */
                       ELSE 0
                  END <> 0
THEN CASE
WHEN COALESCE(agg.discount_sid, -1) = -1         /* 21.08.2018, Stephan Krone: -1 is treated as former NULL */
THEN agg.return_qty
ELSE 0
END ELSE 0.000
END                                                                 AS sum_qty_weight
,CASE
                       WHEN COALESCE(agg.discount_sid, -1) = -1         /* 21.08.2018, Stephan Krone: -1 is treated as former NULL */
                       THEN agg.return_piece_weight_qty
                       ELSE 0
                  END AS sum_qty_piece
,agg.client_id
,agg.dwh_cal_dt                                                          AS dat_formdate
,agg.cy_month
,agg.item_sid
,CASE
                       WHEN COALESCE(agg.discount_sid, -1) = -1         /* 21.08.2018, Stephan Krone: -1 is treated as former NULL */
                       THEN agg.sales_weight_qty                       /* 22.08.2018, Stephan Krone: changed field from agg.piece_weight_qty to sales_weight_qty */
                       ELSE 0
                  END                                                                     AS qty_weight_ejr_asis
,CASE
                       WHEN COALESCE(agg.discount_sid, -1) = -1         /* 21.08.2018, Stephan Krone: -1 is treated as former NULL */
                       THEN agg.return_qty
                       ELSE 0
                  END                                                                     AS qty_return_ejr_asis
,CASE
                       WHEN COALESCE(agg.discount_sid, -1) = -1         /* 21.08.2018, Stephan Krone: -1 is treated as former NULL */
                       THEN agg.return_piece_weight_qty
                       ELSE 0
                  END                                                                     AS qty_rt_piece_weight_ejr_asis
,agg.return_gross_val                                                    AS val_return_ejr_asis
,agg.return_net_val                                                      AS val_return_ejr_net_asis
,val_return_ejr_asis                                                     AS sum_turnover
,val_return_ejr_net_asis                                                 AS sum_turnover_net
FROM p_lew_bil_ac.v_agg_pos_store_item_day_2 agg

INNER JOIN p_lew_bil_ac.v_item_2 itm
ON  agg.client_id = itm.client_id
AND agg.item_sid = itm.item_sid
AND CURRENT_DATE BETWEEN itm.dwh_valid_from AND itm.dwh_valid_to
AND TRY_CAST(itm.src_orig_item_nr AS BIGINT) IS NOT NULL
AND itm.deleted_fg = 0

INNER JOIN p_lew_core_ac.v_location_2 store
ON agg.loc_sid_store = store.loc_sid
AND agg.client_id = store.client_id
AND store.wh_store_mark = 'A'


-- deltalogic: reference on  export process table (current delta)
INNER JOIN (SELECT
deltaview.client_id
,deltaview.loc_sid
,deltaview.dwh_cal_dt
FROM p_lew_process_ac.v_wfm_export_agg_delta_2 deltaview
WHERE deltaview.process_name = 'export_wfm_return_day'
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

-- takeover restrictions from wawi export
WHERE agg.dwh_cal_dt BETWEEN CURRENT_DATE - 40 AND CURRENT_DATE -1
AND (qty_return_ejr_asis <> 0 OR qty_rt_piece_weight_ejr_asis <> 0)

)aaa_2

GROUP BY clients, store, item_2, receiptdate
) ejr
)
;