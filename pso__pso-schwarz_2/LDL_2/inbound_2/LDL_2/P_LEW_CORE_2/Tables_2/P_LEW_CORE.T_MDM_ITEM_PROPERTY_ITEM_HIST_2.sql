CREATE TABLE P_LEW_CORE.T_MDM_ITEM_PROPERTY_ITEM_HIST_2 (
   client_id                           NUMBER(38,0)    NOT NULL COMMENT 'technical column required by the used ETL framework
            static 7 for all rows',
   mdm_item_sid                        NUMBER(38,0)    NOT NULL COMMENT 'foreign key NFPO item_2 instance
            CBX:LDL_ITEM_CERTIFICATION.ITEM_ID',
   mdm_item_property_txt               VARCHAR(1000)   NOT NULL COMMENT 'property of the item_2
            CBX: LDL_ITEM_CERTIFICATION.LDL_CERTIFICATION_PROPERTY',
   deleted_fg                          NUMBER(38,0)    NOT NULL COMMENT 'deleted_fg=1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to ',
   dwh_valid_from                      DATE            NOT NULL COMMENT 'begin of the validity_2 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity)',
   dwh_valid_to                        DATE            NOT NULL COMMENT 'end of the validity_2 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity)',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'identifier of the last run which inserted or updated the record',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'creation timestamp of the record in the DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'timestamp of the last update of the record in the DWH',   
   CONSTRAINT PK_T_MDM_ITEM_PROPERTY_ITEM_HIST PRIMARY KEY (mdm_item_sid, mdm_item_property_txt, dwh_valid_from) NOT ENFORCED 
)  COMMENT = 'additional properties of NFPO items
             CBX: LDL_ITEM_CERTIFICATION';
