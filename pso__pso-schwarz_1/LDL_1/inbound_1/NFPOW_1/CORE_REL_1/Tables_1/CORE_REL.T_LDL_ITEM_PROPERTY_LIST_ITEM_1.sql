CREATE TABLE CORE_REL.T_LDL_ITEM_PROPERTY_LIST_ITEM_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   ldl_item_sid                        NUMBER(38,0)     NOT NULL,
   ldl_item_property_list_nr           NUMBER(38,0)     NOT NULL,
   ldl_client_id                       NUMBER(38,0)     NOT NULL,
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_LDL_ITEM_PROPERTY_LIST_ITEM PRIMARY KEY (ldl_item_property_list_nr, ldl_item_sid) NOT ENFORCED 
)  COMMENT = '';
