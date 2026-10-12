CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_nfmd.mv_mwst_per_2 AS SELECT mandant_id,
 mwst_id,
 mwst,
 dat_von,
 dat_bis
FROM kfl_production_dbp_view.v_mwst_per_2
WHERE dat_bis = DATE '9999-12-31';