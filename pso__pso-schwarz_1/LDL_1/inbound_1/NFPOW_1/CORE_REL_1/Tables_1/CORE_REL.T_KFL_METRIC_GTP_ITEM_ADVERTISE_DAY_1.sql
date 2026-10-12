/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_metric_gtp_item_advertise_day_1
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:31
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_KFL_METRIC_GTP_ITEM_ADVERTISE_DAY_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   metric_type_id                      NUMBER(38,0)     NOT NULL,
   kfl_client_id                       NUMBER(38,0)     NOT NULL,
   kfl_gtp_nr                          NUMBER(38,0)     NOT NULL,
   kfl_gtp_subsidiary_type_id          NUMBER(38,0)     NOT NULL,
   kfl_item_nr                         NUMBER(38,0)     NOT NULL,
   cal_week                            NUMBER(38,0)     NOT NULL,
   kfl_adv_period_type_id              NUMBER(38,0)     NOT NULL,
   cal_dt                              DATE             NOT NULL,
   metric_cnt                          NUMBER(38,0),
   metric_qty                          NUMBER(38,5),
   metric_val                          NUMBER(38,5),
   curr_cd                             VARCHAR(3),
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_KFL_METRIC_GTP_ITEM_ADVERTISE_DAY PRIMARY KEY (metric_type_id, kfl_client_id, kfl_gtp_nr, kfl_gtp_subsidiary_type_id, kfl_item_nr, cal_week, kfl_adv_period_type_id) NOT ENFORCED 
)  COMMENT = 'Common table to store all extracted metrics from Kaufland DWH on the level goods transshipment point (Warenumschlagplatz), item_1 (Artikel_1) and advertising day. These metrics are used to calculate the percentage of sold items in a prromotion (Abverkaufsquote)';

