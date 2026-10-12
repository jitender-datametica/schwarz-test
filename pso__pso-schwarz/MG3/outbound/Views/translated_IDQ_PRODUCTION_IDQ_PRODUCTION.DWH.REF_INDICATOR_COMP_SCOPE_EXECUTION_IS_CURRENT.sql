CREATE OR REPLACE VIEW idq_production_dwh.ref_indicator_comp_scope_execution_is_current (comp_scope_execution_is_current
, `desc`, desc_de, desc_en) AS SELECT id AS comp_scope_execution_is_current,
 desc_de AS `desc`,
 desc_de,
 desc_en
FROM idq_production_idq_results.ref_indicator;