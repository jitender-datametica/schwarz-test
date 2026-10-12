/* --------------------------------------------------------------------------------
   DDL for table: t_ldl_metric_store_item_day_2
   generated from Powerdesigner on Dienstag, 24. Oktober 2023 13:07:22
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_LDL_METRIC_STORE_ITEM_DAY_2 CLUSTER BY (LDL_CLIENT_ID)
DATA_RETENTION_TIME_IN_DAYS = 2 (
   metric_type_id                      NUMBER(38,0)     NOT NULL,
   ldl_store_sid                       NUMBER(38,0)     NOT NULL,
   ldl_item_sid                        NUMBER(38,0)     NOT NULL,
   cal_dt                              DATE             NOT NULL,
   metric_cnt                          NUMBER(38,0),
   metric_qty                          NUMBER(38,5),
   metric_val                          NUMBER(38,5),
   metric_price                        NUMBER(38,5),
   metric_rate                         NUMBER(38,5),
   curr_cd                             VARCHAR(3),
   ldl_client_id                       NUMBER(38,0)     NOT NULL,
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_LDL_METRIC_STORE_ITEM_DAY PRIMARY KEY (metric_type_id, ldl_store_sid, ldl_item_sid, cal_dt) NOT ENFORCED 
)  COMMENT = 'common metric table to store extraction results from the Lidl DWH on the level store and item_2 represented by the surrogate identifiers used in the Lidl DWH';
