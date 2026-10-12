CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_org_wh_buying_region_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
aspect_id BIGNUMERIC(38,0) NOT NULL,
wh_loc_sid BIGNUMERIC(38,0) NOT NULL,
buying_region STRING(50) COLLATE 'und:ci',
region_sequence BIGNUMERIC(38,0),
language_id BIGNUMERIC(38,0) NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);