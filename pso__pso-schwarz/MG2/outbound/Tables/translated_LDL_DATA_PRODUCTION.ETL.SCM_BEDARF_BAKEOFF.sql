CREATE OR REPLACE TABLE ldl_data_production_etl.scm_bedarf_bakeoff (
extraction_timestamp DATETIME,
excel_rownum INTEGER,
col_ian STRING(100),
col_prod_hier_v STRING(100),
col_pal_prod_hier_v STRING(100),
col_stueck_je_karton STRING(100),
col_stueck_je_hhpech STRING(100),
col_land STRING(100),
col_month STRING(100),
col_year STRING(100),
col_plan STRING(100),
col_bestellmenge STRING(100),
col_d_bm_vs_plan STRING(100),
col_d_bm_vs_plan_p STRING(100)
);