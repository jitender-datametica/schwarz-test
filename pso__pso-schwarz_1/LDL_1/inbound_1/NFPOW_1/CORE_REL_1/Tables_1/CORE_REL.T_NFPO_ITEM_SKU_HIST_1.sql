/* --------------------------------------------------------------------------------
   DDL for table: t_nfpo_item_sku_hist_1
   generated from Powerdesigner on Freitag, 12. Dezember 2025 14:01:01
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_NFPO_ITEM_SKU_HIST_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_item_sku_sid                   NUMBER(38,0)     NOT NULL COMMENT 'Foreign Key NFPO STOCK KEEPING UNIT.
            CBX: CNT_ITEM_1, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_1, LDL_ITEM_SIZE_1, LDL_ITEM_LSV_1, LDL_ITEM_ARTICLE_EAN.CNT_ITEM.REF_NO, LDL_STYLE_UNIQUE_IDS, LDL_ITEM_SIZE.LDL_CODE, LDL_ITEM_LSV.LDL_CODE
            LDL: P_LEW_CORE.T_MDM_ITEM_SKU_HIST.MDM_ITEM_SKU_SID',
   nfpo_item_sku_weight_kg_meas        NUMBER(38,5)     COMMENT 'Defined weight in kilogramm for the stock keeping unit.
            CBX: CBX_LDL_ITEM_ARTICLE_EAN.LDL_UNIT_WT
            LDL: P_LEW_CORE.T_MDM_ITEM_SKU_HIST.MDM_ITEM_SKU_WEIGHT_KG_MEAS',
   dwh_deleted_fg                      BOOLEAN          NOT NULL COMMENT 'If deleted_fg = 1, it means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.DELETED_FG',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Beginning of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 00:00:00 (minus infinity).
            LDL: P_LEW_CORE.T_MDM_ITEM_SKU_HIST.DWH_VALID_FROM',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'End of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 23:59:59 (plus infinity).
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.DWH_VALID_TO',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_ITEM_SKU_HIST PRIMARY KEY (nfpo_item_sku_sid, dwh_valid_from_tmsp) NOT ENFORCED 
)  COMMENT = 'NFPO item_1 sales_1 variants defined by styles, sizes and LSVs.
             CBX: LDL_ITEM_ARTICLE_EAN_1, LDL_ITEM_UNIQUE_STYLE_1, LDL_ITEM_SIZE_1
             LDL: P_LEW_CORE.T_MDM_ITEM_SKU_HIST_1';

