CREATE TABLE P_LEW_CORE.T_MDM_ITEM_CLIENT_RELEASE_1 (
   client_id                           NUMBER(38,0)    NOT NULL COMMENT 'technical column required by the used ETL framework
            static 7 for all rows',
   mdm_item_sid                        NUMBER(38,0)    NOT NULL COMMENT 'foreign key NFPO item_1 instance
            CBX: CNT_ITEM.REF_NO',
   client_id_release                   NUMBER(38,0)    NOT NULL COMMENT 'foreign key client (alowed to order the item_1), derived from the identifier of the local NFPO in the NFPO source system
            CBX: CNT_ITEM.LDL_ORDERABLE',
   int_org_sid                         NUMBER(38,0)    COMMENT 'surrogate key internal organisation, here the organisation which is allowed to order the item_1
            CBX: CNT_ITEM.LDL_ORDERABLE',
   deleted_fg                          NUMBER(38,0)    NOT NULL COMMENT 'deleted_fg=1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to ',
   dwh_valid_from                      DATE            NOT NULL COMMENT 'begin of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity)',
   dwh_valid_to                        DATE            NOT NULL COMMENT 'end of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity)',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'identifier of the last run which inserted or updated the record',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'creation timestamp of the record in the DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'timestamp of the last update of the record in the DWH',   
   CONSTRAINT PK_T_MDM_ITEM_CLIENT_RELEASE PRIMARY KEY (mdm_item_sid, client_id_release, dwh_valid_from) NOT ENFORCED 
)  COMMENT = 'information which local NFPO is allowed to order the NFPO items
             CBX: CNT_ITEM_1';