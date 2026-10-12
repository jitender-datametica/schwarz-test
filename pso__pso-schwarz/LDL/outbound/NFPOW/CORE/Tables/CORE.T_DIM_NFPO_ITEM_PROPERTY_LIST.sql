/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_item_property_list
   generated from Powerdesigner on Donnerstag, 7. Dezember 2023 13:49:26
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_nfpo_item_property_list (
nfpo_item_property_list_txt STRING(1000) NOT NULL
OPTIONS(description='Property of the item.            CBX: LDL_ITEM_CERTIFICATION.LDL_CERTIFICATION_PROPERTY            LDL: P_LEW_CORE.T_MDM_ITEM_PROPERTY_ITEM_HIST.MDM_ITEM_PROPERTY_TXT'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.            LDL: P_LEW_CORE.T_MDM_ITEM_PROPERTY_ITEM_HIST.DWH_CREATED'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.            LDL: P_LEW_CORE.T_MDM_ITEM_PROPERTY_ITEM_HIST.DWH_UPDATED'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_item_property_list_txt) NOT ENFORCED
)
OPTIONS(description='Additional properties of NFPO items.             CBX: LDL_ITEM_CERTIFICATION             LDL: P_LEW_CORE.T_MDM_ITEM_PROPERTY_ITEM_HIST');