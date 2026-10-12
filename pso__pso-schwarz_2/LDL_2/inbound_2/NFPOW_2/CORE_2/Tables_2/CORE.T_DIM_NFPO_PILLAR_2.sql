CREATE TABLE CORE.T_DIM_NFPO_PILLAR_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_pillar_sid                     NUMBER(38,0)     NOT NULL COMMENT 'surrogate key, identifier of the pillar in CBX, alternative item_2 grouping, groups item_2 family groups
            CBX:Item_2/ldlPillar
            ESB:cbxItem/pillar',
   nfpo_pillar_name                    VARCHAR(100)     NOT NULL COMMENT 'namne for the identifier of the pillar in CBX, alternative item_2 grouping, groups item_2 family groups
            CBX:Item_2/ldlPillar
            ESB:cbxItem/pillar',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_NFPO_PILLAR PRIMARY KEY (nfpo_pillar_sid) NOT ENFORCED 
)  COMMENT = 'NFPO alternative item_2 grouping
             CBX: CNT_ITEM.LDL_PILLAR';