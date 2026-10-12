/* --------------------------------------------------------------------------------
   DDL for table: t_mdm_item_variant_client_hist
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 13:40:34
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_mdm_item_variant_client_hist (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''technical column required by the used ETL framework
            static 7 for all rows'''),
mdm_item_variant_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''foreign key regional NFPO item variant
            CBX: CNT_ITEM,
            LDL_ITEM_LSV.CNT_ITEM.REF_NO,
            LDL_ITEM_LSV.LDL_CODE'''),
client_id_recipient BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''foreign key client (to use the specific item variant), derived from the identifier of the local NFPO in the NFPO source system
            CBX: LDL_ITEM_LSV.LDL_COUNTRY_CODES'''),
int_org_sid BIGNUMERIC(38,0)
OPTIONS(description='''surrogate key internal organisation, here the organisation which is using the specivic LSV in the definition of stock keeping units ordered by this local NFPO
            CBX: LDL_ITEM_LSV.LDL_COUNTRY_CODE'''),
client_block_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''foreign key Country Block
            CBX: LDL_ITEM_LSV.LDL_COUNTRY_CODES'''),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Deleted_fg = 1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='End of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (mdm_item_variant_sid, client_id_recipient, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='''relation between local NFPO item variants and target NFPOs
             CBX: LDL_ITEM_LSV''');