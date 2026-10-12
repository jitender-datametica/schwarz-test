/* --------------------------------------------------------------------------------
   DDL for table: t_ldl_dig_metric_client_item_advertise_day_1
   generated from Powerdesigner on Dienstag, 24. Oktober 2023 10:40:02
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_LDL_DIG_METRIC_CLIENT_ITEM_ADVERTISE_DAY_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   metric_type_id                      NUMBER(38,0)     NOT NULL,
   ldl_dig_client_cd                   VARCHAR(100)     NOT NULL COMMENT 'Client code in the Lidl Digital DWH.',
   ldl_item_ian_nr                     NUMBER(38,0)     NOT NULL COMMENT 'Lidl International Item_1 Number (not necessarily unique in this table - numbers can be reused if an item_1 is cancelled, or multiple item_1 instances will be created for catalog items).',
   adv_dt                              DATE             NOT NULL COMMENT 'Starting date of the advertising campaign.',
   metric_cnt                          NUMBER(38,0),
   metric_qty                          NUMBER(38,5),
   metric_val                          NUMBER(38,5),
   curr_cd                             VARCHAR(3)       COMMENT 'Lidl currencies.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_LDL_DIG_METRIC_CLIENT_ITEM_ADVERTISE_DAY PRIMARY KEY (metric_type_id, ldl_dig_client_cd, ldl_item_ian_nr, adv_dt) NOT ENFORCED 
)  COMMENT = 'Lidl Digital AVQ related metric data on the level web shop, IAN (Lidl international article number) and advertising day. These metrics are used to calculate the percentage of sold items in a prromotion (Abverkaufsquote).';
