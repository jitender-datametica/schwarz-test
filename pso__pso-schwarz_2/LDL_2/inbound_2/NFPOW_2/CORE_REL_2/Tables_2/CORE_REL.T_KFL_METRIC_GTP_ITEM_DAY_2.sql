/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_metric_gtp_item_day_2
   generated from Powerdesigner on Dienstag, 24. Oktober 2023 12:19:52
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_KFL_METRIC_GTP_ITEM_DAY_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   metric_type_id                      NUMBER(38,0)     NOT NULL,
   kfl_client_id                       NUMBER(38,0)     NOT NULL,
   kfl_gtp_nr                          NUMBER(38,0)     NOT NULL,
   kfl_gtp_subsidiary_type_id          NUMBER(38,0)     NOT NULL,
   kfl_item_nr                         NUMBER(38,0)     NOT NULL,
   cal_dt                              DATE             NOT NULL,
   metric_cnt                          NUMBER(38,0),
   metric_qty                          NUMBER(38,5),
   metric_val                          NUMBER(38,5),
   metric_price                        NUMBER(38,5),
   curr_cd                             VARCHAR(3),
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_KFL_METRIC_GTP_ITEM_DAY PRIMARY KEY (metric_type_id, kfl_client_id, kfl_gtp_nr, kfl_gtp_subsidiary_type_id, kfl_item_nr, cal_dt) NOT ENFORCED 
)  COMMENT = 'Common table to store all extracted metrics from Kaufland DWH on the level goods transshipment point (Warenumschlagplatz), item_2 (Artikel_2) and day';
