CREATE TABLE CORE_REL.T_LDL_ITEM_FAMILY_GROUP_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   ldl_client_id                       NUMBER(38,0)     NOT NULL,
   ldl_item_fam_grp_nr                 NUMBER(38,0)     NOT NULL,
   ldl_item_fam_grp_name               VARCHAR(100),
   ldl_item_fam_id                     NUMBER(38,0),
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_LDL_ITEM_FAMILY_GROUP PRIMARY KEY (ldl_client_id, ldl_item_fam_grp_nr) NOT ENFORCED 
)  COMMENT = 'WAWI: P_LEW_MART_MSI_AC_MATERIALIZED.v_itm_familygroup_1';
