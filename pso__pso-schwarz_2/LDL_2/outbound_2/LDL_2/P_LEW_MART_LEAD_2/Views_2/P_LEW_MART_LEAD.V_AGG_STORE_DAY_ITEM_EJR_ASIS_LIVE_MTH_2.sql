CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_store_day_item_ejr_asis_live_mth_2 (client_id, cnt_discount_ejr_asis,
cnt_retail_ejr_asis, cnt_return_ejr_asis, cnt_void_ejr_asis, cnt_receipt, is_year_seq, dat_formdate, dat_calendar,
receipt_tmsp_hour, receipt_tmsp_half_hour, is_closed_hour, cy_month, item_id, orig_store_nr, discount_id,
price_rtl_ejr_adjstd_asis, price_rtl_net_ejr_adjstd_asis, price_rtl_ejr_asis, price_rtl_net_ejr_asis,
qty_disc_piece_ejr_asis, qty_disc_weight_ejr_asis, qty_disc_piece_weigth_ejr_asis, qty_piece_ejr_asis,
qty_return_ejr_asis, qty_void_ejr_asis, qty_weight_ejr_asis, store_id, move_to_store_id, aspect_id,
time_last_sold_ejr_asis, val_discount_ejr_asis, val_discount_net_ejr_asis, val_discount_hq_ejr_asis,
val_discount_hq_net_ejr_asis, val_disc_rtl_gross_ejr_asis, val_disc_rtl_net_ejr_asis, val_return_ejr_asis,
val_rtl_ejr_asis, val_void_ejr_asis, val_void_net_ejr_asis, val_rtl_net_ejr_asis, val_return_net_ejr_asis,
qty_piece_weight_ejr_asis, qty_rt_piece_weight_ejr_asis, qty_return_defect_ejr_asis, qty_return_saleable_ejr_asis,
qty_rt_pc_wt_defect_ejr_asis, qty_rt_pc_wt_saleable_ejr_asis, qty_disc_piece_fa_ejr_asis, qty_disc_weight_fa_ejr_asis,
qty_disc_piece_wt_fa_ejr_asis, qty_piece_fa_ejr_asis, qty_return_fa_ejr_asis, qty_weight_fa_ejr_asis,
val_discount_fa_ejr_asis, val_discount_net_fa_ejr_asis, val_discount_hq_fa_ejr_asis, val_disc_hq_net_fa_ejr_asis,
val_disc_rtl_gross_fa_ejr_asis, val_disc_rtl_net_fa_ejr_asis, val_return_fa_ejr_asis, val_rtl_fa_ejr_asis,
val_rtl_net_fa_ejr_asis, val_return_net_fa_ejr_asis, qty_piece_weight_fa_ejr_asis, qty_rt_piece_wt_fa_ejr_asis,
qty_return_defect_fa_ejr_asis, qty_return_sale_fa_ejr_asis, qty_rt_pc_wt_dfct_fa_ejr_asis, qty_rt_pc_wt_sale_fa_ejr_asis
, currency_iso_cd, last_refresh) AS SELECT AGG.client_id,
  CASE
  WHEN AGG.discount_sid > -1 AND AGG.discount_weight_qty <> 0
  THEN AGG.cnt_sale
  ELSE 0
  END AS cnt_discount_ejr_asis,
  CASE
  WHEN AGG.discount_sid = -1
  THEN AGG.cnt_sale
  ELSE 0
  END AS cnt_retail_ejr_asis,
  CASE
  WHEN AGG.discount_sid = -1
  THEN AGG.cnt_return
  ELSE 0
  END AS cnt_return_ejr_asis,
  CASE
  WHEN AGG.discount_sid = -1
  THEN AGG.cnt_void
  ELSE 0
  END AS cnt_void_ejr_asis,
  CASE
  WHEN AGG.discount_sid = -1
  THEN AGG.cnt_distinct_receipt
  ELSE 0
  END AS cnt_receipt,
 AGG.is_year_seq,
 AGG.dwh_cal_dt AS dat_formdate,
  CASE
  WHEN AGG.is_year_seq = 1
  THEN CAL.cal_dt
  ELSE AGG.dwh_cal_dt
  END AS dat_calendar,
 AGG.receipt_tmsp_hour,
 AGG.receipt_tmsp_half_hour,
  CASE
  WHEN CL_HR.open_hr > AGG.receipt_tmsp_hour OR CASE
     WHEN AGG.is_year_seq = 1
     THEN CAL.cal_dt
     ELSE AGG.dwh_cal_dt
     END < CURRENT_DATE
  THEN 1
  ELSE 0
  END AS is_closed_hour,
 AGG.cy_month,
 AGG.mapped_item_sid AS item_id,
 AGG.src_orig_store_nr AS orig_store_nr,
 AGG.discount_sid AS discount_id,
  AGG.total_item_unit_price_adjust_gross / CRY.rate_currency_exchange AS price_rtl_ejr_adjstd_asis,
  AGG.total_item_unit_price_adjust_net / CRY.rate_currency_exchange AS price_rtl_net_ejr_adjstd_asis,
  AGG.total_item_unit_price_gross / CRY.rate_currency_exchange AS price_rtl_ejr_asis,
  AGG.total_item_unit_price_net / CRY.rate_currency_exchange AS price_rtl_net_ejr_asis,
  CASE
  WHEN AGG.discount_sid > -1 AND AGG.discount_weight_qty <> 0
  THEN AGG.sales_piece_qty
  ELSE 0
  END AS qty_disc_piece_ejr_asis,
  CASE
  WHEN AGG.discount_sid > -1 AND AGG.discount_weight_qty <> 0
  THEN AGG.sales_weight_qty
  ELSE 0
  END AS qty_disc_weight_ejr_asis,
  CASE
  WHEN AGG.discount_sid > -1 AND AGG.discount_weight_qty <> 0
  THEN AGG.piece_weight_qty
  ELSE 0
  END AS qty_disc_piece_weigth_ejr_asis,
  CASE
  WHEN AGG.discount_sid = -1
  THEN CASE
   WHEN MPACK.client_id IS NOT NULL
   THEN AGG.sales_piece_qty * MPACK.item_rel_rate
   ELSE AGG.sales_piece_qty
   END
  ELSE 0
  END AS qty_piece_ejr_asis,
  CASE
  WHEN AGG.discount_sid = -1
  THEN CASE
   WHEN MPACK.client_id IS NOT NULL
   THEN AGG.return_qty * MPACK.item_rel_rate
   ELSE AGG.return_qty
   END
  ELSE 0
  END AS qty_return_ejr_asis,
  CASE
  WHEN AGG.discount_sid = -1
  THEN AGG.void_qty
  ELSE 0
  END AS qty_void_ejr_asis,
  CASE
  WHEN AGG.discount_sid = -1
  THEN CASE
   WHEN MPACK.client_id IS NOT NULL
   THEN AGG.sales_weight_qty * MPACK.item_rel_rate
   ELSE AGG.sales_weight_qty
   END
  ELSE 0
  END AS qty_weight_ejr_asis,
 AGG.loc_sid_store AS store_id,
 OSM.loc_sid_store_move_to AS move_to_store_id,
 OSM.aspect_id,
  CASE
  WHEN AGG.discount_sid = -1
  THEN AGG.last_sold_tmsp
  ELSE NULL
  END AS time_last_sold_ejr_asis,
  CASE
  WHEN AGG.discount_sid > -1 AND AGG.discount_weight_qty <> 0
  THEN AGG.discount_gross_val / CRY.rate_currency_exchange
  ELSE 0
  END AS val_discount_ejr_asis,
  CASE
  WHEN AGG.discount_sid > -1 AND AGG.discount_weight_qty <> 0
  THEN AGG.discount_net_val / CRY.rate_currency_exchange
  ELSE 0
  END AS val_discount_net_ejr_asis,
  CASE
  WHEN AGG.discount_sid > -1 AND AGG.discount_piece_qty <> 0
  THEN AGG.discount_gross_val / CRY.rate_currency_exchange
  ELSE 0
  END AS val_discount_hq_ejr_asis,
  CASE
  WHEN AGG.discount_sid > -1 AND AGG.discount_piece_qty <> 0
  THEN AGG.discount_net_val / CRY.rate_currency_exchange
  ELSE 0
  END AS val_discount_hq_net_ejr_asis,
  CASE
  WHEN AGG.discount_sid > -1 AND AGG.discount_weight_qty <> 0
  THEN (AGG.discount_base_gross_val + AGG.discount_gross_val) / CRY.rate_currency_exchange
  ELSE NULL
  END AS val_disc_rtl_gross_ejr_asis,
  CASE
  WHEN AGG.discount_sid > -1 AND AGG.discount_weight_qty <> 0
  THEN (AGG.discount_base_net_val + AGG.discount_net_val) / CRY.rate_currency_exchange
  ELSE NULL
  END AS val_disc_rtl_net_ejr_asis,
  AGG.return_gross_val / CRY.rate_currency_exchange AS val_return_ejr_asis,
  AGG.sales_gross_val / CRY.rate_currency_exchange AS val_rtl_ejr_asis,
  AGG.void_gross_val / CRY.rate_currency_exchange AS val_void_ejr_asis,
  AGG.void_net_val / CRY.rate_currency_exchange AS val_void_net_ejr_asis,
  AGG.sales_net_val / CRY.rate_currency_exchange AS val_rtl_net_ejr_asis,
  AGG.return_net_val / CRY.rate_currency_exchange AS val_return_net_ejr_asis,
  CASE
  WHEN AGG.discount_sid = -1
  THEN AGG.piece_weight_qty
  ELSE 0
  END AS qty_piece_weight_ejr_asis,
  CASE
  WHEN AGG.discount_sid = -1
  THEN AGG.return_piece_weight_qty
  ELSE 0
  END AS qty_rt_piece_weight_ejr_asis,
  CASE
  WHEN AGG.discount_sid = -1
  THEN AGG.return_defect_qty
  ELSE 0
  END AS qty_return_defect_ejr_asis,
  CASE
  WHEN AGG.discount_sid = -1
  THEN AGG.return_saleable_qty
  ELSE 0
  END AS qty_return_saleable_ejr_asis,
  CASE
  WHEN AGG.discount_sid = -1
  THEN AGG.return_defect_pc_wt_qty
  ELSE 0
  END AS qty_rt_pc_wt_defect_ejr_asis,
  CASE
  WHEN AGG.discount_sid = -1
  THEN AGG.return_saleable_pc_wt_qty
  ELSE 0
  END AS qty_rt_pc_wt_saleable_ejr_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN CASE
   WHEN AGG.discount_sid > -1 AND AGG.discount_weight_qty <> 0
   THEN AGG.sales_piece_qty
   ELSE 0
   END
  ELSE NULL
  END AS qty_disc_piece_fa_ejr_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN CASE
   WHEN AGG.discount_sid > -1 AND AGG.discount_weight_qty <> 0
   THEN AGG.sales_weight_qty
   ELSE 0
   END
  ELSE NULL
  END AS qty_disc_weight_fa_ejr_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN CASE
   WHEN AGG.discount_sid > -1 AND AGG.discount_weight_qty <> 0
   THEN AGG.piece_weight_qty
   ELSE 0
   END
  ELSE NULL
  END AS qty_disc_piece_wt_fa_ejr_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN CASE
   WHEN AGG.discount_sid = -1
   THEN CASE
    WHEN MPACK.client_id IS NOT NULL
    THEN AGG.sales_piece_qty * MPACK.item_rel_rate
    ELSE AGG.sales_piece_qty
    END
   ELSE 0
   END
  ELSE NULL
  END AS qty_piece_fa_ejr_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN CASE
   WHEN AGG.discount_sid = -1
   THEN CASE
    WHEN MPACK.client_id IS NOT NULL
    THEN AGG.return_qty * MPACK.item_rel_rate
    ELSE AGG.return_qty
    END
   ELSE 0
   END
  ELSE NULL
  END AS qty_return_fa_ejr_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN CASE
   WHEN AGG.discount_sid = -1
   THEN CASE
    WHEN MPACK.client_id IS NOT NULL
    THEN AGG.sales_weight_qty * MPACK.item_rel_rate
    ELSE AGG.sales_weight_qty
    END
   ELSE 0
   END
  ELSE NULL
  END AS qty_weight_fa_ejr_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN CASE
   WHEN AGG.discount_sid > -1 AND AGG.discount_weight_qty <> 0
   THEN AGG.discount_gross_val / CRY.rate_currency_exchange
   ELSE 0
   END
  ELSE NULL
  END AS val_discount_fa_ejr_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN CASE
   WHEN AGG.discount_sid > -1 AND AGG.discount_weight_qty <> 0
   THEN AGG.discount_net_val / CRY.rate_currency_exchange
   ELSE 0
   END
  ELSE NULL
  END AS val_discount_net_fa_ejr_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN CASE
   WHEN AGG.discount_sid > -1 AND AGG.discount_piece_qty <> 0
   THEN AGG.discount_gross_val / CRY.rate_currency_exchange
   ELSE 0
   END
  ELSE NULL
  END AS val_discount_hq_fa_ejr_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN CASE
   WHEN AGG.discount_sid > -1 AND AGG.discount_piece_qty <> 0
   THEN AGG.discount_net_val / CRY.rate_currency_exchange
   ELSE 0
   END
  ELSE NULL
  END AS val_disc_hq_net_fa_ejr_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN CASE
   WHEN AGG.discount_sid > -1 AND AGG.discount_weight_qty <> 0
   THEN (AGG.discount_base_gross_val + AGG.discount_gross_val) / CRY.rate_currency_exchange
   ELSE NULL
   END
  ELSE NULL
  END AS val_disc_rtl_gross_fa_ejr_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN CASE
   WHEN AGG.discount_sid > -1 AND AGG.discount_weight_qty <> 0
   THEN (AGG.discount_base_net_val + AGG.discount_net_val) / CRY.rate_currency_exchange
   ELSE NULL
   END
  ELSE NULL
  END AS val_disc_rtl_net_fa_ejr_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN AGG.return_gross_val / CRY.rate_currency_exchange
  ELSE NULL
  END AS val_return_fa_ejr_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN AGG.sales_gross_val / CRY.rate_currency_exchange
  ELSE NULL
  END AS val_rtl_fa_ejr_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN AGG.sales_net_val / CRY.rate_currency_exchange
  ELSE NULL
  END AS val_rtl_net_fa_ejr_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN AGG.return_net_val / CRY.rate_currency_exchange
  ELSE NULL
  END AS val_return_net_fa_ejr_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN CASE
   WHEN AGG.discount_sid = -1
   THEN AGG.piece_weight_qty
   ELSE 0
   END
  ELSE NULL
  END AS qty_piece_weight_fa_ejr_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN CASE
   WHEN AGG.discount_sid = -1
   THEN AGG.return_piece_weight_qty
   ELSE 0
   END
  ELSE NULL
  END AS qty_rt_piece_wt_fa_ejr_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN CASE
   WHEN AGG.discount_sid = -1
   THEN AGG.return_defect_qty
   ELSE 0
   END
  ELSE NULL
  END AS qty_return_defect_fa_ejr_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN CASE
   WHEN AGG.discount_sid = -1
   THEN AGG.return_saleable_qty
   ELSE 0
   END
  ELSE NULL
  END AS qty_return_sale_fa_ejr_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN CASE
   WHEN AGG.discount_sid = -1
   THEN AGG.return_defect_pc_wt_qty
   ELSE 0
   END
  ELSE NULL
  END AS qty_rt_pc_wt_dfct_fa_ejr_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN CASE
   WHEN AGG.discount_sid = -1
   THEN AGG.return_saleable_pc_wt_qty
   ELSE 0
   END
  ELSE NULL
  END AS qty_rt_pc_wt_sale_fa_ejr_asis,
 CRY.currency_iso_cd,
 COALESCE(AGC.last_refresh, AGG.dwh_created) AS last_refresh
FROM ldl_p_lew_bil_ac.v_agg_pos_store_item_day_live_mth_2 AS AGG
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS CRY ON AGG.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
 LEFT JOIN ldl_p_lew_bil_ac.v_org_store_merge_2 AS OSM ON AGG.client_id = OSM.client_id AND AGG.loc_sid_store = OSM.loc_sid_store
   
 LEFT JOIN (SELECT CTU.client_id,
   MAX(CTU.create_timestamp) AS last_refresh
  FROM ldl_p_lew_process_ac.v_agc_core_table_update_2 AS CTU
   INNER JOIN (SELECT client_id,
     MAX(start_processing) AS start_processing
    FROM ldl_p_lew_process_ac.v_agc_run_log_2
    WHERE aggregate_name LIKE 'T_AGG_POS_STORE_ITEM_DAY_LIVE_MTH_2'
     AND DATE(dwh_cal_dt) = CURRENT_DATE
     AND end_processing IS NOT NULL
    GROUP BY client_id) AS RLOG ON CTU.create_timestamp <= RLOG.start_processing AND CTU.client_id = RLOG.client_id
  WHERE CTU.core_table_name = 'T_POS_RECEIPTLINE_LIVE_2'
   AND DATE(CTU.dwh_cal_dt) = CURRENT_DATE
  GROUP BY CTU.client_id) AS AGC ON AGG.client_id = AGC.client_id
 INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL ON AGG.dwh_cal_dt = CAL.cal_dt_swday_prev_1y
 LEFT JOIN (SELECT DISTINCT AGG0.client_id,
   AGG0.loc_sid_store,
   AGG0.dwh_cal_dt,
   MAX(AGG0.receipt_tmsp_hour) OVER (PARTITION BY AGG0.client_id, AGG0.loc_sid_store, CAL0.cal_dt RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS open_hr
  FROM ldl_p_lew_bil_ac.v_agg_pos_store_item_day_live_2 AS AGG0
   INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL0 ON AGG0.dwh_cal_dt = CAL0.cal_dt_swday_prev_1y) AS CL_HR ON
    AGG.client_id = CL_HR.client_id AND AGG.loc_sid_store = CL_HR.loc_sid_store AND CASE
    WHEN AGG.is_year_seq = 1
    THEN CAL.cal_dt
    ELSE AGG.dwh_cal_dt
    END = CL_HR.dwh_cal_dt
 LEFT JOIN ldl_p_lew_bil.v_item_multipack_hist_2 AS MPACK ON AGG.client_id = MPACK.client_id AND AGG.mapped_item_sid =
    MPACK.item_sid AND AGG.dwh_cal_dt BETWEEN CAST(MPACK.dwh_valid_from AS DATE) AND MPACK.dwh_valid_to;