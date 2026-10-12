create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_DIM_BENCHMARK_TYPE(
	BENCHMARK_TYPE_ID COMMENT 'Benchmark Type Identifier',
	BENCHMARK_TYPE_DESC COMMENT 'Description for Benchmark Type in German',
	BENCHMARK_TYPE_DESC_DE COMMENT 'Description for Benchmark type in German',
	BENCHMARK_TYPE_DESC_EN COMMENT 'Description for Benchmark type in English'
) as
SELECT 
1::NUMBER(38,0) AS benchmark_type_id
,'Standard'::VARCHAR(100) AS benchmark_type_desc
,'Standard'::VARCHAR(100) AS benchmark_type_desc_de
,'Standard'::VARCHAR(100) AS benchmark_type_desc_en
UNION ALL
SELECT 
2::NUMBER(38,0)  AS benchmark_type_id
,'Verkaufsleiter Ebene'::VARCHAR(100) AS benchmark_type_desc
,'Verkaufsleiter Ebene'::VARCHAR(100) AS benchmark_type_desc_de
,'Sales Manager Level'::VARCHAR(100) AS benchmark_type_desc_en
UNION ALL
SELECT 
3::NUMBER(38,0) AS benchmark_type_id
,'Vertriebsleiter Ebene'::VARCHAR(100) AS benchmark_type_desc
,'Vertriebsleiter Ebene'::VARCHAR(100) AS benchmark_type_desc_de
,'Account Manager Level'::VARCHAR(100) AS benchmark_type_desc_en
UNION ALL
SELECT 
4::NUMBER(38,0) AS benchmark_type_id
,'Vertriebsgesellschaft Ebene'::VARCHAR(100) AS benchmark_type_desc
,'Vertriebsgesellschaft Ebene'::VARCHAR(100) AS benchmark_type_desc_de
,'Sales Company Level'::VARCHAR(100) AS benchmark_type_desc_en
UNION ALL
SELECT 
5::NUMBER(38,0) AS benchmark_type_id
,'Vertriebsgesellschaft Ebene'::VARCHAR(100) AS benchmark_type_desc
,'Vertriebsgesellschaft Ebene'::VARCHAR(100) AS benchmark_type_desc_de
,'Sales Company Level'::VARCHAR(100) AS benchmark_type_desc_en
UNION ALL
SELECT 
5::NUMBER(38,0) AS benchmark_type_id
,'Region Ebene'::VARCHAR(100) AS benchmark_type_desc
,'Region Ebene'::VARCHAR(100) AS benchmark_type_desc_de
,'Region Level'::VARCHAR(100) AS benchmark_type_desc_en
UNION ALL
SELECT 
6::NUMBER(38,0) AS benchmark_type_id
,'Land Ebene'::VARCHAR(100) AS benchmark_type_desc
,'Land Ebene'::VARCHAR(100) AS benchmark_type_desc_de
,'Country Level'::VARCHAR(100) AS benchmark_type_desc_en;