CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_AGG_WH_ITM_MTH_SALES_ASIS as
   SELECT t.client_id,	
   oss.loc_sid_wh,	
   t.orig_item_nr,	
   t.dat_valid_from AS dat_valid_from_item,	
   t.cy_month,	
   Sum(CASE WHEN t.flg_having = 1 THEN t.qty_total ELSE NULL END) AS qty_total,	
   Count(DISTINCT CASE WHEN  t.flg_having = 1 THEN t.loc_sid_store || '-' || t.cy_week ELSE NULL END) AS cnt_store_week,	
   Sum(CASE WHEN t.flg_having = 1 THEN t.qty_total ELSE NULL END) / CASE WHEN Count(DISTINCT CASE WHEN  t.flg_having = 1 THEN t.loc_sid_store || '-' || t.cy_week ELSE NULL END) = 0 THEN null ELSE Count(DISTINCT CASE WHEN  t.flg_having = 1 THEN t.loc_sid_store || '-' || t.cy_week ELSE NULL END) END AS avg_qty_sold_per_str_week,	
   Sum(t.val_turnover) AS val_rtl_ejr_asis,	
   Sum(t.val_turnover_net) AS val_rtl_net_ejr_asis,	
   Sum(CASE WHEN t.flg_having = 1 THEN etw.sales_gross_val_pos ELSE NULL END) AS val_rtl_str_days_w_sales_asis,	
   Sum(CASE WHEN t.flg_having_net = 1 THEN etw.sales_net_val_pos ELSE NULL END) AS val_rtl_str_net_days_w_sales_asis,	
   100 * Sum(t.val_turnover) / CASE WHEN Sum(CASE WHEN t.flg_having = 1 THEN etw.sales_gross_val_pos ELSE NULL END) = 0 THEN null ELSE Sum(CASE WHEN t.flg_having = 1 THEN etw.sales_gross_val_pos ELSE NULL END) END AS item_turnover_ratio_eff,	
   100 * Sum(t.val_turnover_net) / CASE WHEN Sum(CASE WHEN t.flg_having_net = 1 THEN etw.sales_net_val_pos ELSE NULL END) = 0 THEN null ELSE Sum(CASE WHEN t.flg_having_net = 1 THEN etw.sales_net_val_pos ELSE NULL END) END AS item_turnover_ratio_net_eff	
   /* Beschreibung	
   Es muss auf die Tagesebene gegangen werden, da Durchschnitte pro Woche gebildet werden.*/	
   FROM (	
       SELECT	
           ejr.client_id,	
   ejr.loc_sid_store,	
   i.orig_item_nr,	
   i.dat_valid_from,	
   ejr.dwh_cal_dt,	
   cal.cy_week,	
   ejr.cy_month,	
   Sum(ZeroIfNull(ejr.sales_piece_qty) + ZeroIfNull(ejr.return_qty) + ZeroIfNull(ejr.sales_weight_qty)) AS qty_total,	
   Sum(ZeroIfNull(ejr.sales_gross_val) + ZeroIfNull(ejr.return_gross_val)) AS val_turnover,	
   Sum(ZeroIfNull(ejr.sales_net_val) + ZeroIfNull(ejr.return_net_val)) AS val_turnover_net,	
   CASE WHEN (   qty_total > 0	
                       --Consider the special case, that sold and returned qty are balanced and not zero. Those lines need to be considered (flg = 1).	
                       OR (    qty_total = 0	
                           AND Sum(ZeroIfNull(ejr.return_qty)) <> 0))	
                       AND val_turnover >= 0 THEN 1 ELSE 0 END AS flg_having,	
   CASE WHEN (   qty_total > 0	
                       --Consider the special case, that sold and returned qty are balanced and not zero. Those lines need to be considered (flg = 1).	
                       OR (    qty_total = 0	
                           AND Sum(ZeroIfNull(ejr.return_qty)) <> 0))	
                       AND val_turnover_net >= 0 THEN 1 ELSE 0 END AS flg_having_net	
      FROM p_lew_bil_ac.v_agg_pos_store_item_day AS ejr	
   INNER JOIN (	
   SELECT i.client_id,	
   i.item_sid,	
   TRY_CAST(Coalesce(i.src_orig_item_nr, i.config_item_cd, i.src_matnr) AS DECIMAL(18,0)) AS orig_item_nr,	
   Coalesce(i.src_dat_valid_from, Max(i.src_dat_valid_from) Over (PARTITION BY i.client_id, Coalesce(i.item_sid_config, i.item_sid))) AS dat_valid_from	
              FROM p_lew_core_ac.v_item AS i	
   ) AS i	
   ON  i.client_id = ejr.client_id	
   AND i.item_sid = ejr.item_sid	
   INNER JOIN p_lew_core_ac.v_cal_calendarday AS cal	
   ON ejr.dwh_cal_dt = cal.cal_dt	
   WHERE (ejr.discount_sid = -1 OR ejr.discount_sid IS NULL)	
   GROUP BY ejr.client_id	
       , ejr.loc_sid_store	
       , i.orig_item_nr	
       , i.dat_valid_from	
       , ejr.dwh_cal_dt	
       , cal.cy_week	
       , ejr.cy_month	
) AS t	
   INNER JOIN p_lew_bil_ac.v_agg_pos_txj_wawi_store_day AS etw	
   ON  t.client_id = etw.client_id	
   AND t.loc_sid_store = etw.loc_sid	
   AND t.dwh_cal_dt = etw.dwh_cal_dt	
   INNER JOIN p_lew_bil_ac.v_store_to_warehouse_lastknown AS oss	
   ON  t.client_id = oss.client_id	
   AND t.loc_sid_store = oss.loc_sid_store	
   AND oss.dwh_actual_fg = 1	
   AND oss.active_fg = 1	
GROUP BY t.client_id	
, oss.loc_sid_wh	
, t.orig_item_nr	
, t.dat_valid_from	
, t.cy_month	
;