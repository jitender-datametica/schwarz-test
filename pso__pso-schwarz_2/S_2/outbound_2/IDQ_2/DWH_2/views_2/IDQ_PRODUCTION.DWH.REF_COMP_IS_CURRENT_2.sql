CREATE OR REPLACE VIEW idq_production_dwh.ref_comp_is_current_2 (ref_comp_is_current_id, description, description_de,
description_en) AS SELECT id AS ref_comp_is_current_id,
 desc_de AS description,
 desc_de AS description_de,
 desc_en AS description_en
FROM idq_production_idq_results.ref_indicator_2;