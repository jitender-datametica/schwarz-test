CREATE OR REPLACE VIEW idq_production_dwh.ref_dimension (ref_dimension_id, dimension_technical_name, dimension_name,
dimension_name_de, dimension_name_en) AS SELECT id AS ref_dimension_id,
 dimension AS dimension_technical_name,
 name_de AS dimension_name,
 name_de AS dimension_name_de,
 name_en AS dimension_name_en
FROM idq_production_idq_results.ref_dimension;