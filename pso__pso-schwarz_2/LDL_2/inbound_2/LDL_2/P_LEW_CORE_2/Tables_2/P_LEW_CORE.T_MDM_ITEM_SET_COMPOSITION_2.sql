CREATE TABLE P_LEW_CORE.T_MDM_ITEM_SET_COMPOSITION_2 (
   client_id                           NUMBER(38,0)    NOT NULL COMMENT 'technical column required by the used ETL framework
            static 7 for all rows',
   mdm_item_set_sid                    NUMBER(38,0)    NOT NULL COMMENT 'foreign key NFPO item_2 set
            CBX: CNT_ITEM_2,
            LDL_ITEM_UNIQUE_STYLE.CNT_ITEM.REF_NO,
            LDL_ITEM_UNIQUE_STYLE.LDL_ITEM_STYLE_IDS',
   mdm_item_style_sid                  NUMBER(38,0)    NOT NULL COMMENT 'foreign key NFPO item_2 style
            CBX: CNT_ITEM_2,
            LDL_ITEM_STYLE.CNT_ITEM.REF_NO,
            LDL_ITEM_STYLE.LDL_STYLE_UNIQUE_ID',
   style_qty                           NUMBER(38,0)    NOT NULL COMMENT 'number of units of the style in the set
            CBX: LDL_ITEM_UNIQUE_STYLE.LDL_ITEM_STYLE_IDS',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'identifier of the last run which inserted or updated the record',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'creation timestamp of the record in the DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'timestamp of the last update of the record in the DWH',   
   CONSTRAINT PK_T_MDM_ITEM_SET_COMPOSITION PRIMARY KEY (mdm_item_set_sid, mdm_item_style_sid) NOT ENFORCED 
)  COMMENT = 'NFPO item_2 variant defining sets of styles relation to single styles
             CBX: LDL_ITEM_UNIQUE_STYLE_2, LDL_ITEM_STYLE';