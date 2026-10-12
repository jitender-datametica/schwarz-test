CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_LEAD.V_STOCK_WH_ITEM_MONTHS_26_2

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_LEAD

AS
   SELECT
      sli.client_id                                     AS client_id,
   cry.curr_cd_from                                  AS curr_cd,
   wh.src_wh_id                                      AS src_wh_id,
   sli.loc_sid                                       AS loc_sid_wh,
   sli.item_sid                                      AS item_sid,
    sli.price     / cry.exchange_rate::DECIMAL(18,4) AS cond_val_eff_calc,
    sli.price_net / cry.exchange_rate::DECIMAL(19,5) AS net_val_eff_calc,
   sli.calc_qty                                      AS stock_calc_qty,
   cry.curr_sid_from                                 AS curr_sid,
   sli.dwh_valid_from                                AS dwh_valid_from,
   sli.dwh_valid_to                                  AS dwh_valid_to
  FROM p_lew_core_ac.v_item_location_stock_hist_2 AS sli
   INNER JOIN p_lew_bil_ac.v_warehouse_2 AS wh
   ON  sli.client_id     = wh.client_id
   AND sli.loc_sid       = wh.loc_sid_wh
   AND wh.dwh_actual_fg  = 1
   AND wh.bges_active_fg = 1
   INNER JOIN p_lew_core_ac.v_client_2 AS land_curr
   ON  sli.client_id = land_curr.client_id
   INNER JOIN p_lew_bil_ac.v_exchange_rate_report_asis_2 AS cry
   ON  sli.client_id = cry.client_id
   AND  land_curr.curr_sid=cry.curr_sid_to
   WHERE sli.dwh_valid_from <=DATE'9999-12-30'
     AND add_months(CURRENT_DATE,-26)- EXTRACT(DAY FROM add_months(CURRENT_DATE,-26)) +1 <= sli.dwh_valid_to
;