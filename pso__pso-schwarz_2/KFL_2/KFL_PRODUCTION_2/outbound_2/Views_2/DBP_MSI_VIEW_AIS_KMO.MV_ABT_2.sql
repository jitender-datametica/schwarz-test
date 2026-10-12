CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_abt_2 (mandant_id, abt_id, arthiertyp_id) AS SELECT
 mandant_id,
 abt_id,
 arthiertyp_id
FROM kfl_production_dbp_view.v_abt_2
WHERE arthiertyp_id = 2
 AND mandant_id <> 1;