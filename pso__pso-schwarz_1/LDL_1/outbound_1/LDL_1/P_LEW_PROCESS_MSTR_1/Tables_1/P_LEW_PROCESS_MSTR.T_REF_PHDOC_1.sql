CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_ref_phdoc_1 (
phy_doc_id BIGNUMERIC(38,0) NOT NULL,
phy_doc_desc STRING(250) COLLATE 'und:ci' NOT NULL,
mstr_phy_doc_guid STRING(32) COLLATE 'und:ci' NOT NULL,
phy_doc_type_id BIGNUMERIC(38,0) NOT NULL,
deleted_fg BIGNUMERIC(38,0) NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);