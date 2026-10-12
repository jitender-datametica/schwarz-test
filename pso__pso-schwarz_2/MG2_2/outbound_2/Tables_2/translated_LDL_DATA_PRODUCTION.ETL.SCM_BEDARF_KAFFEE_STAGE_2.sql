CREATE OR REPLACE TABLE ldl_data_production_etl.scm_bedarf_kaffee_stage_2 (
extraction_timestamp DATETIME,
excel_rownum INTEGER,
col_ian INTEGER,
col_mat_nr INTEGER,
col_pal_artikel STRING(100),
col_listung STRING(100),
col_stueck_je_karton INTEGER,
col_stueck_je_palette INTEGER,
col_prod_iv STRING(100),
col_land STRING(100),
col_month INTEGER,
col_year INTEGER,
col_plan BIGNUMERIC(29,15),
col_bestellmenge INTEGER,
col_d_bm_vs_plan_abs BIGNUMERIC(29,15),
col_d_bm_vs_plan_p BIGNUMERIC(29,15)
);