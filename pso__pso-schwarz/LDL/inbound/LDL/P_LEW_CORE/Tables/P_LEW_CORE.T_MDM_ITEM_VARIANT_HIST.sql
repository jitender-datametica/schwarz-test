CREATE TABLE P_LEW_CORE.T_MDM_ITEM_VARIANT_HIST (
   client_id                           NUMBER(38,0)    NOT NULL COMMENT 'technical column required by the used ETL framework
            static 7 for all rows',
   mdm_item_variant_sid                NUMBER(38,0)    NOT NULL COMMENT 'surrogate key regional NFPO item variant
            CBX: CNT_ITEM,
            LDL_ITEM_LSV.CNT_ITEM.REF_NO,
            LDL_ITEM_LSV.LDL_CODE',
   variant_name                        VARCHAR(300)    COLLATE 'en-ci' COMMENT 'name of the regional NFPO item variant
            CBX: LDL_ITEM_LSV.LDL_NAME',
   deleted_fg                          NUMBER(38,0)    NOT NULL COMMENT 'deleted_fg=1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to ',
   dwh_valid_from                      DATE            NOT NULL COMMENT 'begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity)',
   dwh_valid_to                        DATE            NOT NULL COMMENT 'end of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity)',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'identifier of the last run which inserted or updated the record',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'creation timestamp of the record in the DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'timestamp of the last update of the record in the DWH',   
   CONSTRAINT PK_T_MDM_ITEM_VARIANT_HIST PRIMARY KEY (mdm_item_variant_sid, dwh_valid_from) NOT ENFORCED 
)  COMMENT = 'NFPO item variant defining local variants (extra sizes, languages, plugs, etc.) 
             CBX: LDL_ITEM_LSV';