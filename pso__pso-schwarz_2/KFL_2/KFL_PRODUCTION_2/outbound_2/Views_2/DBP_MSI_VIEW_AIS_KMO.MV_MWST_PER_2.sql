CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_mwst_per_2 (mwst_id, mandant_id, mwst, mwst_bez, dat_von,
dat_bis) AS SELECT mwst_id,
 mandant_id,
 mwst,
 mwst_bez,
 dat_von,
 dat_bis
FROM kfl_production_dbp_view.v_mwst_per_2
WHERE dat_bis = DATE '9999-12-31'
 AND mandant_id > 1;