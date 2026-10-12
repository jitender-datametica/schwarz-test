CREATE TABLE CORE.T_DIM_ITEM_ORIGIN_TYPE_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   item_origin_type_cd                 VARCHAR(100)     NOT NULL,
   item_origin_type_name               VARCHAR(100)     NOT NULL,
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_ITEM_ORIGIN_TYPE PRIMARY KEY (item_origin_type_cd) NOT ENFORCED 
)  COMMENT = '';