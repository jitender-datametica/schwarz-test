CREATE TABLE CORE_REL.T_NFPO_ITEM_SIZE_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_item_size_sid                  NUMBER(38,0)     NOT NULL,
   nfpo_item_nr                        VARCHAR(100)     NOT NULL,
   nfpo_item_size_nr                   VARCHAR(300)     NOT NULL,
   nfpo_item_sid                       NUMBER(38,0)     NOT NULL,
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_ITEM_SIZE PRIMARY KEY (nfpo_item_size_sid) NOT ENFORCED 
)  COMMENT = 'NFPO item_1 variant defining sizes
             CBX: LDL_ITEM_SIZE_1';
