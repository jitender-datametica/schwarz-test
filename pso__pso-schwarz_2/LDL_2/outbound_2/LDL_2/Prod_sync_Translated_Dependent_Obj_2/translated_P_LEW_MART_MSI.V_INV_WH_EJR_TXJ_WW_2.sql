CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_inv_wh_ejr_txj_ww_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT SALES.client_id,
 WH.src_wh_id AS wh_id,
 COALESCE(wawi_inv.inv_id, 1) AS inv_id,
 COALESCE(wawi_inv.inv_start_date, SALES.dat_formdate) AS inv_start_date,
 COALESCE(wawi_inv.inv_end_date, SALES.dat_formdate) AS inv_end_date,
 ERKH.curr_cd_from AS currency_iso_cd,
  SALES.val_retail / ERKH.exchange_rate AS val_retail,
  SALES.val_retail_net / ERKH.exchange_rate AS val_retail_net
FROM ldl_p_lew_bil_ac.v_agg_sales_store_day_2 AS SALES_2
 INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_lastknown_2 AS S2WH ON SALES.client_id = S2WH.client_id AND SALES.loc_sid_store
    = S2WH.loc_sid_store
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS WH ON S2WH.client_id = WH.client_id AND S2WH.loc_sid_wh = WH.loc_sid_wh AND
     WH.dwh_actual_fg = 1 AND WH.active_fg = 1 AND WH.bges_active_fg = 1
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist_2 AS ERKH ON SALES.client_id = ERKH.client_id AND CURRENT_DATE
    BETWEEN ERKH.active_from_dt AND ERKH.active_to_dt AND CURRENT_DATE BETWEEN ERKH.dwh_valid_from AND ERKH.dwh_valid_to
   
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_2 AS ERT ON ERKH.client_id = ERT.client_id AND ERKH.x_rate_type_sid =
    ERT.x_rate_type_sid AND ERT.src_kurst = '@BEWE'
 LEFT JOIN (SELECT client_id,
   wh_loc_sid,
   inv_id,
   DATE_ADD(MAX(dat_formdate) OVER (PARTITION BY client_id, wh_loc_sid ORDER BY dat_formdate NULLS LAST ROWS BETWEEN 1
     PRECEDING AND 1 PRECEDING), INTERVAL 1 DAY) AS inv_start_date,
   dat_formdate AS inv_end_date
  FROM (SELECT client_id,
     wh_loc_sid,
     inv_id,
     dat_formdate
    FROM ldl_p_lew_core_ac.v_wawi_inv_item_wh_2
    WHERE inv_type = 'F'
    GROUP BY client_id,
     wh_loc_sid,
     dat_formdate,
     inv_id) AS t1_2
  QUALIFY (client_id, wh_loc_sid, DATE_ADD((MAX(dat_formdate) OVER (PARTITION BY client_id, wh_loc_sid ORDER BY
          dat_formdate NULLS LAST ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING)), INTERVAL 1 DAY), dat_formdate) NOT IN (SELECT
       (client_id, wh_loc_sid, inv_start_date, inv_end_date)
     FROM (SELECT client_id,
        wh_loc_sid,
        DATE_ADD(MAX(dat_formdate) OVER (PARTITION BY client_id, wh_loc_sid ORDER BY dat_formdate NULLS LAST
          ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING), INTERVAL 1 DAY) AS inv_start_date,
        dat_formdate AS inv_end_date
       FROM ldl_p_lew_core_ac.v_wawi_inv_item_wh_2
       WHERE client_id = 1
        AND inv_type = 'F'
       QUALIFY DATE_ADD((MAX(dat_formdate) OVER (PARTITION BY client_id, wh_loc_sid ORDER BY dat_formdate NULLS LAST
              ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING)), INTERVAL 1 DAY) >= DATE '2015-01-01' AND DATE_ADD((MAX(dat_formdate
              ) OVER (PARTITION BY client_id, wh_loc_sid ORDER BY dat_formdate NULLS LAST ROWS BETWEEN 1 PRECEDING AND 1
              PRECEDING)), INTERVAL 1 DAY) < DATE '2016-01-01' AND (dat_formdate >= DATE '2020-01-01' AND dat_formdate <
            DATE '2021-01-01')) AS t5
     GROUP BY client_id,
      wh_loc_sid,
      inv_start_date,
      inv_end_date)) AS wawi_inv ON SALES.client_id = wawi_inv.client_id AND WH.loc_sid_wh = wawi_inv.wh_loc_sid AND
   SALES.dat_formdate BETWEEN wawi_inv.inv_start_date AND wawi_inv.inv_end_date
WHERE WH.src_werks IS NULL AND wawi_inv.client_id IS NOT NULL
 OR WH.src_werks IS NOT NULL;