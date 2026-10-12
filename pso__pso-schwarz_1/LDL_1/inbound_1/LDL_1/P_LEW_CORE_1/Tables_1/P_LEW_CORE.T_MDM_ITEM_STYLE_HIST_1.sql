/* --------------------------------------------------------------------------------
   DDL for table: t_mdm_item_style_hist_1
   generated from Powerdesigner on Dienstag, 25. November 2025 15:36:33
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MDM_ITEM_STYLE_HIST_1 (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'Technical column required by the used ETL framework. Static 7 for all rows.',
   mdm_item_style_sid                  NUMBER(38,0)     NOT NULL COMMENT 'surrogate key NFPO item_1 style
            CBX: CNT_ITEM_1,
            LDL_ITEM_STYLE.CNT_ITEM.REF_NO,
            LDL_ITEM_STYLE.LDL_STYLE_UNIQUE_ID',
   style_cd                            VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'item_1 style code, usually IAN + suffix
            CBX: LDL_ITEM_STYLE.LDL_ITEM_STYLE_NO',
   style_name                          VARCHAR(300)     COLLATE 'en-ci' COMMENT 'name of the item_1 style
            CBX: LDL_ITEM_STYLE.LDL_PRODUCT_NAME',
   style_descr                         VARCHAR(4000)    COLLATE 'en-ci' COMMENT 'item_1 style description
            CBX: LDL_ITEM_STYLE.LDL_PRODUCT_DESC',
   color_descr                         VARCHAR(4000)    COMMENT 'Item_1 style color description. Non-standard textual entries referring to color descriptions.
            CBX: LDL_ITEM_STYLE.LDL_FARBE',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Deleted_fg = 1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Begin of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'End of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_MDM_ITEM_STYLE_HIST PRIMARY KEY (mdm_item_style_sid, dwh_valid_from) NOT ENFORCED 
)  COMMENT = 'NFPO item_1 variant defining styles.
             CBX: LDL_ITEM_STYLE';
