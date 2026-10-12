/* --------------------------------------------------------------------------------
   DDL for table: t_nfpo_item_style_hist_2
   generated from Powerdesigner on Freitag, 12. Dezember 2025 14:01:01
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_NFPO_ITEM_STYLE_HIST_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_item_style_sid                 NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key NFPO ITEM_2 STYLE.
            CBX: CNT_ITEM_2,
            LDL_ITEM_STYLE.CNT_ITEM.REF_NO,
            LDL_ITEM_STYLE.LDL_STYLE_UNIQUE_ID
            LDL: P_LEW_CORE.T_MDM_ITEM_STYLE_HIST.MDM_ITEM_STYLE_SID',
   nfpo_item_style_cd                  VARCHAR(100)     NOT NULL COMMENT 'Item_2 style code, usually IAN + suffix.
            CBX: LDL_ITEM_STYLE.LDL_ITEM_STYLE_NO
            LDL: P_LEW_CORE.T_MDM_ITEM_STYLE_HIST.STYLE_CD',
   nfpo_item_style_name                VARCHAR(300)     COMMENT 'Name of the item_2 style.
            CBX: LDL_ITEM_STYLE.LDL_PRODUCT_NAME
            LDL: P_LEW_CORE.T_MDM_ITEM_STYLE_HIST.STYLE_NAME',
   nfpo_item_style_note_txt            VARCHAR(4000)    COMMENT 'Item_2 style description.
            CBX: LDL_ITEM_STYLE.LDL_PRODUCT_DESC
            LDL: P_LEW_CORE.T_MDM_ITEM_STYLE_HIST.STYLE_DESCR',
   nfpo_item_style_color_descr         VARCHAR(4000)    COMMENT 'Item_2 style color description. Non-standard textual entries referring to color descriptions.
            CBX: LDL_ITEM_STYLE.LDL_FARBE
            LDL: P_LEW_CORE.T_MDM_ITEM_STYLE_HIST.COLOR_DESCR',
   dwh_deleted_fg                      BOOLEAN          NOT NULL COMMENT 'If deleted_fg = 1, it means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.
            LDL: P_LEW_CORE.T_MDM_ITEM_STYLE_HIST.DELETED_FG',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Beginning of the validity_2 interval of the record, oldest record of the history starts with 1900-01-01 00:00:00 (minus infinity).
            LDL: P_LEW_CORE.T_MDM_ITEM_STYLE_HIST.DWH_VALID_FROM',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'End of the validity_2 interval of the record, newest record of the history ends with 9999-12-30 23:59:59 (plus infinity).
            LDL: P_LEW_CORE.T_MDM_ITEM_STYLE_HIST.DWH_VALID_TO',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_ITEM_STYLE_HIST PRIMARY KEY (nfpo_item_style_sid, dwh_valid_from_tmsp) NOT ENFORCED 
)  COMMENT = 'NFPO item_2 variant defining styles.
             CBX: LDL_ITEM_STYLE
             LDL: P_LEW_CORE.T_MDM_ITEM_STYLE_HIST_2';

