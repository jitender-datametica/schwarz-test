CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_reb.mv_abt_1 (mandant_id, abt_id, arthiertyp_id) AS SELECT mandant_id,
 abt_id,
 arthiertyp_id
FROM kfl_production_dbp_view.v_abt_1
WHERE arthiertyp_id = 2
 AND mandant_id = 1
 AND abt_id BETWEEN - 3 AND 8;