CREATE OR REPLACE TABLE ldl_data_production_etl.scm_bedarf_bakeoff_stage (
extraction_timestamp DATETIME,
excel_rownum INTEGER,
col_ian INTEGER,
col_prod_hier_v STRING(100),
col_pal_prod_hier_v STRING(100),
col_stueck_je_karton INTEGER,
col_stueck_je_hhpech INTEGER,
col_land STRING(100),
col_month INTEGER,
col_year INTEGER,
col_plan BIGNUMERIC(29,15),
col_bestellmenge INTEGER,
col_d_bm_vs_plan BIGNUMERIC(29,15),
col_d_bm_vs_plan_p BIGNUMERIC(29,15)
);