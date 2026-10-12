CREATE OR REPLACE VIEW FE_MSTR_GF_LEAD.V_DIM_BENCHMARK_TYPE_1(
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
,'Sales_1 Manager Level'::VARCHAR(100) AS benchmark_type_desc_en
UNION ALL
SELECT 
3::NUMBER(38,0) AS benchmark_type_id
,'Vertriebsleiter Ebene'::VARCHAR(100) AS benchmark_type_desc
,'Vertriebsleiter Ebene'::VARCHAR(100) AS benchmark_type_desc_de
,'Account_1 Manager Level'::VARCHAR(100) AS benchmark_type_desc_en
UNION ALL
SELECT 
4::NUMBER(38,0) AS benchmark_type_id
,'Vertriebsgesellschaft Ebene'::VARCHAR(100) AS benchmark_type_desc
,'Vertriebsgesellschaft Ebene'::VARCHAR(100) AS benchmark_type_desc_de
,'Sales_1 Company Level'::VARCHAR(100) AS benchmark_type_desc_en
UNION ALL
SELECT 
5::NUMBER(38,0) AS benchmark_type_id
,'Vertriebsgesellschaft Ebene'::VARCHAR(100) AS benchmark_type_desc
,'Vertriebsgesellschaft Ebene'::VARCHAR(100) AS benchmark_type_desc_de
,'Sales_1 Company Level'::VARCHAR(100) AS benchmark_type_desc_en
UNION ALL
SELECT 
5::NUMBER(38,0) AS benchmark_type_id
,'Region_1 Ebene'::VARCHAR(100) AS benchmark_type_desc
,'Region_1 Ebene'::VARCHAR(100) AS benchmark_type_desc_de
,'Region_1 Level'::VARCHAR(100) AS benchmark_type_desc_en
UNION ALL
SELECT 
6::NUMBER(38,0) AS benchmark_type_id
,'Land_1 Ebene'::VARCHAR(100) AS benchmark_type_desc
,'Land_1 Ebene'::VARCHAR(100) AS benchmark_type_desc_de
,'Country_1 Level'::VARCHAR(100) AS benchmark_type_desc_en;