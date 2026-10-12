CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_in_l_pruefkatalog_code_1 (mandant_id, katalogart_id, codegruppe_id
, pruefcode_id, version_id) AS SELECT mandant_id,
 katalogart_id,
  CASE
  WHEN codegruppe_id = 'KLOAUTM'
  THEN SUBSTR(codegruppe_id, 1, 3)
  ELSE codegruppe_id
  END AS codegruppe_id,
 pruefcode_id,
 version_id
FROM kfl_production_dbp_view.v_in_l_pruefkatalog_code_1 AS V01_1
GROUP BY mandant_id,
 katalogart_id,
 V01_1.codegruppe_id,
 pruefcode_id,
 version_id;