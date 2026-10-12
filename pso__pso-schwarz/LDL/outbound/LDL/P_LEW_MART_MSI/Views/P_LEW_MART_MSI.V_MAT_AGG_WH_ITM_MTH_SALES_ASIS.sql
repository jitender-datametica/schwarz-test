CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_agg_wh_itm_mth_sales_asis AS
/* Beschreibung	
   Es muss auf die Tagesebene gegangen werden, da Durchschnitte pro Woche gebildet werden. */ SELECT t
 .client_id,
 OSS.loc_sid_wh,
 t.orig_item_nr,
 t.dat_valid_from AS dat_valid_from_item,
 t.cy_month,
 SUM(CASE
   WHEN t.flg_having = 1
   THEN t.qty_total
   ELSE NULL
   END) AS qty_total,
 COUNT(DISTINCT CASE
   WHEN t.flg_having = 1
   THEN CAST(t.loc_sid_store AS STRING) || '-' || CAST(t.cy_week AS STRING)
   ELSE NULL
   END) AS cnt_store_week,
  SUM(CASE
    WHEN t.flg_having = 1
    THEN t.qty_total
    ELSE NULL
    END) / CASE
   WHEN COUNT(DISTINCT CASE
      WHEN t.flg_having = 1
      THEN CAST(t.loc_sid_store AS STRING) || '-' || CAST(t.cy_week AS STRING)
      ELSE NULL
      END) = 0
   THEN NULL
   ELSE COUNT(DISTINCT CASE
     WHEN t.flg_having = 1
     THEN CAST(t.loc_sid_store AS STRING) || '-' || CAST(t.cy_week AS STRING)
     ELSE NULL
     END)
   END AS avg_qty_sold_per_str_week,
 SUM(t.val_turnover) AS val_rtl_ejr_asis,
 SUM(t.val_turnover_net) AS val_rtl_net_ejr_asis,
 SUM(CASE
   WHEN t.flg_having = 1
   THEN ETW.sales_gross_val_pos
   ELSE NULL
   END) AS val_rtl_str_days_w_sales_asis,
 SUM(CASE
   WHEN t.flg_having_net = 1
   THEN ETW.sales_net_val_pos
   ELSE NULL
   END) AS val_rtl_str_net_days_w_sales_asis,
   100 * SUM(t.val_turnover) / CASE
   WHEN SUM(CASE
      WHEN t.flg_having = 1
      THEN ETW.sales_gross_val_pos
      ELSE NULL
      END) = 0
   THEN NULL
   ELSE SUM(CASE
     WHEN t.flg_having = 1
     THEN ETW.sales_gross_val_pos
     ELSE NULL
     END)
   END AS item_turnover_ratio_eff,
   100 * SUM(t.val_turnover_net) / CASE
   WHEN SUM(CASE
      WHEN t.flg_having_net = 1
      THEN ETW.sales_net_val_pos
      ELSE NULL
      END) = 0
   THEN NULL
   ELSE SUM(CASE
     WHEN t.flg_having_net = 1
     THEN ETW.sales_net_val_pos
     ELSE NULL
     END)
   END AS item_turnover_ratio_net_eff
FROM (SELECT EJR.client_id,
   EJR.loc_sid_store,
   i.orig_item_nr,
   i.dat_valid_from,
   EJR.dwh_cal_dt,
   CAL.cy_week,
   EJR.cy_month,
   SUM(IFNULL(EJR.sales_piece_qty, 0) + IFNULL(EJR.return_qty, 0) + IFNULL(EJR.sales_weight_qty, 0)) AS qty_total,
   SUM(IFNULL(EJR.sales_gross_val, 0) + IFNULL(EJR.return_gross_val, 0)) AS val_turnover,
   SUM(IFNULL(EJR.sales_net_val, 0) + IFNULL(EJR.return_net_val, 0)) AS val_turnover_net,
    CASE
    WHEN (SUM(IFNULL(EJR.sales_piece_qty, 0) + IFNULL(EJR.return_qty, 0) + IFNULL(EJR.sales_weight_qty, 0)) > 0
        -- Consider the special case, that sold and returned qty are balanced and not zero. Those lines need to be considered (flg = 1).

         OR SUM(IFNULL(EJR.sales_piece_qty, 0) + IFNULL(EJR.return_qty, 0) + IFNULL(EJR.sales_weight_qty, 0)) = 0 AND
         SUM(IFNULL(EJR.return_qty, 0)) <> 0) AND SUM(IFNULL(EJR.sales_gross_val, 0) + IFNULL(EJR.return_gross_val, 0))
      >= 0
    THEN 1
    ELSE 0
    END AS flg_having,
    CASE
    WHEN (SUM(IFNULL(EJR.sales_piece_qty, 0) + IFNULL(EJR.return_qty, 0) + IFNULL(EJR.sales_weight_qty, 0)) > 0
        -- Consider the special case, that sold and returned qty are balanced and not zero. Those lines need to be considered (flg = 1).

         OR SUM(IFNULL(EJR.sales_piece_qty, 0) + IFNULL(EJR.return_qty, 0) + IFNULL(EJR.sales_weight_qty, 0)) = 0 AND
         SUM(IFNULL(EJR.return_qty, 0)) <> 0) AND SUM(IFNULL(EJR.sales_net_val, 0) + IFNULL(EJR.return_net_val, 0)) >= 0
      
    THEN 1
    ELSE 0
    END AS flg_having_net
  FROM ldl_p_lew_bil_ac.v_agg_pos_store_item_day AS EJR
   INNER JOIN (SELECT client_id,
     item_sid,
     ROUND(SAFE_CAST(COALESCE(src_orig_item_nr, config_item_cd, src_matnr) AS BIGNUMERIC), 0) AS orig_item_nr,
     COALESCE(src_dat_valid_from, MAX(src_dat_valid_from) OVER (PARTITION BY CAST(client_id AS STRING), CAST(COALESCE(item_sid_config, item_sid) AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AS dat_valid_from
    FROM ldl_p_lew_core_ac.v_item AS I) AS i ON EJR.client_id = i.client_id AND EJR.item_sid = i.item_sid
   INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday AS CAL ON EJR.dwh_cal_dt = CAL.cal_dt
  WHERE EJR.discount_sid = - 1
   OR EJR.discount_sid IS NULL
  GROUP BY EJR.client_id,
   EJR.loc_sid_store,
   i.orig_item_nr,
   i.dat_valid_from,
   EJR.dwh_cal_dt,
   CAL.cy_week,
   EJR.cy_month) AS t
 INNER JOIN ldl_p_lew_bil_ac.v_agg_pos_txj_wawi_store_day AS ETW ON t.client_id = ETW.client_id AND t.loc_sid_store =
    ETW.loc_sid AND t.dwh_cal_dt = ETW.dwh_cal_dt
 INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_lastknown AS OSS ON t.client_id = OSS.client_id AND t.loc_sid_store =
     OSS.loc_sid_store AND OSS.dwh_actual_fg = 1 AND OSS.active_fg = 1
GROUP BY t.client_id,
 OSS.loc_sid_wh,
 t.orig_item_nr,
 dat_valid_from_item,
 t.cy_month;