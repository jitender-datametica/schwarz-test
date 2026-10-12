CREATE OR REPLACE VIEW idq_production_dwh.ref_matching_status_1 (ref_matching_status_id, matching_status_technical_name,
matching_status_name, matching_status_name_de, matching_status_name_en) AS SELECT id AS ref_matching_status_id,
 matching_status AS matching_status_technical_name,
 name_de AS matching_status_name,
 name_de AS matching_status_name_de,
 name_en AS matching_status_name_en
FROM idq_production_idq_results.ref_matching_status_1;