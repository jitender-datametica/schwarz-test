CREATE TABLE P_LEW_CORE.T_MDM_ITEM_PACKING_LIST_2 (
   client_id                           NUMBER(38,0)    NOT NULL COMMENT 'technical column required by the used ETL framework
            static 7 for all rows',
   mdm_pack_list_sid                   NUMBER(38,0)    NOT NULL COMMENT 'surrogate key NFPO packing list
            CBX: CNT_ITEM_2,
            LDL_ITEM_PACKING_METHOD.CNT_ITEM.REF_NO, 
            LDL_ITEM_PACKING_METHOD.LDL_CODE',
   src_item_doc_ref                    VARCHAR(20)     COLLATE 'en-ci' NOT NULL COMMENT 'NFPO item_2 instance reference
            CBX: CNT_ITEM.REF_NO',
   src_pack_method_cd                  VARCHAR(20)     COLLATE 'en-ci' NOT NULL COMMENT 'NFPO packing method code
            CBX: LDL_ITEM_PACKING_METHOD.LDL_CODE',
   mdm_item_sid                        NUMBER(38,0)    NOT NULL COMMENT 'foreign key NFPO item_2 instance
            CBX: CNT_ITEM.REF_NO',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'identifier of the last run which inserted or updated the record',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'creation timestamp of the record in the DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'timestamp of the last update of the record in the DWH',   
   CONSTRAINT PK_T_MDM_ITEM_PACKING_LIST PRIMARY KEY (mdm_pack_list_sid) NOT ENFORCED 
)  COMMENT = 'information about packing lists for the sort boxes of NFPO items
             CBX: LDL_ITEM_PACKING_METHOD_2';