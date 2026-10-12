/* --------------------------------------------------------------------------------
   DDL for table: t_ldl_item_nfpo_item
   generated from Powerdesigner on Dienstag, 1. August 2023 13:10:45
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_ldl_item_nfpo_item (
ldl_client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate key of the ERP client in the Lidl DWH            LDL: P_LEW_MART_LEAD_AC.V_ITM_ITEM.CLIENT_ID'),
ldl_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='surrogate key of the item in the Lidl DWH            LDL: P_LEW_MART_LEAD_AC.V_ITM_ITEM.ITEM_ID'),
nfpo_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key of the related NFPO ITEM INSTANCE'),
nfpo_item_sel_nr STRING(100) OPTIONS(description='NFPO source system internal identifier of the related article'),
ldl_item_ian_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='related Lidl International Item number'),
kfl_visible_fg BOOL NOT NULL
OPTIONS(description='indicator whether the item can be included into the Apollo Kaufland reporting'),
kfl_client_id BIGNUMERIC(38,0) OPTIONS(description='related identifier of the KFL client (Mandant) in the Kaufland DWH'),
pseudo_kfl_item_nr BIGNUMERIC(38,0)
OPTIONS(description='constructed identifier of the Lidl item in the Kaufland item context'),
nfpo_default_item_fg BOOL NOT NULL
OPTIONS(description='indicator whether this is the record which should be used to have an unique target item record in NFPO (and KFL) in the case that more then one possible target record exist (for example for catalog items)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction'),
PRIMARY KEY (ldl_item_sid, nfpo_item_sid) NOT ENFORCED
) OPTIONS(description='this table relates Lidl items to items in CBX and KFL');