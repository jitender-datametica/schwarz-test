CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_language_1 (
language_id BIGNUMERIC(38,0) NOT NULL,
language_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
language_desc STRING(35) COLLATE 'und:ci' NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);