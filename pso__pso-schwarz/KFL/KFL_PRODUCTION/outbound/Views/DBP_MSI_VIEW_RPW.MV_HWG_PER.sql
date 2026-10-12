CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_hwg_per (hwg_id, arthiertyp_id, mandant_id, dat_von, dat_bis,
abt_id, system_id) AS SELECT hwg_id,
 arthiertyp_id,
 mandant_id,
 dat_von,
 dat_bis,
 abt_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_hwg_per
WHERE mandant_id = 1
 AND arthiertyp_id = 2;