CREATE OR REPLACE VIEW idq_production_dwh.ref_indicator_matart_flag_1 (matart_flag, `desc`, desc_de, desc_en) AS SELECT id
  AS matart_flag,
 desc_de AS `desc`,
 desc_de,
 desc_en
FROM idq_production_idq_results.ref_indicator_1;