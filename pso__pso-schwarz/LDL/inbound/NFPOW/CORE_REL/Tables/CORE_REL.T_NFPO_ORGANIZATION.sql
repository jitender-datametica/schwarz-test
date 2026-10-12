CREATE TABLE CORE_REL.T_NFPO_ORGANIZATION DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_org_sid                        NUMBER(38,0)     NOT NULL COMMENT 'surrogate key internal organisation',
   nfpo_org_type_cd                    VARCHAR(100)     NOT NULL COMMENT 'type code of the internal organisation',
   nfpo_org_nr                         VARCHAR(100)     NOT NULL COMMENT 'identifier of the internal organisation in the source system',
   nfpo_org_name                       VARCHAR(100)     COMMENT 'name of the internal organisation',
   nfpo_org_descr                      VARCHAR(250)     COMMENT 'description of the onternal organisation',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_ORGANIZATION PRIMARY KEY (nfpo_org_sid) NOT ENFORCED 
)  COMMENT = 'Ths table contains the list of internal organizations of various types. This table is not replacing the already modeled tables containing ERP-related organisational units like client, store or warehouse. It contains organisation types on a level comparable to country or client, but having different business backgrounds and therefore different details.';
