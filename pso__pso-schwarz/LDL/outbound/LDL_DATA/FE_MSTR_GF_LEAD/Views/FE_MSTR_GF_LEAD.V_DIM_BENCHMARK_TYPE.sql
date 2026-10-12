CREATE OR REPLACE VIEW ldl_data_fe_mstr_gf_lead.v_dim_benchmark_type (benchmark_type_id
OPTIONS(description='Benchmark Type Identifier'), benchmark_type_desc
OPTIONS(description='Description for Benchmark Type in German'), benchmark_type_desc_de
OPTIONS(description='Description for Benchmark type in German'), benchmark_type_desc_en
OPTIONS(description='Description for Benchmark type in English')) AS SELECT 1 AS benchmark_type_id,
 'Standard' AS benchmark_type_desc,
 'Standard' AS benchmark_type_desc_de,
 'Standard' AS benchmark_type_desc_en
UNION ALL
SELECT 2 AS benchmark_type_id,
 'Verkaufsleiter Ebene' AS benchmark_type_desc,
 'Verkaufsleiter Ebene' AS benchmark_type_desc_de,
 'Sales Manager Level' AS benchmark_type_desc_en
UNION ALL
SELECT 3 AS benchmark_type_id,
 'Vertriebsleiter Ebene' AS benchmark_type_desc,
 'Vertriebsleiter Ebene' AS benchmark_type_desc_de,
 'Account Manager Level' AS benchmark_type_desc_en
UNION ALL
SELECT 4 AS benchmark_type_id,
 'Vertriebsgesellschaft Ebene' AS benchmark_type_desc,
 'Vertriebsgesellschaft Ebene' AS benchmark_type_desc_de,
 'Sales Company Level' AS benchmark_type_desc_en
UNION ALL
SELECT 5 AS benchmark_type_id,
 'Vertriebsgesellschaft Ebene' AS benchmark_type_desc,
 'Vertriebsgesellschaft Ebene' AS benchmark_type_desc_de,
 'Sales Company Level' AS benchmark_type_desc_en
UNION ALL
SELECT 5 AS benchmark_type_id,
 'Region Ebene' AS benchmark_type_desc,
 'Region Ebene' AS benchmark_type_desc_de,
 'Region Level' AS benchmark_type_desc_en
UNION ALL
SELECT 6 AS benchmark_type_id,
 'Land Ebene' AS benchmark_type_desc,
 'Land Ebene' AS benchmark_type_desc_de,
 'Country Level' AS benchmark_type_desc_en;