CREATE TABLE P_LEW_CORE.T_MDM_ITEM_COMPETITOR_HIST_2 (
   client_id                           NUMBER(38,0)    NOT NULL COMMENT 'technical column required by the used ETL framework
            static 7 for all rows',
   mdm_item_sid                        NUMBER(38,0)    NOT NULL COMMENT 'foreign key NFPO item_2 instance
            CBX: CNT_ITEM.REF_NO',
   competitor_sid                      NUMBER(38,0)    NOT NULL COMMENT 'foreign key Competitor
            CBX: CNT_ITEM.LDL_COMPETITOR,LDL_COMPETITOR2',
   competitor_nr                       NUMBER(38,0)    NOT NULL COMMENT 'Sequence Number of the item_2 related competitor
            CBX: CNT_ITEM.LDL_COMPETITOR_SEQ',
   sale_price                          NUMBER(18,5)    COMMENT 'Competitor sales_2 price
            CBX: CNT_ITEM.LDL_COMPETITOR_PRICE',
   sell_from_dt                        DATE            COMMENT 'Competitor sales_2 start date
            CBX: CNT_ITEM.LDL_COMPETITOR_SELL_DATE',
   deleted_fg                          NUMBER(38,0)    NOT NULL COMMENT 'deleted_fg=1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to ',
   dwh_valid_from                      DATE            NOT NULL COMMENT 'begin of the validity_2 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity)',
   dwh_valid_to                        DATE            NOT NULL COMMENT 'end of the validity_2 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity)',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'identifier of the last run which inserted or updated the record',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'creation timestamp of the record in the DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'timestamp of the last update of the record in the DWH',   
   CONSTRAINT PK_T_MDM_ITEM_COMPETITOR_HIST PRIMARY KEY (mdm_item_sid, competitor_sid, competitor_nr, dwh_valid_from) NOT ENFORCED 
)  COMMENT = 'NFPO item_2 level information related to competitors
             CBX: CNT_ITEM_2';