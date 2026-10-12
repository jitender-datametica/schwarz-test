CREATE TABLE p_lew_core.t_ref_store_group_type_2 (
store_grp_type_cd CHAR(5) COLLATE 'en-ci' NOT NULL COMMENT 'Store Group Type Code',
store_grp_type_descr VARCHAR(100) COLLATE 'en-ci' COMMENT 'Store Group Type Description',
dwh_load_id INTEGER NOT NULL,
DWH_CREATED TIMESTAMP_NTZ(6) NOT NULL,
DWH_UPDATED TIMESTAMP_NTZ(6) NOT NULL,
UNIQUE ( store_grp_type_cd)
);

