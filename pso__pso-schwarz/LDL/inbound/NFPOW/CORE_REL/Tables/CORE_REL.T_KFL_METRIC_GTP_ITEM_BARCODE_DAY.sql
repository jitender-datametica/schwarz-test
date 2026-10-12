/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_metric_gtp_item_barcode_day
   generated from Powerdesigner on Montag, 30. September 2024 17:19:31
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_KFL_METRIC_GTP_ITEM_BARCODE_DAY DATA_RETENTION_TIME_IN_DAYS = 2 (
   metric_type_id                      NUMBER(38,0)     NOT NULL COMMENT 'identifier of the metric in the NFPOW database',
   kfl_client_id                       NUMBER(38,0)     NOT NULL COMMENT 'identifier of the KFL client (Mandant) in the Kaufland DWH',
   kfl_gtp_nr                          NUMBER(38,0)     NOT NULL COMMENT 'identifier of the KFL goods transshipment point (Warenumschlagsplatz) in the Kaufland DWH',
   kfl_gtp_subsidiary_type_id          NUMBER(38,0)     NOT NULL COMMENT 'identifier of the subsidiary type (Nebenstelle) of the KFL goods transshipment point (Warenumschlagsplatz) in the Kaufland DWH',
   kfl_item_nr                         NUMBER(38,0)     NOT NULL COMMENT 'identifier of the KFL item (Artikel) in the Kaufland DWH',
   kfl_barcode_nr                      NUMBER(38,0)     NOT NULL COMMENT 'Number provided by the cash register. Contains in general the scanned GTIN of the item, but in some cases the item_nr or other identifiers of the goods the receiptline is related to.',
   cal_dt                              DATE             NOT NULL COMMENT 'calendar date of the fact in the extract from Kaufland DWH',
   metric_cnt                          NUMBER(38,0)     COMMENT 'value of the metric if it is a counted number',
   metric_qty                          NUMBER(38,5)     COMMENT 'value of the metric if it is a quantity',
   metric_val                          NUMBER(38,5)     COMMENT 'value of the metric if it is an amount',
   metric_price                        NUMBER(38,5)     COMMENT 'value of the metric if it is a price',
   curr_cd                             VARCHAR(3)       COMMENT 'currency code in the Kaufland DWH',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_KFL_METRIC_GTP_ITEM_BARCODE_DAY PRIMARY KEY (metric_type_id, kfl_client_id, kfl_gtp_nr, kfl_gtp_subsidiary_type_id, kfl_item_nr, kfl_barcode_nr, cal_dt) NOT ENFORCED 
)  COMMENT = 'Common table to store all extracted metrics from Kaufland DWH on the level goods transshipment point (Warenumschlagplatz), item (Artikel), scanned barcode and day';
