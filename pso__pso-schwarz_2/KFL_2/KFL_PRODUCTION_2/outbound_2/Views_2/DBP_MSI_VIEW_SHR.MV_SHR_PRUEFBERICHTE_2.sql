CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_shr_pruefberichte_2 (mandant_id, kjmo_pruef) AS SELECT
 mandant_id,
 MAX(kjmo) AS kjmo_pruef
FROM kfl_production_dbp_view.v_mitarbeiterbew_2 AS V01
GROUP BY mandant_id;