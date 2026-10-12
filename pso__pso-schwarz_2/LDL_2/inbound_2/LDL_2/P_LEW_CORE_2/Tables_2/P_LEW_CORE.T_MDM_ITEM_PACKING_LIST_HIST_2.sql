CREATE TABLE P_LEW_CORE.T_MDM_ITEM_PACKING_LIST_HIST_2 (
   client_id                           NUMBER(38,0)    NOT NULL COMMENT 'technical column required by the used ETL framework
            static 7 for all rows',
   mdm_pack_list_sid                   NUMBER(38,0)    NOT NULL COMMENT 'surrogate key NFPO packing list
            CBX: CNT_ITEM_2,
            LDL_ITEM_PACKING_METHOD.CNT_ITEM.REF_NO, 
            LDL_ITEM_PACKING_METHOD.LDL_CODE',
   pack_list_version                   NUMBER(38,0)    COMMENT 'technical version of the NFPO packing list
            CBX: LDL_ITEM_PACKING_METHOD.REVISION',
   pack_list_name                      VARCHAR(100)    COLLATE 'en-ci' COMMENT 'name of the NFPO packing list
            CBX: LDL_ITEM_PACKING_METHOD.LDL_NAME',
   pack_list_carton_qty                NUMBER(38,0)    COMMENT 'NFPO packing list sub case quantity
            CBX: LDL_ITEM_PACKING_METHOD.LDL_TOTAL_PACK_RATIO',
   deleted_fg                          NUMBER(38,0)    NOT NULL COMMENT 'deleted_fg=1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to ',
   dwh_valid_from                      DATE            NOT NULL COMMENT 'begin of the validity_2 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity)',
   dwh_valid_to                        DATE            NOT NULL COMMENT 'end of the validity_2 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity)',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'identifier of the last run which inserted or updated the record',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'creation timestamp of the record in the DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'timestamp of the last update of the record in the DWH',   
   CONSTRAINT PK_T_MDM_ITEM_PACKING_LIST_HIST PRIMARY KEY (mdm_pack_list_sid, dwh_valid_from) NOT ENFORCED 
)  COMMENT = 'information about packing lists for the sort boxes of NFPO items
             CBX: LDL_ITEM_PACKING_METHOD_2';