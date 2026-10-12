CREATE TABLE CORE_REL.T_NFPO_ITEM_RELATION_TYPE DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_item_rel_type_cd               VARCHAR(100)     NOT NULL,
   nfpo_item_rel_type_name             VARCHAR(100)     NOT NULL,
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_ITEM_RELATION_TYPE PRIMARY KEY (nfpo_item_rel_type_cd) NOT ENFORCED 
)  COMMENT = 'Item relation type
             Reference data:
             item relation types in the NFPO item planning and creation system: 
             PRED1: Predecessor 1
             PRED2: Predecessor 2
             REF_PRED: Reference Predecessor
             REF_MKT: Reference Item in other market';
