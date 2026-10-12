CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_abt_1 AS SELECT mandant_id,
 abt_id,
 arthiertyp_id
FROM kfl_production_dbp_view.v_abt_1 AS V01
WHERE arthiertyp_id = 2
 AND mandant_id IN (1, 2)
 AND abt_id BETWEEN - 3 AND 8;