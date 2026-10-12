CREATE TABLE CORE_REL.T_NFPO_ORGANIZATION_GROUP_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_org_grp_id                     NUMBER(38,0)     NOT NULL,
   nfpo_org_grp_cd                     VARCHAR(100),
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_ORGANIZATION_GROUP PRIMARY KEY (nfpo_org_grp_id) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $ Client block. Groups clients with common logistics.';
