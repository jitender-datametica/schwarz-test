CREATE TABLE CORE_REL.T_NFPO_USER_ROLE_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_user_role_cd                   VARCHAR(100)     NOT NULL COMMENT 'PK Role Type;',
   nfpo_user_role_name                 VARCHAR(100)     NOT NULL COMMENT 'Mutable name;',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_USER_ROLE PRIMARY KEY (nfpo_user_role_cd) NOT ENFORCED 
)  COMMENT = 'NFPO user role type;
             Static reference data:
             1: EKL: Purchasing Manager
             2: SE: Category Manager (Hardware only)
             3: KVW: Contract Manager
             4: KP: Contract Approver';
