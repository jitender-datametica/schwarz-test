CREATE TABLE CORE_REL.T_LDL_SUB_ITEM_GROUP_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   ldl_sub_item_grp_id                 NUMBER(38,0)     NOT NULL,
   ldl_item_grp_int_id                 NUMBER(38,0),
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_LDL_SUB_ITEM_GROUP PRIMARY KEY (ldl_sub_item_grp_id) NOT ENFORCED 
)  COMMENT = '';
