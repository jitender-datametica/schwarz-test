CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_packagetype (
client_id BIGNUMERIC(38,0) NOT NULL,
packagetype_desc STRING(35) COLLATE 'und:ci' NOT NULL,
packagetype_desc_int_short STRING(35) COLLATE 'und:ci' NOT NULL,
language_id BIGNUMERIC(38,0) NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);