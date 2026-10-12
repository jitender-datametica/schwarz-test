/* --------------------------------------------------------------------------------
   DDL for table: t_nfpo_item_rating_element_keyword_1
   generated from Powerdesigner on Dienstag, 24. Oktober 2023 10:36:11
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_NFPO_ITEM_RATING_ELEMENT_KEYWORD_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_item_rating_element_keyword_sid NUMBER(38,0)     NOT NULL COMMENT 'surrogate identifier for the nfpo item_1 rating element keyword record. the same keyword can be used multiple times in a sentence in similar context.
            LDL: p_lew_core.item_rating_element_keyword.item_rating_element_keyword_sid',
   nfpo_cx_info_provider_nr            VARCHAR(100)     NOT NULL COMMENT 'Identifier of the provider or collector of the customer experience information.
            LDL: p_lew_core.t_item_rating_element_keyword.cx_info_provider_nr',
   nfpo_item_rating_element_sid        NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key for rating element of an item_1
            LDL: p_lew_core.item_rating_element_keyword.item_rating_element_sid',
   nfpo_src_item_rating_element_nr     VARCHAR(100)     NOT NULL COMMENT 'Identifier of the item_1 rating element in the system of the data provider.
            LDL: p_lew_core.t_item_rating_element_keyword.src_item_rating_element_nr',
   nfpo_rating_keyword_type_cd         VARCHAR(100)     NOT NULL COMMENT 'Code for the discriminator values for keyword types used in nfpo rating.
            LDL: p_lew_core.t_ref_item_rating_element_keyword.item_rating_keyword_type_cd',
   nfpo_keyword_unigram_txt            VARCHAR(1000)    NOT NULL COMMENT 'A word that is used in the rating comment and has been identified as key word
            LDL: p_lew_core.t_item_rating_element_keyword.keyword_unigram_txt',
   nfpo_keyword_bigram_txt             VARCHAR(1000)    COMMENT 'A 2 word combinaton consisting of the keyword and related significant word that is used in rating
            LDL: p_lew_core.t_item_rating_element_keyword.keyword_bigram_txt',
   nfpo_keyword_trigram_txt            VARCHAR(1000)    COMMENT 'A 3 words combinaton from target word and related significant words that is used in rating
            LDL: p_lew_core.t_item_rating_element_keyword.keyword_trigram_txt',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.
            LDL: p_lew_core.t_item_rating_element_keyword.DWH_CREATED',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.
            LDL: p_lew_core.t_item_rating_element_keyword.DWH_UPDATED',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_ITEM_RATING_ELEMENT_KEYWORD PRIMARY KEY (nfpo_item_rating_element_keyword_sid) NOT ENFORCED 
)  COMMENT = 'This table contains the keywords related to item_1 rating elements.
             LDL: p_lew_core.t_item_rating_element_keyword_1';
