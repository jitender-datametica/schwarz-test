CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_owg_per_1 (owg_id, arthiertyp_id, mandant_id, dat_von, dat_bis,
hwg_id, system_id) AS SELECT owg_id,
 arthiertyp_id,
 mandant_id,
 dat_von,
 dat_bis,
 hwg_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_owg_per_1
WHERE mandant_id = 1
 AND arthiertyp_id = 2
 AND dat_bis = DATE '9999-12-31';