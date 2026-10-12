CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_debitor_per_1 AS SELECT mandant_id,
 debitor_id,
 debitor_status_id,
 dat_von,
 dat_bis,
 COALESCE(konzessionaer_id, '0') AS konzessionaer_id,
 ivs_fg
FROM kfl_production_dbp_view.v_ivs_debitor_per_1 AS DP
WHERE dat_bis = DATE '9999-12-31'
 AND ivs_fg = 1;