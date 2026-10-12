CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_item_organization_order_1 (
nfpo_item_sid BIGNUMERIC(38,0) NOT NULL,
nfpo_org_sid BIGNUMERIC(38,0) NOT NULL,
nfpo_org_nr STRING(100) NOT NULL,
nfpo_org_grp_id BIGNUMERIC(38,0) NOT NULL,
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_item_sid, nfpo_org_sid) NOT ENFORCED
) OPTIONS(description='order information of NFPO items for the local NFPO\'s             CBX: LDL_ITEM_QUANTITY_1');