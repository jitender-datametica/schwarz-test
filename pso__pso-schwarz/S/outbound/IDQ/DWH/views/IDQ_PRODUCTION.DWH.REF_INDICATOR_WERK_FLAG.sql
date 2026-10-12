CREATE OR REPLACE VIEW idq_production_dwh.ref_indicator_werk_flag (werk_flag, `desc`, desc_de, desc_en) AS SELECT id AS
 werk_flag,
 desc_de AS `desc`,
 desc_de,
 desc_en
FROM idq_production_idq_results.ref_indicator;