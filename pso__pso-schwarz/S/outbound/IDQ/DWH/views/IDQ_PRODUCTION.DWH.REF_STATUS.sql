CREATE OR REPLACE VIEW idq_production_dwh.ref_status (ref_status_id, status_technical_name, status_name, status_name_de
, status_name_en) AS SELECT id AS ref_status_id,
 status AS status_technical_name,
 name_de AS status_name,
 name_de AS status_name_de,
 name_en AS status_name_en
FROM idq_production_idq_results.ref_status
WHERE id IN (4, 5, 6);