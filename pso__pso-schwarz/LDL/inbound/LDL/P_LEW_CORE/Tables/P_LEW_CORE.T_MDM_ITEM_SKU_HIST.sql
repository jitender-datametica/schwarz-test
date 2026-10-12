/* --------------------------------------------------------------------------------
   DDL for table: t_mdm_item_sku_hist
   generated from Powerdesigner on Dienstag, 25. November 2025 15:37:37
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MDM_ITEM_SKU_HIST (
   mdm_item_sku_sid                    NUMBER(38,0)     NOT NULL COMMENT 'Foreign key NFPO stock keeping unit.
            CBX: CNT_ITEM, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE, LDL_ITEM_SIZE, LDL_ITEM_LSV, LDL_ITEM_ARTICLE_EAN.CNT_ITEM.REF_NO, LDL_STYLE_UNIQUE_IDS, LDL_ITEM_SIZE.LDL_CODE, LDL_ITEM_LSV.LDL_CODE',
   mdm_item_sku_weight_kg_meas         NUMBER(38,5)     COMMENT 'Defined weight in kilogramm for the stock keeping unit.
            CBX: CBX_LDL_ITEM_ARTICLE_EAN.LDL_UNIT_WT',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Deleted_fg = 1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'End of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).',
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'Technical column required by the used ETL framework. Static 7 for all rows.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_MDM_ITEM_SKU_HIST PRIMARY KEY (mdm_item_sku_sid, dwh_valid_from) NOT ENFORCED 
)  COMMENT = 'NFPO item sales variants defined by styles, sizes and LSVs.
             CBX: LDL_ITEM_ARTICLE_EAN, LDL_ITEM_UNIQUE_STYLE, LDL_ITEM_SIZE';
