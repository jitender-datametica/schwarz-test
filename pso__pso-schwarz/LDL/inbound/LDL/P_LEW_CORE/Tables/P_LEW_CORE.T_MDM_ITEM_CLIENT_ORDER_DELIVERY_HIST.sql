CREATE TABLE P_LEW_CORE.T_MDM_ITEM_CLIENT_ORDER_DELIVERY_HIST (
   client_id                           NUMBER(38,0)    NOT NULL COMMENT 'technical column required by the used ETL framework
            static 7 for all rows',
   mdm_item_sid                        NUMBER(38,0)    NOT NULL COMMENT 'foreign key NFPO item instance
            CBX: CNT_ITEM.REF_NO',
   client_id_order                     NUMBER(38,0)    NOT NULL COMMENT 'foreign key client (placing order), derived from the identifier of the local NFPO in the NFPO source system
            CBX: LDL_ITEM_QUANTITY.LDL_COUNTRY_CODE',
   int_org_sid                         NUMBER(38,0)    COMMENT 'surrogate key internal organisation, here the local NFPO the order is related to
            CBX: LDL_ITEM_QUANTITY.LDL_COUNTRY_CODE',
   country_del_seq_nr                  NUMBER(38,0)    NOT NULL COMMENT 'sequence of the planned delivery, derived from source column name',
   cy_week_delivery                    NUMBER(38,0)    COMMENT 'scheduled Calendar Week of the delivery
            CBX: LDL_ITEM_QUANTITY.LDL_CTRY_DELIVERY_WEEK1, LDL_CTRY_DELIVERY_WEEK2, LDL_CTRY_DELIVERY_WEEK3',
   country_request_qty                 NUMBER(38,0)    COMMENT 'requested unit quantity
            CBX: LDL_ITEM_QUANTITY.LDL_CTRY_DELIVERY_PLAN_QTY1, LDL_CTRY_DELIVERY_PLAN_QTY2, LDL_CTRY_DELIVERY_PLAN_QTY3',
   country_delivery_qty                NUMBER(38,0)    COMMENT 'scheduled unit quantity
            CBX: LDL_ITEM_QUANTITY.LDL_CTRY_DELIVERY_TOTAL_QTY1, LDL_CTRY_DELIVERY_TOTAL_QTY2, LDL_CTRY_DELIVERY_TOTAL_QTY3',
   deleted_fg                          NUMBER(38,0)    NOT NULL COMMENT 'deleted_fg=1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to ',
   dwh_valid_from                      DATE            NOT NULL COMMENT 'begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity)',
   dwh_valid_to                        DATE            NOT NULL COMMENT 'end of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity)',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'identifier of the last run which inserted or updated the record',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'creation timestamp of the record in the DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'timestamp of the last update of the record in the DWH',   
   CONSTRAINT PK_T_MDM_ITEM_CLIENT_ORDER_DELIVERY_HIST PRIMARY KEY (mdm_item_sid, client_id_order, country_del_seq_nr, dwh_valid_from) NOT ENFORCED 
)  COMMENT = 'order information of NFPO items for the local NFPOs, split into planned delivery waves
             CBX: LDL_ITEM_QUANTITY';