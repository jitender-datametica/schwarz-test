CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_STOCK_WH_ITEM_MONTHS_26_1
AS
   SELECT
      siw.client_id         AS client_id,
   siw.curr_cd           AS curr_cd,
   siw.src_wh_id         AS src_wh_id,
   siw.loc_sid_wh        AS loc_sid_wh,
   siw.item_sid          AS item_sid,
   siw.cond_val_eff_calc AS cond_val_eff_calc,
   siw.net_val_eff_calc  AS net_val_eff_calc,
   siw.stock_calc_qty    AS stock_calc_qty,
   siw.curr_sid          AS curr_sid,
   siw.dwh_valid_from    AS dwh_valid_from,
   siw.dwh_valid_to      AS dwh_valid_to

  FROM p_lew_mart_lead.v_stock_wh_item_months_26_1 AS siw
;