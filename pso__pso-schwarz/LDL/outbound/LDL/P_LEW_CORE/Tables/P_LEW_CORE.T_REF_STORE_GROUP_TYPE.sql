CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_store_group_type (
store_grp_type_cd STRING COLLATE 'und:ci' NOT NULL OPTIONS(description='Store Group Type Code'),
store_grp_type_descr STRING(100) COLLATE 'und:ci' OPTIONS(description='Store Group Type Description'),
dwh_load_id INTEGER NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);