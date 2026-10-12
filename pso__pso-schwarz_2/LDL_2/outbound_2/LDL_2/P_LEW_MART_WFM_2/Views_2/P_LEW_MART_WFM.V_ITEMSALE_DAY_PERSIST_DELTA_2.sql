CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_itemsale_day_persist_delta_2 (client_id, store, item_2, receiptdate,
sum_qty_weight, sum_qty_piece, sum_turnover_net, timelastsold, discount_value_net, discount_pieces,
discount_turnover_net, discount_weight_piece, discount_pieces_txj, discount_pieces_cashpoint, discount_pieces_sfo,
discount_units, discount_lw, discount_ejr, load_id) AS SELECT ejr.client_id,
 ejr.store,
 ejr.item_2,
 ejr.receiptdate,
 ejr.sum_qty_weight,
 ejr.sum_qty_piece,
 ejr.sum_turnover_net,
 ejr.timelastsold,
 COALESCE(t2.discount_lw, 0) AS discount_value_net,
 COALESCE(t1.discount_units, 0) AS discount_pieces,
 ejr.discount_turnover_net,
 ejr.discount_weight_piece,
 COALESCE(txj.discount_pieces_txj, 0) AS discount_pieces_txj,
 ejr.discount_pieces_cashpoint,
 ejr.discount_pieces_sfo,
 COALESCE(t1.discount_units, 0) AS discount_units,
 COALESCE(t2.discount_lw, 0) AS discount_lw,
 ROUND(CASE
    WHEN COALESCE(t3.discount_ejr, 0) = 0
    THEN 0
    ELSE COALESCE(t2.discount_lw, 0) / t3.discount_ejr
    END * 100, 5) AS discount_ejr,
 NULL AS load_id
FROM (SELECT AGG.client_id,
   LOC.src_orig_store_nr AS store,
   COALESCE(ITMKEY.dwh_orig_item_nr, ITMKEY.wawi_dwh_orig_item_nr) AS item_2,
   AGG.dwh_cal_dt AS receiptdate,
   SUM(CASE
     WHEN CASE
       WHEN COALESCE(AGG.discount_sid, -1) = -1
       THEN AGG.sales_weight_qty
       ELSE 0
       END <> 0
     THEN CASE
        WHEN COALESCE(AGG.discount_sid, -1) = -1
        THEN AGG.sales_weight_qty
        ELSE 0
        END + CASE
        WHEN COALESCE(AGG.discount_sid, -1) = -1
        THEN AGG.return_qty
        ELSE 0
        END + CASE
       WHEN COALESCE(AGG.discount_sid, -1) = -1
       THEN AGG.sales_piece_qty
       ELSE 0
       END
     ELSE 0.000
     END) AS sum_qty_weight,
   SUM(CASE
      WHEN COALESCE(AGG.discount_sid, -1) = -1
      THEN AGG.piece_weight_qty
      ELSE 0
      END + CASE
      WHEN COALESCE(AGG.discount_sid, -1) = -1
      THEN AGG.return_piece_weight_qty
      ELSE 0
      END) AS sum_qty_piece,
   SUM(AGG.sales_net_val + AGG.return_net_val) AS sum_turnover_net,
   MAX(CASE
     WHEN COALESCE(AGG.discount_sid, -1) = -1
     THEN CAST(AGG.last_sold_tmsp AS TIME)
     ELSE NULL
     END) AS timelastsold,
   SUM(CASE
     WHEN COALESCE(AGG.discount_sid, -1) <> -1 AND AGG.discount_weight_qty > 0
     THEN AGG.discount_net_val * -1
     ELSE 0
     END) AS discount_value_net,
   SUM(CASE
     WHEN COALESCE(AGG.discount_sid, -1) <> -1 AND AGG.discount_weight_qty > 0
     THEN AGG.piece_weight_qty
     ELSE 0
     END) AS discount_pieces,
   SUM(CASE
     WHEN COALESCE(AGG.discount_sid, -1) <> -1 AND AGG.discount_weight_qty > 0
     THEN AGG.discount_base_net_val + AGG.discount_net_val
     ELSE 0
     END) AS discount_turnover_net,
   SUM(CASE
     WHEN COALESCE(AGG.discount_sid, -1) <> -1 AND AGG.discount_weight_qty > 0
     THEN AGG.sales_piece_qty + AGG.sales_weight_qty - AGG.return_qty
     ELSE 0
     END) AS discount_weight_piece,
   SUM(CASE
     WHEN COALESCE(AGG.discount_sid, -1) <> -1 AND COALESCE(DIS.src_discount_pct, 0) > 0
     THEN IFNULL(AGG.piece_weight_qty, 0)
     ELSE 0
     END) AS discount_pieces_cashpoint,
   SUM(CASE
      WHEN COALESCE(AGG.discount_sid, -1) = -1
      THEN IFNULL(sfo.sum_piece_qty_sfo137, 0)
      ELSE 0
      END * (CASE
        WHEN COALESCE(AGG.discount_sid, -1) = -1
        THEN AGG.piece_weight_qty
        ELSE 0
        END + CASE
        WHEN COALESCE(AGG.discount_sid, -1) = -1
        THEN AGG.return_piece_weight_qty
        ELSE 0
        END)) AS discount_pieces_sfo
  FROM ldl_p_lew_bil_ac.v_agg_pos_store_item_day_2 AS AGG
   INNER JOIN ldl_p_lew_core_ac.v_item_map_key_2 AS ITMKEY ON AGG.client_id = ITMKEY.client_id AND AGG.item_sid = ITMKEY.item_sid
     
   INNER JOIN ldl_p_lew_bil_ac.v_item_2 AS ITM ON AGG.client_id = ITM.client_id AND AGG.item_sid = ITM.item_sid AND AGG.dwh_cal_dt
     BETWEEN ITM.dwh_valid_from AND ITM.dwh_valid_to
   INNER JOIN ldl_p_lew_bil_ac.v_store_2 AS LOC ON AGG.client_id = LOC.client_id AND AGG.loc_sid_store = LOC.loc_sid_store
       AND AGG.dwh_cal_dt BETWEEN LOC.dwh_valid_from AND LOC.dwh_valid_to
   INNER JOIN (SELECT client_id,
     loc_sid,
     dwh_cal_dt
    FROM ldl_p_lew_process_ac.v_wfm_export_agg_delta_2 AS DELTAVIEW
    WHERE process_name = 'export_wfm_itemsale_day_persist'
     AND process_specification = 'delta'
     AND aggregate_name IN ('t_agg_pos_store_item_day_2', 't_agg_store_day_item_sfo_2')
     AND dwh_cal_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 40 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY))
    GROUP BY client_id,
     loc_sid,
     dwh_cal_dt) AS delta_agg ON AGG.client_id = delta_agg.client_id AND AGG.dwh_cal_dt = delta_agg.dwh_cal_dt AND AGG.loc_sid_store
      = delta_agg.loc_sid
   LEFT JOIN (SELECT client_id,
     loc_sid_store,
     item_sid,
     dwh_cal_dt,
     SUM(piece_qty) AS sum_piece_qty_sfo137
    FROM ldl_p_lew_core.t_store_form_2 AS SFO
    WHERE sfo_type_id = 137
     AND pcwo_reason_id = 5
    GROUP BY client_id,
     loc_sid_store,
     item_sid,
     dwh_cal_dt) AS sfo ON AGG.client_id = sfo.client_id AND AGG.loc_sid_store = sfo.loc_sid_store AND AGG.item_sid =
      sfo.item_sid AND AGG.dwh_cal_dt = sfo.dwh_cal_dt
   LEFT JOIN ldl_p_lew_core.t_pos_discount_2 AS DIS ON AGG.client_id = DIS.client_id AND AGG.discount_sid = DIS.discount_sid
       AND DIS.src_posart = '@'
  WHERE AGG.dwh_cal_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 40 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY))
  GROUP BY AGG.client_id,
   store,
   item_2,
   receiptdate) AS ejr
 LEFT JOIN (SELECT t14.client_ AS clients,
   t14.store,
   t14.item_2,
   t14.receiptdate,
   SUM(t14.discount_pieces_txj) AS discount_pieces_txj
  FROM (SELECT T520.client_id AS client_,
     ORG.src_orig_store_nr AS store,
     CAST(ROUND(CAST(T520.item_nr AS FLOAT64)) AS INTEGER) AS item_2,
     T520.dwh_cal_dt AS receiptdate,
     T520.sales_qty AS discount_pieces_txj,
      T520.sales_val / CASE
       WHEN COALESCE(T520.sales_qty, 0) = 0
       THEN 1
       ELSE T520.sales_qty
       END AS price,
     T520.client_id,
     ORG.src_orig_store_nr,
     T520.item_nr,
     T520.dwh_cal_dt
    FROM ldl_p_lew_core_ac.v_txj_520_2 AS T520
     INNER JOIN ldl_p_lew_bil_ac.v_store_2 AS ORG ON T520.client_id = ORG.client_id AND T520.loc_sid = ORG.loc_sid_store
      AND T520.dwh_cal_dt BETWEEN ORG.dwh_valid_from AND ORG.dwh_valid_to
     INNER JOIN (SELECT client_id,
       loc_sid,
       dwh_cal_dt
      FROM ldl_p_lew_process_ac.v_wfm_export_agg_delta_2 AS DELTAVIEW
      WHERE process_name = 'export_wfm_itemsale_day_persist'
       AND process_specification = 'delta'
       AND aggregate_name IN ('t_agg_pos_store_item_day_2', 't_agg_store_day_item_sfo_2')
       AND dwh_cal_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 40 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY))
      GROUP BY client_id,
       loc_sid,
       dwh_cal_dt) AS delta_txj ON T520.client_id = delta_txj.client_id AND T520.dwh_cal_dt = delta_txj.dwh_cal_dt AND
       T520.loc_sid = delta_txj.loc_sid
    WHERE T520.dwh_cal_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 40 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY))
    QUALIFY price < (MAX(price) OVER (PARTITION BY T520.client_id, ORG.src_orig_store_nr, T520.item_nr, T520.dwh_cal_dt
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS t14
  GROUP BY clients,
   t14.store,
   t14.item_2,
   t14.receiptdate) AS txj ON ejr.client_id = txj.clients AND ejr.store = txj.store AND ejr.item_2 = txj.item_2 AND ejr.receiptdate
    = txj.receiptdate
 LEFT JOIN (SELECT t23.client_ AS client_id,
   t23.store,
   t23.item_2,
   t23.receiptdate,
   ROUND(t23.a0) AS discount_units
  FROM (SELECT AB.client_id AS client_,
     LOC0.src_orig_store_nr AS store,
     COALESCE(ITMKEY0.dwh_orig_item_nr, ITMKEY0.wawi_dwh_orig_item_nr) AS item_2,
     AB.booking_dat AS receiptdate,
     SUM(COALESCE(CASE
        WHEN AB.sfotype_id IN (137, 147) AND AB.pcwo_reason_id IN (5)
        THEN AB.sfo_total_qty_asis
        ELSE 0
        END, 0)) AS a0
    FROM ldl_p_lew_bil_ac.v_agg_store_day_item_sfo_asis_2 AS AB
     INNER JOIN ldl_p_lew_core_ac.v_item_map_key_2 AS ITMKEY0 ON AB.client_id = ITMKEY0.client_id AND AB.item_sid =
       ITMKEY0.item_sid
     INNER JOIN ldl_p_lew_bil_ac.v_item_2 AS ITM0 ON AB.client_id = ITM0.client_id AND AB.item_sid = ITM0.item_sid AND AB
       .booking_dat BETWEEN ITM0.dwh_valid_from AND ITM0.dwh_valid_to
     INNER JOIN ldl_p_lew_bil_ac.v_store_2 AS LOC0 ON AB.client_id = LOC0.client_id AND AB.loc_sid_store = LOC0.loc_sid_store
         AND AB.booking_dat BETWEEN LOC0.dwh_valid_from AND LOC0.dwh_valid_to
     INNER JOIN (SELECT client_id,
       loc_sid,
       dwh_cal_dt
      FROM ldl_p_lew_process_ac.v_wfm_export_agg_delta_2 AS DELTAVIEW
      WHERE process_name = 'export_wfm_itemsale_day_persist'
       AND process_specification = 'delta'
       AND aggregate_name IN ('t_agg_pos_store_item_day_2', 't_agg_store_day_item_sfo_2')
       AND dwh_cal_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 40 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY))
      GROUP BY client_id,
       loc_sid,
       dwh_cal_dt) AS delta_txj ON AB.client_id = delta_txj.client_id AND AB.booking_dat = delta_txj.dwh_cal_dt AND AB.loc_sid_store
        = delta_txj.loc_sid
    WHERE AB.booking_dat BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 40 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY))
    GROUP BY client_,
     store,
     item_2,
     receiptdate) AS t23) AS t1_2 ON ejr.client_id = t1.client_id AND ejr.store = t1.store AND ejr.item_2 = t1.item_2 AND ejr
   .receiptdate = t1.receiptdate
 LEFT JOIN (SELECT t30.client_ AS client_id,
   t30.store,
   t30.item_2,
   t30.receiptdate,
   t30.discount_lw
  FROM (SELECT AC.client_id AS client_,
     LOC1.src_orig_store_nr AS store,
     COALESCE(ITMKEY1.dwh_orig_item_nr, ITMKEY1.wawi_dwh_orig_item_nr) AS item_2,
     AC.booking_dat AS receiptdate,
     SUM(AC.sfo_total_rtl_rl_net_val / W.rate_currency_exchange) AS discount_lw
    FROM ldl_p_lew_bil.t_agg_store_day_item_sfo_2 AS AC
     INNER JOIN ldl_p_lew_core_ac.v_item_map_key_2 AS ITMKEY1 ON AC.client_id = ITMKEY1.client_id AND AC.item_sid =
       ITMKEY1.item_sid
     INNER JOIN ldl_p_lew_bil_ac.v_item_2 AS ITM1 ON AC.client_id = ITM1.client_id AND AC.item_sid = ITM1.item_sid AND AC
       .booking_dat BETWEEN ITM1.dwh_valid_from AND ITM1.dwh_valid_to
     INNER JOIN ldl_p_lew_bil_ac.v_store_2 AS LOC1 ON AC.client_id = LOC1.client_id AND AC.loc_sid_store = LOC1.loc_sid_store
         AND AC.booking_dat BETWEEN LOC1.dwh_valid_from AND LOC1.dwh_valid_to
     INNER JOIN ldl_p_lew_core.t_wawi_ref_client_currency_rate_2 AS W ON AC.client_id = W.client_id AND CURRENT_DATE
        BETWEEN W.dat_rec_start AND W.dat_rec_end AND W.currency_iso_cd = 'EUR'
     INNER JOIN (SELECT client_id,
       loc_sid,
       dwh_cal_dt
      FROM ldl_p_lew_process_ac.v_wfm_export_agg_delta_2 AS DELTAVIEW
      WHERE process_name = 'export_wfm_itemsale_day_persist'
       AND process_specification = 'delta'
       AND aggregate_name IN ('t_agg_pos_store_item_day_2', 't_agg_store_day_item_sfo_2')
       AND dwh_cal_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 40 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY))
      GROUP BY client_id,
       loc_sid,
       dwh_cal_dt) AS delta_txj ON AC.client_id = delta_txj.client_id AND AC.booking_dat = delta_txj.dwh_cal_dt AND AC.loc_sid_store
        = delta_txj.loc_sid
    WHERE AC.sfotype_id IN (137, 147)
     AND AC.pcwo_reason_id IN (5)
     AND AC.booking_dat BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 40 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY))
    GROUP BY client_,
     store,
     item_2,
     receiptdate) AS t30) AS t2 ON ejr.client_id = t2.client_id AND ejr.store = t2.store AND ejr.item_2 = t2.item_2 AND ejr
   .receiptdate = t2.receiptdate
 LEFT JOIN (SELECT t37.client_ AS client_id,
   t37.store,
   t37.item_2,
   t37.receiptdate,
   t37.discount_ejr
  FROM (SELECT AD.client_id AS client_,
     LOC2.src_orig_store_nr AS store,
     COALESCE(ITMKEY2.dwh_orig_item_nr, ITMKEY2.wawi_dwh_orig_item_nr) AS item_2,
     AD.dwh_cal_dt AS receiptdate,
     SUM(AD.sales_net_val / W0.rate_currency_exchange + AD.return_net_val / W0.rate_currency_exchange) AS discount_ejr
    FROM ldl_p_lew_bil.t_agg_pos_store_item_day_2 AS AD
     INNER JOIN ldl_p_lew_core_ac.v_item_map_key_2 AS ITMKEY2 ON AD.client_id = ITMKEY2.client_id AND AD.item_sid =
       ITMKEY2.item_sid
     INNER JOIN ldl_p_lew_bil_ac.v_item_2 AS ITM2 ON AD.client_id = ITM2.client_id AND AD.item_sid = ITM2.item_sid AND AD
       .dwh_cal_dt BETWEEN ITM2.dwh_valid_from AND ITM2.dwh_valid_to
     INNER JOIN ldl_p_lew_bil_ac.v_store_2 AS LOC2 ON AD.client_id = LOC2.client_id AND AD.loc_sid_store = LOC2.loc_sid_store
         AND AD.dwh_cal_dt BETWEEN LOC2.dwh_valid_from AND LOC2.dwh_valid_to
     INNER JOIN ldl_p_lew_core.t_wawi_ref_client_currency_rate_2 AS W0 ON AD.client_id = W0.client_id AND CURRENT_DATE
        BETWEEN W0.dat_rec_start AND W0.dat_rec_end AND W0.currency_iso_cd = 'EUR'
     INNER JOIN (SELECT client_id,
       loc_sid,
       dwh_cal_dt
      FROM ldl_p_lew_process_ac.v_wfm_export_agg_delta_2 AS DELTAVIEW
      WHERE process_name = 'export_wfm_itemsale_day_persist'
       AND process_specification = 'delta'
       AND aggregate_name IN ('t_agg_pos_store_item_day_2', 't_agg_store_day_item_sfo_2')
       AND dwh_cal_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 40 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY))
      GROUP BY client_id,
       loc_sid,
       dwh_cal_dt) AS delta_txj ON AD.client_id = delta_txj.client_id AND AD.dwh_cal_dt = delta_txj.dwh_cal_dt AND AD.loc_sid_store
        = delta_txj.loc_sid
    WHERE AD.dwh_cal_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 40 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY))
    GROUP BY client_,
     store,
     item_2,
     receiptdate) AS t37) AS t3 ON ejr.client_id = t3.client_id AND ejr.store = t3.store AND ejr.item_2 = t3.item_2 AND ejr
   .receiptdate = t3.receiptdate;