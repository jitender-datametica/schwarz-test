CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_hgp_2 (hgp_id, hgp_name, mandant_id, zek_id,
einkaufsorganisation_id) AS SELECT DISTINCT gp_id AS hgp_id,
 gp_name AS hgp_name,
 mandant_id,
 zek_id,
 einkaufsorganisation_id
FROM kfl_production_dbp_view.v_gp_2 AS V01
WHERE gp_id IN (SELECT CASE
     WHEN hgp_id = - 1 OR hgp_id IS NULL
     THEN gp_id
     ELSE hgp_id
     END
   FROM kfl_production_dbp_view.v_gp_2 AS V02);