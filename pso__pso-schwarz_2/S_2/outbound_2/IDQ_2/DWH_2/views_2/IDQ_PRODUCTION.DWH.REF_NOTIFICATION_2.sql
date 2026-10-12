CREATE OR REPLACE VIEW idq_production_dwh.ref_notification_2 (ref_notification_id, technical_name, name, name_de, name_en
, description, description_de, description_en) AS SELECT id AS ref_notification_id,
 technical_name,
 name_de AS name,
 name_de,
 name_en,
 description_de AS description,
 description_de,
 description_en
FROM idq_production_idq_results.ref_notification_2;