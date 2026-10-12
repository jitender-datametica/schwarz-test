/* --------------------------------------------------------------------------------
   DDL for table: t_metric_type_1
   generated from Powerdesigner on Donnerstag, 17. August 2023 15:33:58
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_METRIC_TYPE_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   metric_type_id                      NUMBER(38,0)     NOT NULL,
   metric_type_name                    VARCHAR(100),
   metric_type_descr_de                VARCHAR(1000),
   metric_type_descr_en                VARCHAR(1000),
   lob_cd                              VARCHAR(100),
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_METRIC_TYPE PRIMARY KEY (metric_type_id) NOT ENFORCED 
)  COMMENT = 'The metric type identifies metrics troughout all metric tables in the relational layer in NFPOW';
