/* --------------------------------------------------------------------------------
   DDL for table: t_nfpo_item_rating
   generated from Powerdesigner on Dienstag, 24. Oktober 2023 10:32:50
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_NFPO_ITEM_RATING DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_item_rating_sid                NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key for rating of an item
            LDL: p_lew_core.item_rating.item_rating_sid',
   nfpo_cx_info_provider_nr            VARCHAR(100)     NOT NULL COMMENT 'Identifier of the provider or collector of the customer experience information.
            LDL: p_lew_core.t_item_rating.cx_info_provider_nr',
   nfpo_org_sid                        NUMBER(38,0)     NOT NULL COMMENT 'Surrogate key internal organization.
            LDL: P_LEW_CORE.Tt_item_rating.INT_ORG_SID',
   nfpo_src_item_rating_nr             VARCHAR(100)     NOT NULL COMMENT 'Identifier of the item rating event in the system of the data provider.
            LDL: p_lew_core.t_item_rating.src_item_rating_nr',
   ldl_item_ian_nr                     NUMBER(38,0)     NOT NULL COMMENT 'Lidl International Item Number
            LDL: p_lew_core.t_item_rating.item_ian_nr',
   nfpo_item_rating_dt                 DATE             NOT NULL COMMENT 'Date of the item rating event.
            LDL: p_lew_core.t_item_rating.item_rating_dt',
   nfpo_item_rating_txt                VARCHAR(16000)   COMMENT 'Text given in the rating by the rater translated into English.
            LDL: p_lew_core.t_item_rating.item_rating_txt',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.
            LDL: LDL: p_lew_core.t_item_rating.DWH_CREATED',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.
            LDL: LDL: p_lew_core.t_item_rating.DWH_UPDATED',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_ITEM_RATING PRIMARY KEY (nfpo_item_rating_sid) NOT ENFORCED 
)  COMMENT = 'This table contains items ratings by real or potential customers giving their opinion about non food products of Lidl.
             These ratings are provided by certain sevice providers (Predict, Medallia, Google, ...) and are available for both Lidl Stationary and Lidl Digital articles.
             LDL: p_lew_core.t_item_rating';
