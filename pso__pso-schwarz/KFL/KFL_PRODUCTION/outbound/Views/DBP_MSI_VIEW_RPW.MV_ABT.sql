CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_abt (abt_id, arthiertyp_id, mandant_id, system_id) AS SELECT
 abt_id,
 arthiertyp_id,
 mandant_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_abt
WHERE mandant_id = 1
 AND arthiertyp_id = 2
 AND abt_id NOT IN (0, - 1, - 2, - 3);