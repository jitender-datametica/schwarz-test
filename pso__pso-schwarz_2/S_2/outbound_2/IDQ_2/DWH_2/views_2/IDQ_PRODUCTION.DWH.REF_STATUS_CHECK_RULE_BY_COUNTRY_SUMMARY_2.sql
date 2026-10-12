CREATE OR REPLACE VIEW idq_production_dwh.ref_status_check_rule_by_country_summary_2 (ref_status_id, status_technical_name
, status_name, status_name_de, status_name_en) AS SELECT id AS ref_status_id,
 status_2 AS status_technical_name,
 name_de AS status_name,
 name_de AS status_name_de,
 name_en AS status_name_en
FROM idq_production_idq_results.ref_status_2
WHERE id IN (1, 2, 3);