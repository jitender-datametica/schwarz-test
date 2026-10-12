CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_mwst_per_1 (dat_von, mwst_id, mwst, dat_bis) AS SELECT dat_von,
 mwst_id,
 mwst,
 dat_bis
FROM kfl_production_dbp_view.v_mwst_per_1
WHERE mandant_id = 1;