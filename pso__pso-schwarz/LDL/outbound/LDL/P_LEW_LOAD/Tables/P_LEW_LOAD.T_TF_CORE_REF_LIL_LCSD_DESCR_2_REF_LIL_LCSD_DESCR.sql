CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_core_ref_lil_lcsd_descr_2_ref_lil_lcsd_descr (
lcsd_id BIGNUMERIC(38) NOT NULL,
core_ref_lil_lcsd_descr_lang_cd STRING(250) NOT NULL,
lang_cd STRING(2) COLLATE 'und:ci' NOT NULL,
lcsd_descr STRING(100) COLLATE 'und:ci' NOT NULL,
lcsd_short_descr STRING(100) COLLATE 'und:ci',
lcsd_explain STRING(300) COLLATE 'und:ci',
extraction_dt DATE,
dwh_mapping_dt DATE NOT NULL,
tf_error_fg INTEGER,
record_id STRING(300) NOT NULL,
filename STRING(1000) NOT NULL
);