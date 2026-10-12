CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_EK_CTRY_PRICE_INFL_1
AS
   SELECT
     client_id,
   cy_week_partial_week_id,
   price_infl_val,
   price_infl_val_mtd,
   price_infl_val_bytd,
   price_infl_val_p1y,
   price_infl_val_p1y_mtd,
   price_infl_val_p1y_bytd

  FROM p_lew_mart_lead.t_agg_ek_ctry_price_infl_1
;