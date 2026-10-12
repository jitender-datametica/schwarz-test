CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_mwst_2 AS SELECT mwst_id,
 mandant_id,
 mwst,
 mwst_bez
FROM kfl_production_dbp_view.v_mwst_per_2
WHERE dat_bis = DATE '9999-12-31';