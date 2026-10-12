CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_country_act_2 (
int_id BIGNUMERIC(38,0) NOT NULL,
country_id BIGNUMERIC(38,0) NOT NULL,
country_iso_cd STRING(3) COLLATE 'und:ci',
cluster_id BIGNUMERIC(38,0),
sorting_order BIGNUMERIC(38,0) NOT NULL,
country_desc STRING(35) COLLATE 'und:ci' NOT NULL,
language_id BIGNUMERIC(38,0) NOT NULL,
dashboard_relevant_fg BIGNUMERIC(38,0) NOT NULL
);