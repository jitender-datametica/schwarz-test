CREATE TABLE CORE.T_DIM_LDL_LOCAL_ITEM DATA_RETENTION_TIME_IN_DAYS = 2 (
   lob_cd                              VARCHAR(100)     NOT NULL,
   ldl_client_id                       NUMBER(38,0)     NOT NULL,
   ldl_item_nr                         NUMBER(38,0)     NOT NULL,
   active_from_dt                      DATE             NOT NULL,
   ldl_item_ian_nr                     NUMBER(38,0)     NOT NULL,
   item_origin_type_cd                 VARCHAR(100),
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_LDL_LOCAL_ITEM PRIMARY KEY (lob_cd, ldl_client_id, ldl_item_nr, active_from_dt) NOT ENFORCED 
)  COMMENT = '';