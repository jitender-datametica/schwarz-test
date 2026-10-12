/* --------------------------------------------------------------------------------
   DDL for table: t_nfpo_item_ldl_item
   generated from Powerdesigner on Donnerstag, 17. August 2023 15:45:59
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_item_ldl_item (
nfpo_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Foreign Key NFPO ITEM INSTANCE.            LDL: P_LEW_CORE.T_ITEM_MDM_LINK.MDM_ITEM_SID'),
ldl_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key of the ERP system based item variant (overarching unique, not just within a certain client).            LDL: P_LEW_CORE.T_ITEM_MDM_LINK.ITEM_SID'),
ldl_item_role_cd STRING(100) NOT NULL
OPTIONS(description='Role of the ERP system based item variant in the relation to the CBX based item.            LDL: P_LEW_CORE.T_ITEM_MDM_LINK.CLIENT_ITEM_ROLE_CD'),
ldl_client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key of the ERP client of the item related to the NFPO item instance.            LDL: P_LEW_CORE.T_ITEM_MDM_LINK.CLIENT_ID'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.            LDL: P_LEW_CORE.T_ITEM_MDM_LINK.DWH_CREATED'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.            LDL: P_LEW_CORE.T_ITEM_MDM_LINK.DWH_UPDATED'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (ldl_item_sid, nfpo_item_sid) NOT ENFORCED
)
OPTIONS(description='Relation between NFPO items and local ERP system based items.             Populated by algorithm using t_item and t_mdm_item and the IAN of the NFPO item.             LDL: P_LEW_CORE.T_ITEM_MDM_LINK');