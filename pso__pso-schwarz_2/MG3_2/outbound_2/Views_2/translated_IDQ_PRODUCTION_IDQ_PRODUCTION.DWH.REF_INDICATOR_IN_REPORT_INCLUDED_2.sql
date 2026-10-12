CREATE OR REPLACE VIEW idq_production_dwh.ref_indicator_in_report_included_2 (in_report_included, `desc`, desc_de, desc_en
) AS SELECT id AS in_report_included,
 desc_de AS `desc`,
 desc_de,
 desc_en
FROM idq_production_idq_results.ref_indicator_2;