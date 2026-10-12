CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_msi_ejr_ref_translinestype_2 (
translinestype_id STRING(3) COLLATE 'und:ci' NOT NULL,
transline_ref STRING(200) COLLATE 'und:ci',
transline_desc STRING(200) COLLATE 'und:ci',
transline_sdesc STRING(200) COLLATE 'und:ci',
transline_xml_ref STRING(200) COLLATE 'und:ci',
transline_comment STRING(200) COLLATE 'und:ci',
language_id BIGNUMERIC(38,0) NOT NULL
);