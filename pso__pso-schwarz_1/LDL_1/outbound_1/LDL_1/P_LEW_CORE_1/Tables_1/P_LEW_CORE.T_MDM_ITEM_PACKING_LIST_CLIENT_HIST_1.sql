/* --------------------------------------------------------------------------------
   DDL for table: t_mdm_item_packing_list_client_hist_1
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 13:36:13
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_mdm_item_packing_list_client_hist_1 (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''technical column required by the used ETL framework
            static 7 for all rows'''),
mdm_pack_list_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''foreign key NFPO packing list
            CBX: CNT_ITEM_1,
            LDL_ITEM_PACKING_METHOD.CNT_ITEM.REF_NO, 
            LDL_ITEM_PACKING_METHOD.LDL_CODE'''),
client_id_recipient BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''foreign key client (the packing list is assigned to), derived from the identifier of the local NFPO in the NFPO source system
            CBX: LDL_ITEM_PACKING_METHOD.LDL_COUNTRY_CODES'''),
int_org_sid BIGNUMERIC(38,0)
OPTIONS(description='''surrogate key internal organisation, here the organisation the packing list is related to
            CBX: LDL_ITEM_PACKING_METHOD.LDL_COUNTRY_CODE'''),
country_cd STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='''identifier of the local NFPO in the NFPO source system
            CBX: LDL_ITEM_PACKING_METHOD.LDL_COUNTRY_CODES'''),
client_block_id_recipient BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''foreign key Country_1 Block
            CBX: LDL_ITEM_PACKING_METHOD.LDL_COUNTRY_CODES'''),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Deleted_fg = 1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Begin of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='End of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (mdm_pack_list_sid, client_id_recipient, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='''relation of packing lists and local NFPOs
             CBX: LDL_ITEM_PACKING_METHOD_1''');