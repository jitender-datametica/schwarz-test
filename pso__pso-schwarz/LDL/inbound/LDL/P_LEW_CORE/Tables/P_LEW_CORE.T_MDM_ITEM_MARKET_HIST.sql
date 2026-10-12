CREATE TABLE P_LEW_CORE.T_MDM_ITEM_MARKET_HIST (
   client_id                           NUMBER(38,0)    NOT NULL COMMENT 'technical column required by the used ETL framework
            static 7 for all rows',
   mdm_item_sid                        NUMBER(38,0)    NOT NULL COMMENT 'foreign key NFPO item instance
            CBX: CNT_ITEM.REF_NO',
   market_sid                          NUMBER(38,0)    NOT NULL COMMENT 'foreign key NFPO market
            CBX: CNT_ITEM.LDL_INCOTERMS, LDL_INCOTERM_US, LDL_COMPLETION_TYPE, LDL_COMPLETION_TYPE_US',
   mdm_incoterm_cd                     VARCHAR(100)    COMMENT 'NFPO incoterm codes similar to the terms defined by the International Chamber of Commerce
            CBX: CNT_ITEM.LDL_INCOTERMS, LDL_INCOTERM_US',
   mdm_completion_type_cd              VARCHAR(100)    COMMENT 'NFPO completion types
            CBX: CNT_ITEM.LDL_COMPLETION_TYPE, LDL_COMPLETION_TYPE_US',
   invoice_curr_cd                     VARCHAR(3)      COMMENT 'invoice currency for certain markets: here only the currency code for the market US is available
            CBX: CNT_ITEM.LDL_CURRENCY_US',
   deleted_fg                          NUMBER(38,0)    NOT NULL COMMENT 'deleted_fg=1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to ',
   dwh_valid_from                      DATE            NOT NULL COMMENT 'begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity)',
   dwh_valid_to                        DATE            NOT NULL COMMENT 'end of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity)',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'identifier of the last run which inserted or updated the record',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'creation timestamp of the record in the DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'timestamp of the last update of the record in the DWH',   
   CONSTRAINT PK_T_MDM_ITEM_MARKET_HIST PRIMARY KEY (mdm_item_sid, market_sid, dwh_valid_from) NOT ENFORCED 
)  COMMENT = 'inormation of NFPO items in relation to markets
             CBX: CNT_ITEM';