/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.V_AGG_REV_TOPSELL_ITEM_HR
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  ----
#  1.1  27.06.2024    Marcin Malec              Filtering out live and future data; User Story 641977: [BE] - Umsatz EJR (1104001.02) is showing live data
#
#----------------------------------------------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_AGG_REV_TOPSELL_ITEM_HR AS
   SELECT
    r.client_id                AS client_id
   ,r.item_sid                 AS item_sid
   ,r.dwh_cal_dt               AS dat_formdate
   ,org.loc_sid_store_move_to  AS loc_sid_store_move_to
   ,org.loc_sid_wh             AS wh_loc_sid
   ,wh.src_wh_id               AS wh_id
   ,cal.cy_week                AS cy_week
   ,cry.curr_cd_from           AS currency_iso_cd
   ,EXTRACT(HOUR FROM  r.receipt_tmsp ) AS time_hour_id
   ,SUM(
        CASE WHEN r.weight_item_fg = 0
             THEN r.sales_piece_qty
             ELSE 0
        END )AS qty_piece_ejr
   ,SUM(
        CASE WHEN r.weight_item_fg = 1
             THEN r.sales_weight_qty
             ELSE 0
        END )AS qty_weight_ejr
   ,qty_piece_ejr+qty_weight_ejr AS qty_sold
   ,SUM(CAST (r.sales_val * (COALESCE(100/ CASE WHEN CAST(r.vat_pct_val AS DECIMAL(19,6))+100 = 0 THEN NULL ELSE CAST(r.vat_pct_val AS DECIMAL(19,6))+100 END, 1) ) / cry.exchange_rate AS DECIMAL(19,5))) AS val_retail_net_ejr
   ,CURRENT_TIMESTAMP(6) AS dwh_updated
   FROM p_lew_core_ac.v_pos_receiptline AS r
   INNER JOIN p_lew_core_ac.v_cal_calendarday    cal
   ON  r.dwh_cal_dt=cal.cal_dt
   AND cal.cy_month_seq BETWEEN -36 AND 1
   INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist AS cry
   ON    r.client_id = cry.client_id
   AND   CURRENT_DATE BETWEEN cry.active_from_dt AND cry.active_to_dt
   AND   CURRENT_DATE BETWEEN cry.dwh_valid_from AND cry.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_exchange_rate_type c
   ON    c.client_id        = cry.client_id
   AND   c.x_rate_type_sid  = cry.x_rate_type_sid
   AND   c.src_kurst        = '@BEWE'
   INNER JOIN p_lew_bil_ac.v_org_store_merge org
   ON r.client_id         = org.client_id
   AND r.loc_sid          = org.loc_sid_store
   AND org.aspect_id      = 1
   INNER JOIN p_lew_core_ac.v_location wh
   ON org.loc_sid_wh    = wh.loc_sid
   AND r.client_id      = wh.client_id
   AND wh.wh_store_mark ='B'

   WHERE r.turnover_relevant_fg = 1
   AND r.dwh_cal_dt < CURRENT_DATE

   GROUP BY
      r.client_id
     ,org.loc_sid_store_move_to
     ,r.item_sid
     ,org.loc_sid_wh
     ,wh.src_wh_id
     ,r.dwh_cal_dt
     ,cal.cy_week
     ,cry.curr_cd_from
     ,time_hour_id

;