CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_load_status_source_asis (
source_id BIGNUMERIC(38,0) NOT NULL,
source_desc STRING(30) COLLATE 'und:ci' NOT NULL,
language_id BIGNUMERIC(38,0) NOT NULL,
mod_tmsp DATETIME NOT NULL
);