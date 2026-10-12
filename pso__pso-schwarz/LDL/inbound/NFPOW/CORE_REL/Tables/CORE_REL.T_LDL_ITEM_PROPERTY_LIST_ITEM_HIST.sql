CREATE TABLE CORE_REL.T_LDL_ITEM_PROPERTY_LIST_ITEM_HIST DATA_RETENTION_TIME_IN_DAYS = 2 (
   ldl_item_sid                        NUMBER(38,0)     NOT NULL,
   ldl_item_property_list_nr           NUMBER(38,0)     NOT NULL,
   ldl_client_id                       NUMBER(38,0)     NOT NULL,
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL,
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL,
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_LDL_ITEM_PROPERTY_LIST_ITEM_HIST PRIMARY KEY (ldl_item_sid, ldl_item_property_list_nr) NOT ENFORCED 
)  COMMENT = '';
