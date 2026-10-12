CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_agg_obj_url_2 (
dsbrd_id BIGNUMERIC(38,0) NOT NULL,
phy_doc_id BIGNUMERIC(38,0) NOT NULL,
mstr_phy_doc_guid STRING(32) NOT NULL,
phy_doc_type_id BIGNUMERIC(38,0) NOT NULL,
url_mtrc STRING(2000) NOT NULL,
sub_nav_prmpt STRING(2000) NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL,
dwh_inserted DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);