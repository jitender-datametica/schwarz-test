CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_owg_per_1 (owg_id, mandant_id, dat_von, dat_bis, arthiertyp_id,
hwg_id) AS SELECT owg_id,
 mandant_id,
 dat_von,
 dat_bis,
 arthiertyp_id,
 hwg_id
FROM kfl_production_dbp_view.v_owg_per_1 AS V01
WHERE arthiertyp_id = 2
 AND dat_bis = DATE '9999-12-31';