CREATE OR REPLACE TABLE ldl_data_production_eval.tmp_ejr_mis_to_gf_20250228112206_2 (
country_cd STRING(2) NOT NULL,
bus_dt DATE NOT NULL,
orig_store_nr INTEGER NOT NULL,
table_name STRING(100) NOT NULL,
in_mis_fg BOOL NOT NULL,
in_gf_fg BOOL NOT NULL,
mis_cnt INTEGER,
gf_cnt INTEGER
);