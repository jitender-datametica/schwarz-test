CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_str_day_writeoff (client_id, wh_id, loc_sid_wh, move_to_store_id,
dat_calendar, currency_iso_cd, writeoff_val, writeoff_val_bytd, writeoff_val_p1y, writeoff_val_p1y_bytd,
writeoff_val_p1y_wk, writeoff_val_p1y_wk_bytd, rev_val, rev_val_bytd, rev_val_p1y, rev_val_p1y_bytd, rev_val_p1y_wk,
rev_val_p1y_wk_bytd, writeoff_val_total, writeoff_val_total_bytd, writeoff_val_total_p1y, writeoff_val_total_p1y_bytd,
writeoff_val_total_p1y_wk, writeoff_val_total_p1y_wk_bytd) AS SELECT *
FROM ldl_p_lew_mart_lead.v_agg_str_day_writeoff;