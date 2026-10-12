CREATE OR REPLACE VIEW idq_production_dwh.ref_indicator_reporting_rule_by_country_summary_is_current_2 (reporting_rule_by_country_summary_is_current
, `desc`, desc_de, desc_en) AS SELECT id AS reporting_rule_by_country_summary_is_current,
 desc_de AS `desc`,
 desc_de,
 desc_en
FROM idq_production_idq_results.ref_indicator_2;