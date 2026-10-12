/* --------------------------------------------------------------------------------
   DDL for table: t_mdm_item_client_order_sku_breakdown_hist_2
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 13:34:51
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MDM_ITEM_CLIENT_ORDER_SKU_BREAKDOWN_HIST_2 (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'technical column required by the used ETL framework
            static 7 for all rows',
   mdm_item_sid                        NUMBER(38,0)     NOT NULL COMMENT 'foreign key NFPO item_2 instance
            CBX: CNT_ITEM.REF_NO',
   client_id_order                     NUMBER(38,0)     NOT NULL COMMENT 'foreign key client (placing order), derived from the identifier of the local NFPO in the NFPO source system
            CBX: LDL_ITEM_QUANTITY.LDL_COUNTRY_CODE',
   int_org_sid                         NUMBER(38,0)     COMMENT 'surrogate key internal organisation, here the organisation the order is related to
            CBX: LDL_ITEM_QUANTITY.LDL_COUNTRY_CODE',
   mdm_item_sku_sid                    NUMBER(38,0)     NOT NULL COMMENT 'foreign key NFPO stock keeping unit_2
            CBX: CNT_ITEM_2, LDL_ITEM_VARIANT.CNT_ITEM.REF_NO, LDL_ITEM_VARIANT.LDL_STYLE_UNIQUE_IDS, LDL_ITEM_VARIANT.LDL_SIZE_CODE, LDL_ITEM_VARIANT.LDL_LSV_CODE',
   order_sku_qty                       NUMBER(38,0)     COMMENT 'Quantity of SKU to deliver;
            CBX: LDL_ITEM_VARIANT_QUANTITY.LDL_VARIANT_QTY',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Deleted_fg = 1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Begin of the validity_2 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'End of the validity_2 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_MDM_ITEM_CLIENT_ORDER_SKU_BREAKDOWN_HIST PRIMARY KEY (mdm_item_sid, client_id_order, mdm_item_sku_sid, dwh_valid_from) NOT ENFORCED 
)  COMMENT = 'order information of NFPO item_2 variants (level stock keeping unit_2) for the local NFPOs
             CBX: LDL_ITEM_VARIANT_QUANTITY';
