CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_STOCK_STORE_ITEM_MONTHS_26_1
AS
   SELECT
     ssi.client_id           AS client_id,
   ssi.loc_sid             AS loc_sid,
   ssi.src_wh_id           AS src_wh_id,
   ssi.loc_sid_wh          AS loc_sid_wh,
   ssi.item_sid            AS item_sid,
   ssi.stock_calc_qty      AS stock_calc_qty,
   ssi.stock_inv_qty       AS stock_inv_qty,
   ssi.stock_real_qty      AS stock_real_qty,
   ssi.stock_inv_diff_calc AS stock_inv_diff_calc,
   ssi.cond_val_eff_calc   AS cond_val_eff_calc,
   ssi.net_val_eff_calc    AS net_val_eff_calc,
   ssi.curr_cd             AS curr_cd,
   ssi.curr_sid            AS curr_sid,
   ssi.dwh_valid_from      AS dwh_valid_from,
   ssi.dwh_valid_to        AS dwh_valid_to
  FROM p_lew_mart_lead.v_stock_store_item_months_26_1 AS ssi
;