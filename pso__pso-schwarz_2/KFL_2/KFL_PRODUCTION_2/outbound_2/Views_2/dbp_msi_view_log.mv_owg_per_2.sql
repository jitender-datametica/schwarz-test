CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_owg_per_2 AS SELECT owg_id,
 arthiertyp_id,
 hwg_id
FROM kfl_production_dbp_view.v_owg_per_2 AS V01
WHERE arthiertyp_id = 2
 AND dat_bis = PARSE_DATE('%F', '9999-12-31')
GROUP BY owg_id,
 arthiertyp_id,
 hwg_id;