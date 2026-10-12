CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_reb.mv_hwg_zu_per_1 (hwg_id, mandant_id, dat_von, dat_bis,
arthiertyp_id) AS SELECT hwg_id,
 mandant_id,
 dat_von,
 dat_bis,
 arthiertyp_id
FROM kfl_production_dbp_view.v_hwg_per_1
WHERE mandant_id = 1
 AND CURRENT_DATE BETWEEN dat_von AND dat_bis;