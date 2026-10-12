/* --------------------------------------------------------------------------------
   DDL for table: t_mdm_item_sku_ean_hist
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 13:40:10
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MDM_ITEM_SKU_EAN_HIST (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'technical column required by the used ETL framework
            static 7 for all rows',
   mdm_item_sku_sid                    NUMBER(38,0)     NOT NULL COMMENT 'foreign key NFPO stock keeping unit
            CBX: CNT_ITEM, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE, LDL_ITEM_SIZE, LDL_ITEM_LSV, LDL_ITEM_ARTICLE_EAN.CNT_ITEM.REF_NO, LDL_STYLE_UNIQUE_IDS, LDL_ITEM_SIZE.LDL_CODE, LDL_ITEM_LSV.LDL_CODE',
   cbx_ean_version_nr                  NUMBER(38,0)     COMMENT 'technical version of the NFPO GTIN assignment to a sku in the source system
            CBX: LDL_ITEM_ARTICLE_EAN.LDL_ITEM_ARTICLE_EAN.REVISION',
   barcode                             VARCHAR(20)      COLLATE 'en-ci' COMMENT 'assigned GTIN of the NFPO stock keeping unit for Lidl
            CBX: CNT_ITEM, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE, LDL_ITEM_SIZE, LDL_ITEM_LSV, LDL_ITEM_ARTICLE_EAN.LDL_ITEM_ARTICLE_EAN.LDL_EAN',
   kfl_barcode                         VARCHAR(20)      COMMENT 'assigned GTIN of the NFPO stock keeping unit for Kaufland
            CBX: CNT_ITEM, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE, LDL_ITEM_SIZE, LDL_ITEM_LSV, LDL_ITEM_ARTICLE_EAN.LDL_ITEM_ARTICLE_EAN.LDL_EAN_KL',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Deleted_fg = 1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'End of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_MDM_ITEM_SKU_EAN_HIST PRIMARY KEY (mdm_item_sku_sid, dwh_valid_from) NOT ENFORCED 
)  COMMENT = 'NFPO item sales variants defined by styles, sizes and LSVs
             CBX: LDL_ITEM_ARTICLE_EAN, LDL_ITEM_UNIQUE_STYLE, LDL_ITEM_SIZE';
