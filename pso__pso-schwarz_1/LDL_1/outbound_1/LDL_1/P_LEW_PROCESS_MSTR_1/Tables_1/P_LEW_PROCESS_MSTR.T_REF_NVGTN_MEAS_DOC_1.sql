CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_ref_nvgtn_meas_doc_1 (
dsbrd_id BIGNUMERIC(38,0) NOT NULL,
phy_doc_id BIGNUMERIC(38,0) NOT NULL,
meas_grp_id BIGNUMERIC(38,0) NOT NULL,
dsbrd_meas_grp_ord BIGNUMERIC(38,0) NOT NULL,
phy_doc_desc STRING(250) NOT NULL,
mstr_phy_doc_guid STRING(32) NOT NULL,
phy_doc_type_id BIGNUMERIC(38,0) NOT NULL,
url_mtrc STRING(8000) NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL,
dwh_inserted DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);