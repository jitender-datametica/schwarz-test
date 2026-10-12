/* --------------------------------------------------------------------------------
   DDL for table: t_mdm_item_client_order_sku_breakdown_hist_1
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 13:34:51
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_mdm_item_client_order_sku_breakdown_hist_1 (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''technical column required by the used ETL framework
            static 7 for all rows'''),
mdm_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''foreign key NFPO item_1 instance
            CBX: CNT_ITEM.REF_NO'''),
client_id_order BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''foreign key client (placing order), derived from the identifier of the local NFPO in the NFPO source system
            CBX: LDL_ITEM_QUANTITY.LDL_COUNTRY_CODE'''),
int_org_sid BIGNUMERIC(38,0)
OPTIONS(description='''surrogate key internal organisation, here the organisation the order is related to
            CBX: LDL_ITEM_QUANTITY.LDL_COUNTRY_CODE'''),
mdm_item_sku_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''foreign key NFPO stock keeping unit_1
            CBX: CNT_ITEM_1, LDL_ITEM_VARIANT.CNT_ITEM.REF_NO, LDL_ITEM_VARIANT.LDL_STYLE_UNIQUE_IDS, LDL_ITEM_VARIANT.LDL_SIZE_CODE, LDL_ITEM_VARIANT.LDL_LSV_CODE'''),
order_sku_qty BIGNUMERIC(38,0)
OPTIONS(description='''Quantity of SKU to deliver;
            CBX: LDL_ITEM_VARIANT_QUANTITY.LDL_VARIANT_QTY'''),
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
PRIMARY KEY (mdm_item_sid, client_id_order, mdm_item_sku_sid, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='''order information of NFPO item_1 variants (level stock keeping unit_1) for the local NFPOs
             CBX: LDL_ITEM_VARIANT_QUANTITY''');