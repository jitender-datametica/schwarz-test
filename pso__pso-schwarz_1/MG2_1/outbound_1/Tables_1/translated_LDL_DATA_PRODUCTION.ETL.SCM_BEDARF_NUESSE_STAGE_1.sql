CREATE OR REPLACE TABLE ldl_data_production_etl.scm_bedarf_nuesse_stage_1 (
extraction_timestamp DATETIME,
excel_rownum BIGNUMERIC(38,0),
col_ian BIGNUMERIC(38,0),
col_mat_nr BIGNUMERIC(38,0),
col_pal_artikel STRING(100),
col_stueck_je_karton BIGNUMERIC(38,0),
col_stueck_je_palette BIGNUMERIC(38,0),
col_gebinde BIGNUMERIC(38,0),
col_land STRING(100),
col_month INTEGER,
col_year INTEGER,
col_plan BIGNUMERIC(38,15),
col_bestellmenge BIGNUMERIC(38,0),
col_d_bm_vs_plan BIGNUMERIC(38,15),
col_d_bm_vs_plan_p BIGNUMERIC(38,15)
);