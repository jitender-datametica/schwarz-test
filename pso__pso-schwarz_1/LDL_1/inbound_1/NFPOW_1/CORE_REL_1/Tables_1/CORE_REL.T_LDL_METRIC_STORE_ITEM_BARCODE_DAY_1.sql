/* --------------------------------------------------------------------------------
   DDL for table: t_ldl_metric_store_item_barcode_day_1
   generated from Powerdesigner on Montag, 30. September 2024 17:22:13
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_LDL_METRIC_STORE_ITEM_BARCODE_DAY_1 CLUSTER BY (LDL_CLIENT_ID)
DATA_RETENTION_TIME_IN_DAYS = 2 (
   metric_type_id                      NUMBER(38,0)     NOT NULL COMMENT 'identifier of the metric in the NFPOW database',
   ldl_store_sid                       NUMBER(38,0)     NOT NULL COMMENT 'surrogate key of the store in the Lidl DWH',
   ldl_item_sid                        NUMBER(38,0)     NOT NULL COMMENT 'surrogate key of the item_1 in the Lidl DWH',
   ldl_barcode_nr                      VARCHAR(100)     NOT NULL COMMENT 'String provided by the cash register. Contains in general the scanned GTIN of the item_1, but in some cases the local item_1 number or other identifiers of the goods or processes the receiptline is related to.',
   cal_dt                              DATE             NOT NULL COMMENT 'calendar_1 date of the fact in the extract from Lidl retail DWH',
   metric_cnt                          NUMBER(38,0)     COMMENT 'value of the metric if it is a counted number',
   metric_qty                          NUMBER(38,5)     COMMENT 'value of the metric if it is a quantity',
   metric_val                          NUMBER(38,5)     COMMENT 'value of the metric if it is an amount',
   metric_price                        NUMBER(38,5)     COMMENT 'value of the metric if it is a price',
   metric_rate                         NUMBER(38,5)     COMMENT 'value of the metric if it is a rate',
   curr_cd                             VARCHAR(3)       COMMENT 'currency code used by Lidl',
   ldl_client_id                       NUMBER(38,0)     NOT NULL COMMENT 'Surrogate key of the ERP client in the Lidl DWH',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_LDL_METRIC_STORE_ITEM_BARCODE_DAY PRIMARY KEY (metric_type_id, ldl_store_sid, ldl_item_sid, cal_dt, ldl_barcode_nr) NOT ENFORCED 
)  COMMENT = 'common metric table to store extraction results from the Lidl DWH for every metric on the level store, item_1, scanned barcode and day represented by the surrogate identifiers used in the Lidl DWH';
