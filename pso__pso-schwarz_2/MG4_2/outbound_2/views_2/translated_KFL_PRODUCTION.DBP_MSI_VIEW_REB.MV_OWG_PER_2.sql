CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_reb.mv_owg_per_2 (owg_id, mandant_id, dat_von, dat_bis, arthiertyp_id,
hwg_id) AS SELECT owg_id,
 mandant_id,
 dat_von,
 dat_bis,
 arthiertyp_id,
 hwg_id
FROM kfl_production_dbp_view.v_owg_per_2 AS v01
WHERE mandant_id = 1
 AND CURRENT_DATE BETWEEN dat_von AND dat_bis;