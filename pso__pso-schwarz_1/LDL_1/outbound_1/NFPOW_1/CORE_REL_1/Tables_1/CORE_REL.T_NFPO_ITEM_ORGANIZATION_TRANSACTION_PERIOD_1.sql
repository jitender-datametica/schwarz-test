/* --------------------------------------------------------------------------------
   DDL for table: t_nfpo_item_organization_transaction_period_1
   generated from Powerdesigner on Donnerstag, 7. Dezember 2023 13:57:09
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_item_organization_transaction_period_1 (
nfpo_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate key internal organization.            LDL: P_LEW_CORE.T_INTERNAL_ORGANISATION.INT_ORG_SID'),
nfpo_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key of the related NFPO ITEM_1 INSTANCE'),
nfpo_item_org_assigned_txn_period_begin_dt DATE NOT NULL,
nfpo_item_org_assigned_txn_period_end_dt DATE NOT NULL,
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.            LDL: P_LEW_CORE.T_MDM_BUYER.DWH_CREATED'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.            LDL: P_LEW_CORE.T_MDM_BUYER.DWH_UPDATED'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_org_sid, nfpo_item_sid) NOT ENFORCED
) OPTIONS(description='');