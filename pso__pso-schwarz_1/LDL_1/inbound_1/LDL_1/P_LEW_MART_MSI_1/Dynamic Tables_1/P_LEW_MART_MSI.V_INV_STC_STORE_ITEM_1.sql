
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_INV_STC_STORE_ITEM_1

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
SELECT
stc.client_id                                                            AS client_id,
stc.item_sid                                                             AS item_id,
stc.dwh_cal_dt                                                           AS dat_formdate,
stc.loc_sid                                                              AS store_id,
stc.calc_stock_qty                                                       AS qty_inv_stc_calc,
stc.inv_stock_qty                                                        AS qty_inv_stc_cnt,
stc.inv_calc_stock_diff                                                  AS diff_inv_stc_calc_cnt,
stc.inv_status_id                                                        AS status_inv_stc,
CAST(stc.retail_price     / cry.rate_currency_exchange AS DECIMAL(38,5)) AS price_retail,
CAST(stc.retail_net_price / cry.rate_currency_exchange AS DECIMAL(38,5)) AS price_retail_net,
cry.currency_iso_cd                                                      AS currency_iso_cd
FROM p_lew_core_ac.v_item_store_inventory_stock_1 AS stc
INNER JOIN p_lew_core_ac.v_wawi_inv_store_1 AS inv
ON  stc.client_id      = inv.client_id
AND stc.loc_sid        = inv.st_loc_sid
AND stc.dwh_cal_dt     = inv.dat_formdate
AND inv.inv_fg         = 71
AND inv.status_inv_sic = 64
INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS cry
ON  stc.client_id      = cry.client_id
AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end
;
