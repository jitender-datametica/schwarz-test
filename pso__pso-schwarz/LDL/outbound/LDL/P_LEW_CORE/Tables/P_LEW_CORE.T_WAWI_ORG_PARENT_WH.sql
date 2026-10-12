CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_org_parent_wh (
client_id BIGNUMERIC(38,0) NOT NULL,
parent_wh_loc_sid BIGNUMERIC(38,0) NOT NULL,
parent_wh_desc STRING(50) COLLATE 'und:ci' NOT NULL,
parent_wh_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);