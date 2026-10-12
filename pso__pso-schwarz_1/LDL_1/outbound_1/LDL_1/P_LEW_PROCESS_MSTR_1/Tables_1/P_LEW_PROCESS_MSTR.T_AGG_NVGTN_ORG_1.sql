CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_agg_nvgtn_org_1 (
int_id BIGNUMERIC(38,0) NOT NULL,
client_ctry_id BIGNUMERIC(38,0) NOT NULL,
client_id BIGNUMERIC(38,0) NOT NULL,
curr_client_id BIGNUMERIC(38,0) NOT NULL,
aspect_id BIGNUMERIC(38,0) NOT NULL,
wh_id BIGNUMERIC(38,0) NOT NULL,
move_to_store_id BIGNUMERIC(38,0) NOT NULL,
org_lvl_id BIGNUMERIC(38,0) NOT NULL,
org_ele_link STRING(2000) NOT NULL,
org_ele_desc STRING(255) NOT NULL,
org_brdcrum STRING(255) NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL,
dwh_inserted DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);