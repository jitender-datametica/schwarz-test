CREATE TABLE CORE_REL.T_NFPO_ITEM_ORGANIZATION_ORDER DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_item_sid                       NUMBER(38,0)     NOT NULL,
   nfpo_org_sid                        NUMBER(38,0)     NOT NULL,
   nfpo_org_nr                         VARCHAR(100)     NOT NULL,
   nfpo_org_grp_id                     NUMBER(38,0)     NOT NULL,
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_ITEM_ORGANIZATION_ORDER PRIMARY KEY (nfpo_item_sid, nfpo_org_sid) NOT ENFORCED 
)  COMMENT = 'order information of NFPO items for the local NFPO''s
             CBX: LDL_ITEM_QUANTITY';
