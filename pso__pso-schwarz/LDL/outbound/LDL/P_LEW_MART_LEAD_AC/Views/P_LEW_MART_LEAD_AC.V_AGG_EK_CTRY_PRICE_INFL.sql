CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_ek_ctry_price_infl AS SELECT client_id,
 cy_week_partial_week_id,
 price_infl_val,
 price_infl_val_mtd,
 price_infl_val_bytd,
 price_infl_val_p1y,
 price_infl_val_p1y_mtd,
 price_infl_val_p1y_bytd
FROM ldl_p_lew_mart_lead.t_agg_ek_ctry_price_infl;