CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_lil_translation_2_lil_translation (
context STRING(100) COLLATE 'und:ci' NOT NULL,
lil_translation_context STRING(100) COLLATE 'und:ci' NOT NULL,
lil_translation_trans_id BIGNUMERIC(38,0) NOT NULL,
lil_translation_lang_cd STRING(250) NOT NULL,
trans_id BIGNUMERIC(38) NOT NULL,
src_trans_cd STRING(100) NOT NULL,
lang_cd STRING(2) COLLATE 'und:ci' NOT NULL,
orig_text STRING(100) NOT NULL,
trans_text STRING(100) NOT NULL,
active_fg BIGNUMERIC(38) NOT NULL,
extraction_dt DATE,
dwh_mapping_dt DATE NOT NULL,
tf_error_fg INTEGER,
record_id STRING(300) NOT NULL,
filename STRING(1000) NOT NULL
);