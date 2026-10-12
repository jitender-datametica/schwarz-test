CREATE TABLE P_LEW_CORE.T_REF_ITEM_REL_TYPE (
   item_rel_type_cd                    VARCHAR(20)     COLLATE 'en-ci' NOT NULL COMMENT 'Code: immutable representation of relation type;',
   item_rel_type                       VARCHAR(100)    COLLATE 'en-ci' NOT NULL COMMENT 'Description: updatable description.',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'identifier of the last run which inserted or updated the record',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'creation timestamp of the record in the DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'timestamp of the last update of the record in the DWH',   
   CONSTRAINT PK_T_REF_ITEM_REL_TYPE PRIMARY KEY (item_rel_type_cd) NOT ENFORCED 
)  COMMENT = 'Item relation type
             Reference data:
             item relation types in the NFPO item planning and creation system: 
             PRED1: Predecessor 1
             PRED2: Predecessor 2
             REF_PRED: Reference Predecessor
             REF_MKT: Reference Item in other market';