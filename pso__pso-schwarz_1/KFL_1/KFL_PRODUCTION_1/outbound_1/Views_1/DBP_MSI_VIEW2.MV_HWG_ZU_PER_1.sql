CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_hwg_zu_per_1 (hwg_id, mandant_id, dat_von, dat_bis, arthiertyp_id,
abt_id) AS SELECT hwg_id,
 mandant_id,
 dat_von,
 dat_bis,
 arthiertyp_id,
 abt_id
FROM kfl_production_dbp_view.v_hwg_per_1 AS V01
WHERE mandant_id = 1
 AND arthiertyp_id = 2
 AND dat_bis = DATE '9999-12-31';