CREATE OR REPLACE view P_LEW_MART_LEAD.V_MAT_REV_TOPSELL_STORE_HR_1 as
   SELECT
       r.client_id                AS client_id,
   r.dwh_cal_dt               AS dat_formdate,
   org.loc_sid_store_move_to  AS loc_sid_store_move_to,
   org.loc_sid_wh             AS wh_loc_sid,
   wh.src_wh_id               AS wh_id,
   cal.cy_week                AS cy_week,
   EXTRACT(HOUR FROM  r.receipt_tmsp ) AS time_hour_id,
   1 AS receipt_for_count_id,
   SUM(
        CASE WHEN r.weight_item_fg = 0
             THEN r.sales_piece_qty
             ELSE 0
        END )AS qty_piece_ejr,
   SUM(
        CASE WHEN r.weight_item_fg = 1
             THEN r.sales_weight_qty
             ELSE 0
        END )AS qty_weight_ejr,
   qty_piece_ejr+qty_weight_ejr AS qty_sold,
   SUM(CAST (r.sales_val * (COALESCE(100/ CASE WHEN CAST(r.vat_pct_val AS DECIMAL(19,6))+100 = 0 THEN null ELSE CAST(r.vat_pct_val AS DECIMAL(19,6))+100 END, 1) ) / cry.rate_currency_exchange AS DECIMAL(19,5))) AS val_retail_net_ejr,
   CURRENT_TIMESTAMP(6) AS dwh_updated
   FROM p_lew_core_ac.v_pos_receiptline_1 AS r
   INNER JOIN p_lew_core_ac.v_cal_calendarday_1    cal
   ON  r.dwh_cal_dt=cal.cal_dt
   AND cal.cy_month_seq BETWEEN -36 AND 1
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS cry
   ON  r.client_id = cry.client_id
   AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end
   INNER JOIN p_lew_core_ac.v_item_map_key_1      itm
   ON  r.client_id=itm.client_id
   AND r.item_sid=itm.item_sid
   INNER JOIN p_lew_bil_ac.v_org_store_merge_1 org
   ON r.client_id         = org.client_id
   AND r.loc_sid          = org.loc_sid_store
   AND org.aspect_id      = 1
   INNER JOIN p_lew_core_ac.v_location_1 wh
   ON org.loc_sid_wh    = wh.loc_sid
   AND r.client_id    = wh.client_id
   AND wh.wh_store_mark ='B'

   WHERE r.turnover_relevant_fg = 1

   GROUP BY
      r.client_id
     ,org.loc_sid_store_move_to
     ,org.loc_sid_wh
     ,wh.src_wh_id
     ,r.dwh_cal_dt
     ,cal.cy_week
     ,time_hour_id
     ,receipt_for_count_id
;