CREATE OR REPLACE VIEW idq_production_dwh.ref_indicator_is_error_detected_1 (is_error_detected, `desc`, desc_de, desc_en)
AS SELECT id AS is_error_detected,
 desc_de AS `desc`,
 desc_de,
 desc_en
FROM idq_production_idq_results.ref_indicator_1;