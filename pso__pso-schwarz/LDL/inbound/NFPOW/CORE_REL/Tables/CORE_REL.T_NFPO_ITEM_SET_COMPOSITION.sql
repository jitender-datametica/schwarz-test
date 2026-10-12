CREATE TABLE CORE_REL.T_NFPO_ITEM_SET_COMPOSITION DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_item_set_sid                   NUMBER(38,0)     NOT NULL,
   nfpo_item_style_sid                 NUMBER(38,0)     NOT NULL,
   nfpo_item_set_style_qty             NUMBER(38,5)     NOT NULL,
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_ITEM_SET_COMPOSITION PRIMARY KEY (nfpo_item_set_sid, nfpo_item_style_sid) NOT ENFORCED 
)  COMMENT = 'NFPO item variant defining sets of styles relation to single styles
             CBX: LDL_ITEM_UNIQUE_STYLE, LDL_ITEM_STYLE';
