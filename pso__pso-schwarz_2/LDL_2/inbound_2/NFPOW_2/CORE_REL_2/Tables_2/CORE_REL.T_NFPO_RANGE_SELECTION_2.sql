CREATE TABLE CORE_REL.T_NFPO_RANGE_SELECTION_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_range_sel_sid                  NUMBER(38,0)     NOT NULL,
   nfpo_range_sel_nr                   VARCHAR(100)     NOT NULL,
   nfpo_range_plan_nr                  VARCHAR(100),
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_RANGE_SELECTION PRIMARY KEY (nfpo_range_sel_sid) NOT ENFORCED 
)  COMMENT = 'NFPO quarterly waves to define and order items
             CBX: CNT_PROGRAM';
