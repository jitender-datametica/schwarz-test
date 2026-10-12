CREATE OR REPLACE VIEW idq_production_dwh.ref_indicator_eknr_flag (ek_nr_flag, `desc`, desc_de, desc_en) AS SELECT id AS
 ek_nr_flag,
 desc_de AS `desc`,
 desc_de,
 desc_en
FROM idq_production_idq_results.ref_indicator;