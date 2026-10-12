/* --------------------------------------------------------------------------------
   DDL for table: t_fact_ldl_client_item_day
   generated from Powerdesigner on Dienstag, 13. Mai 2025 10:26:04
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_LDL_CLIENT_ITEM_DAY DATA_RETENTION_TIME_IN_DAYS = 2 (
   lob_cd                              VARCHAR(100)     NOT NULL COMMENT 'Line of business depends on the general source of the data, "KFL" if the data is taken from the Kaufland DWH, "LDL" if the data is taken from a Lidl DWH.',
   ldl_client_id                       NUMBER(38,0)     NOT NULL,
   ldl_item_sid                        NUMBER(38,0)     NOT NULL,
   cal_dt                              DATE             NOT NULL COMMENT 'Calendar date of the fact in the extract from Kaufland DWH / Lidl retail DWH.',
   curr_cd                             VARCHAR(3)       NOT NULL COMMENT 'Currency code used by Lidl.
            CORE_REL: T_LDL_CURRENCY.CURR_CD
            LDL: P_LEW_CORE.T_CURRENCY.CURR_ISO_CD',
   kfl_consolidated_promo_item_type_cd VARCHAR(100)     NOT NULL COMMENT 'This attribute consolidates the content of the KFL_ITEM_LIST_TYPE_CD into a generalized information about whether an item should be regarded as a promotion item or not.
            "PN" = item is a promotion item
            "SO" = item is not a promotion item
            "no typification" = item is not receiving a type (for LDL, only KFL items get a type)',
   ldl_rcv_qty                         NUMBER(38,5),
   ldl_buying_rcv_net_val              NUMBER(38,5),
   ldl_retail_rcv_net_val              NUMBER(38,5),
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_FACT_LDL_CLIENT_ITEM_DAY PRIMARY KEY (lob_cd, ldl_client_id, cal_dt, curr_cd, ldl_item_sid, kfl_consolidated_promo_item_type_cd) NOT ENFORCED 
)  COMMENT = 'Comment 2Do';
