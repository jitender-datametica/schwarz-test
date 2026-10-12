CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_owg_per_2 AS SELECT owg_id,
 arthiertyp_id,
 mandant_id,
 dat_von,
 dat_bis,
 hwg_id
FROM kfl_production_dbp_view.v_owg_per_2 AS V01
WHERE arthiertyp_id = 2
 AND dat_bis = DATE '9999-12-31';