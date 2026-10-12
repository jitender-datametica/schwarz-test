CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_lil_translation_2 (
context STRING(100) COLLATE 'und:ci' NOT NULL,
trans_id BIGNUMERIC(38,0) NOT NULL,
src_trans_cd STRING(100) COLLATE 'und:ci' NOT NULL,
lang_cd STRING COLLATE 'und:ci' NOT NULL,
orig_text STRING(100) COLLATE 'und:ci' NOT NULL,
trans_text STRING(100) COLLATE 'und:ci' NOT NULL,
active_fg BIGNUMERIC(38,0) NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (trans_id) NOT ENFORCED
);