CREATE OR REPLACE VIEW idq_production_dwh.ref_indicator_comp_is_error_detected_1 (is_error_detected, description,
description_de, description_en) AS SELECT id AS is_error_detected,
 desc_de AS description,
 desc_de AS description_de,
 desc_en AS description_en
FROM idq_production_idq_results.ref_indicator_1;