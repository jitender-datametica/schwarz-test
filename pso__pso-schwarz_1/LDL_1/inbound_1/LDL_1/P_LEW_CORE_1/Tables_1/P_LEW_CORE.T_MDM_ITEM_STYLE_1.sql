CREATE TABLE P_LEW_CORE.T_MDM_ITEM_STYLE_1 (
   client_id                           NUMBER(38,0)    NOT NULL COMMENT 'technical column required by the used ETL framework
            static 7 for all rows',
   mdm_item_style_sid                  NUMBER(38,0)    NOT NULL COMMENT 'surrogate key NFPO item_1 style
            CBX: CNT_ITEM_1,
            LDL_ITEM_STYLE.CNT_ITEM.REF_NO,
            LDL_ITEM_STYLE.LDL_STYLE_UNIQUE_ID',
   src_item_doc_ref                    VARCHAR(20)     COLLATE 'en-ci' NOT NULL COMMENT 'NFPO item_1 instance reference
            CBX: CNT_ITEM.REF_NO',
   src_style_uniq_id                   VARCHAR(200)    COLLATE 'en-ci' NOT NULL COMMENT 'identifier of the item_1 style in the source system
            CBX: LDL_ITEM_STYLE.LDL_STYLE_UNIQUE_ID',
   style_name                          VARCHAR(300)    COLLATE 'en-ci' COMMENT 'name of the item_1 style
            CBX: LDL_ITEM_STYLE.LDL_PRODUCT_NAME',
   mdm_item_sid                        NUMBER(38,0)    NOT NULL COMMENT 'foreign key NFPO item_1 instance
            CBX: CNT_ITEM.REF_NO',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'identifier of the last run which inserted or updated the record',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'creation timestamp of the record in the DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'timestamp of the last update of the record in the DWH',   
   CONSTRAINT PK_T_MDM_ITEM_STYLE PRIMARY KEY (mdm_item_style_sid) NOT ENFORCED 
)  COMMENT = 'NFPO item_1 variant defining styles
             CBX: LDL_ITEM_STYLE';