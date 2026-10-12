CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_mwst_per_2 (dat_von, mwst_id, mwst, dat_bis, mwst_bez,
mandant_id, system_id) AS SELECT dat_von,
 mwst_id,
 mwst,
 dat_bis,
 mwst_bez,
 mandant_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_mwst_per_2
WHERE dat_bis = DATE '9999-12-31'
 AND mandant_id = 1;