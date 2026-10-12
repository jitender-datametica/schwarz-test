/* --------------------------------------------------------------------------------
   DDL for table: t_nfpo_item_rating_element_1
   generated from Powerdesigner on Dienstag, 24. Oktober 2023 10:35:45
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_NFPO_ITEM_RATING_ELEMENT_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_item_rating_element_sid        NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key for rating element of an item_1
            LDL: p_lew_core.item_rating_element.item_rating_element_sid',
   nfpo_cx_info_provider_nr            VARCHAR(100)     NOT NULL COMMENT 'Identifier of the provider or collector of the customer experience information.
            LDL: p_lew_core.t_item_rating_element.cx_info_provider_nr',
   nfpo_src_item_rating_element_nr     VARCHAR(100)     NOT NULL COMMENT 'Identifier of the item_1 rating element in the system of the data provider.
            LDL: p_lew_core.t_item_rating_element.src_item_rating_element_nr',
   nfpo_item_rating_sid                NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key for rating of an item_1
            LDL: p_lew_core.item_rating_element.item_rating_sid',
   nfpo_item_rating_element_txt        VARCHAR(16000)   COMMENT 'Text element given in the rating by the rater translated into English.
            LDL: p_lew_core.t_item_rating_element.item_rating_element_txt',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.
            LDL: LDL: p_lew_core.t_item_rating_element.DWH_CREATED',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.
            LDL: LDL: p_lew_core.t_item_rating_element.DWH_UPDATED',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_ITEM_RATING_ELEMENT PRIMARY KEY (nfpo_item_rating_element_sid) NOT ENFORCED 
)  COMMENT = 'This table contains elements ( for example individual sentences of a rating comment) of item_1 ratings by real or potential customers giving their opinion about Lidl.
             These ratings are provided by certain sevice providers (Predict, Medallia, Google, ...) and are available for both Lidl Stationary and Lidl Digital articles.
             LDL: p_lew_core.t_item_rating_element_1';
