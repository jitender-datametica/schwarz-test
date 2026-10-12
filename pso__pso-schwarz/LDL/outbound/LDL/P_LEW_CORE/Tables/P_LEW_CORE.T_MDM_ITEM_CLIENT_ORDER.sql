/* --------------------------------------------------------------------------------
   DDL for table: t_mdm_item_client_order
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 13:31:35
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_mdm_item_client_order (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='technical column required by the used ETL framework            static 7 for all rows'),
mdm_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='foreign key NFPO item instance            CBX: CNT_ITEM.REF_NO'),
client_id_order BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='foreign key client (placing order), derived from the identifier of the local NFPO in the NFPO source system            CBX: LDL_ITEM_QUANTITY.LDL_COUNTRY_CODE'),
int_org_sid BIGNUMERIC(38,0)
OPTIONS(description='surrogate key internal organisation, here the local NFPO the order is related to            CBX: LDL_ITEM_QUANTITY.LDL_COUNTRY_CODE'),
client_cd STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='identifier of the local NFPO in the NFPO source system, used to identify a representing Lidl client in the set of Lidl ERP clients            CBX: LDL_ITEM_QUANTITY.LDL_COUNTRY_CODE'),
client_block_id_order BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='foreign key Country Block            CBX: LDL_ITEM_QUANTITY.LDL_COUNTRY_CODE'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (mdm_item_sid, client_id_order) NOT ENFORCED
) OPTIONS(description='order information of NFPO items for the local NFPOs             CBX: LDL_ITEM_QUANTITY');