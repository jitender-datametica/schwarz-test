CREATE OR REPLACE VIEW FE_MSTR_GF_LEAD.V_DIM_BENCHMARK_TYPE(
benchmark_type_id COMMENT 'Benchmark Type Identifier'
,benchmark_type_desc COMMENT 'Description for Benchmark Type in German'
,benchmark_type_desc_de COMMENT 'Description for Benchmark type in German'
,benchmark_type_desc_en COMMENT 'Description for Benchmark type in English'
) AS
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