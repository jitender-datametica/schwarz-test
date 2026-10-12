CREATE OR REPLACE VIEW idq_production_dwh.ref_field (ref_field_id, ref_source_system_type_id, source_table,
field_technical_name, field_name, field_name_de, field_name_en) AS SELECT id AS ref_field_id,
 source_system_type_id AS ref_source_system_type_id,
 source_table,
 technical_name AS field_technical_name,
 name_de AS field_name,
 name_de AS field_name_de,
 name_en AS field_name_en
FROM idq_production_idq_results.ref_field;