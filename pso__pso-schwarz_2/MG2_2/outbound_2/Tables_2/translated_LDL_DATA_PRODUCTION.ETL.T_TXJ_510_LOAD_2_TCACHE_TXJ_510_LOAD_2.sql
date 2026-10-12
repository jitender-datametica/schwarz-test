CREATE OR REPLACE TABLE ldl_data_production_etl.t_txj_510_load_2_tcache_txj_510_load_2 (
load_id INTEGER NOT NULL,
wh_id INTEGER NOT NULL,
extraction_date DATE NOT NULL,
record_cd STRING(12) COLLATE 'und:ci' NOT NULL,
period_cd STRING(1) COLLATE 'und:ci',
closure_cd STRING(1) COLLATE 'und:ci',
orig_store_nr INTEGER NOT NULL,
bic_zmlila STRING(20) COLLATE 'und:ci',
vat_group_a_turnover_gross_val NUMERIC(18,5),
vat_group_a_vat_val NUMERIC(18,5),
vat_group_b_turnover_gross_val NUMERIC(18,5),
vat_group_b_vat_val NUMERIC(18,5),
vat_group_c_turnover_gross_val NUMERIC(18,5),
vat_group_c_vat_val NUMERIC(18,5),
vat_group_d_turnover_gross_val NUMERIC(18,5),
vat_group_d_vat_val NUMERIC(18,5),
vat_group_e_turnover_gross_val NUMERIC(18,5),
vat_group_e_vat_val NUMERIC(18,5),
vat_group_f_turnover_gross_val NUMERIC(18,5),
vat_group_f_vat_val NUMERIC(18,5),
vat_group_g_turnover_gross_val NUMERIC(18,5),
vat_group_g_vat_val NUMERIC(18,5),
vat_group_h_turnover_gross_val NUMERIC(18,5),
vat_group_h_vat_val NUMERIC(18,5),
vat_group_i_turnover_gross_val NUMERIC(18,5),
vat_group_i_vat_val NUMERIC(18,5),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.')
);