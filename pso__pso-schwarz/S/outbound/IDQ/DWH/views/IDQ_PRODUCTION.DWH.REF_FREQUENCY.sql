CREATE OR REPLACE VIEW idq_production_dwh.ref_frequency (ref_frequency_id, frequency_name, frequency_name_de,
frequency_name_en) AS SELECT id AS ref_frequency_id,
 name_de AS frequency_name,
 name_de AS frequency_name_de,
 name_en AS frequency_name_en
FROM idq_production_idq_results.ref_frequency;