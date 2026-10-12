CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_translation_2 (
desc_id BIGNUMERIC(38,0) NOT NULL,
language_id BIGNUMERIC(38,0) NOT NULL,
translation STRING(100) COLLATE 'und:ci' NOT NULL,
table_name STRING(30) COLLATE 'und:ci' NOT NULL
);