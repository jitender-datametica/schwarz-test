CREATE OR REPLACE VIEW idq_production_dwh.ref_indicator_rule_result_1 (rule_result, `desc`, desc_de, desc_en, outcome) AS
SELECT id AS rule_result,
 desc_de AS `desc`,
 desc_de,
 desc_en,
  CASE
  WHEN id = 1
  THEN '+'
  WHEN id = 0
  THEN '-'
  ELSE NULL
  END AS outcome
FROM idq_production_idq_results.ref_indicator_1;