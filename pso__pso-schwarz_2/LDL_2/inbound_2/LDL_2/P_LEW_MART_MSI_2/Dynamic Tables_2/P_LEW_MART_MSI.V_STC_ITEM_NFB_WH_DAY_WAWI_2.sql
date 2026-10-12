
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_STC_ITEM_NFB_WH_DAY_WAWI_2

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
SELECT
sinw.client_id,
cry.currency_iso_cd,
cal.cal_dt                                                                AS dat_calendar,
itmp.item_sid_map                                                         AS item_id,
CAST(sinw.retail_price     / cry.rate_currency_exchange AS DECIMAL(38,5)) AS price_retail,
CAST(sinw.retail_net_price / cry.rate_currency_exchange AS DECIMAL(38,5)) AS price_retail_net,
sinw.calc_stock_case_qty                                                  AS qty_case_nfb_continuous,
CASE WHEN sinw.active_from_dt = cal.cal_dt
            THEN sinw.delta_case_qty
            ELSE 0
   END                                                                       AS qty_case_nfb_diff,
wh.src_wh_id                                                              AS wh_id
FROM p_lew_core_ac.v_item_wh_stock_nfb_2 AS sinw
INNER JOIN p_lew_core_ac.v_cal_calendarday_2 AS cal
ON  cal.cal_dt BETWEEN sinw.active_from_dt AND sinw.active_to_dt
AND sinw.calc_stock_case_qty <> 0
AND sinw.deleted_fg = 0
INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS cry
ON  sinw.client_id = cry.client_id
AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end
INNER JOIN p_lew_bil_ac.v_warehouse_2 AS wh
ON  sinw.client_id   = wh.client_id
AND sinw.loc_sid     = wh.loc_sid_wh
AND wh.dwh_actual_fg = 1
INNER JOIN p_lew_core_ac.v_item_map_key_2 AS itmp
ON  itmp.client_id = sinw.client_id
AND itmp.item_sid  = sinw.item_sid
WHERE wh.bges_active_fg = 1
;
