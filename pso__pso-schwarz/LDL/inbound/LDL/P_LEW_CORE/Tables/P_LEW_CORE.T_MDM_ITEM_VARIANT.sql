CREATE TABLE P_LEW_CORE.T_MDM_ITEM_VARIANT (
   client_id                           NUMBER(38,0)    NOT NULL COMMENT 'technical column required by the used ETL framework
            static 7 for all rows',
   mdm_item_variant_sid                NUMBER(38,0)    NOT NULL COMMENT 'surrogate key regional NFPO item variant
            CBX: CNT_ITEM,
            LDL_ITEM_LSV.CNT_ITEM.REF_NO,
            LDL_ITEM_LSV.LDL_CODE',
   src_item_doc_ref                    VARCHAR(20)     COLLATE 'en-ci' NOT NULL COMMENT 'NFPO item instance reference
            CBX: CNT_ITEM.REF_NO',
   src_variant_cd                      VARCHAR(20)     COLLATE 'en-ci' NOT NULL COMMENT 'identifier of the regional NFPO item variant for a certain item in the source system
            CBX: LDL_ITEM_LSV.LDL_CODE',
   variant_name                        VARCHAR(300)    COLLATE 'en-ci' COMMENT 'name of the regional NFPO item variant
            CBX: LDL_ITEM_LSV.LDL_NAME',
   mdm_item_sid                        NUMBER(38,0)    NOT NULL COMMENT 'foreign key NFPO item instance
            CBX: CNT_ITEM.REF_NO',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'identifier of the last run which inserted or updated the record',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'creation timestamp of the record in the DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'timestamp of the last update of the record in the DWH',   
   CONSTRAINT PK_T_MDM_ITEM_VARIANT PRIMARY KEY (mdm_item_variant_sid) NOT ENFORCED 
)  COMMENT = 'NFPO item variant defining local variants (extra sizes, languages, plugs, etc.) 
             CBX: LDL_ITEM_LSV';