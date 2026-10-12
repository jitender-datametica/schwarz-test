CREATE TABLE CORE_REL.T_NFPO_HIERARCHY_NODE DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_hier_node_sid                  NUMBER(38,0)     NOT NULL,
   nfpo_hier_name                      VARCHAR(100)     NOT NULL,
   nfpo_hier_node_path_nr              VARCHAR(100)     NOT NULL,
   nfpo_hier_node_cd                   VARCHAR(100)     NOT NULL,
   nfpo_hier_node_name                 VARCHAR(100),
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_HIERARCHY_NODE PRIMARY KEY (nfpo_hier_node_sid) NOT ENFORCED 
)  COMMENT = 'NFPO product hierarchy
             CBX: derived from CNT_ITEM';
