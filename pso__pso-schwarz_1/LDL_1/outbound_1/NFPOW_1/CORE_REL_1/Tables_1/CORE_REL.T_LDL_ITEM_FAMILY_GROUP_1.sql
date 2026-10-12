CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_ldl_item_family_group_1 (
ldl_client_id BIGNUMERIC(38,0) NOT NULL,
ldl_item_fam_grp_nr BIGNUMERIC(38,0) NOT NULL,
ldl_item_fam_grp_name STRING(100),
ldl_item_fam_id BIGNUMERIC(38,0),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (ldl_client_id, ldl_item_fam_grp_nr) NOT ENFORCED
) OPTIONS(description='WAWI: P_LEW_MART_MSI_AC_MATERIALIZED.v_itm_familygroup_1');