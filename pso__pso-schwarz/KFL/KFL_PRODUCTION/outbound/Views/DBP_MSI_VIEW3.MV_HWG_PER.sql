CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_hwg_per (mandant_id, hwg_id, abt_id, dat_von, dat_bis,
arthiertyp_id) AS SELECT mandant_id,
 hwg_id,
 abt_id,
 dat_von,
 dat_bis,
 arthiertyp_id
FROM kfl_production_dbp_view.v_hwg_per AS V01
WHERE arthiertyp_id = 2
 AND dat_bis = DATE '9999-12-31';