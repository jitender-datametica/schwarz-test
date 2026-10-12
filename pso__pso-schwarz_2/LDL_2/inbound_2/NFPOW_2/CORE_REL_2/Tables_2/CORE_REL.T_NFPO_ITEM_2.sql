CREATE TABLE CORE_REL.T_NFPO_ITEM_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_item_sid                       NUMBER(38,0)     NOT NULL,
   nfpo_item_nr                        VARCHAR(100)     NOT NULL,
   nfpo_item_name                      VARCHAR(100)     NOT NULL,
   ldl_item_ian_nr                     NUMBER(38,0)     NOT NULL,
   nfpo_range_plan_nr                  VARCHAR(100),
   nfpo_item_sel_nr                    VARCHAR(100),
   kfl_step_item_nr                    VARCHAR(100),
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_ITEM PRIMARY KEY (nfpo_item_sid) NOT ENFORCED 
)  COMMENT = 'instances of NFPO items in the quarterly item_2 planning and ordering process. For catalog items there might be several instances in this table, all sharing the same international article number
             CBX: CNT_ITEM_2';
