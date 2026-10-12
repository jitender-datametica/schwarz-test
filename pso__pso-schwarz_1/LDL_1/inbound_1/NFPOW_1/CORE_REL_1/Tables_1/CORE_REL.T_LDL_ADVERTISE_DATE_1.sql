CREATE TABLE CORE_REL.T_LDL_ADVERTISE_DATE_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   ldl_client_id                       NUMBER(38,0),
   ldl_adv_dt                          DATE,
   ldl_adv_dt_name                     VARCHAR(100),
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.'
)  COMMENT = '';
