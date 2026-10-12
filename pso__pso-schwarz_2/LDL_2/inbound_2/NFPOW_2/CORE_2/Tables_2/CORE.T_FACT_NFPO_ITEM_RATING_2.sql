/* --------------------------------------------------------------------------------
   DDL for table: t_fact_nfpo_item_rating_2
   generated from Powerdesigner on Dienstag, 6. Mai 2025 11:44:21
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_NFPO_ITEM_RATING_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_src_item_rating_nr             VARCHAR(100)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   nfpo_cx_info_provider_nr            VARCHAR(100)     NOT NULL COMMENT 'Identifier of the provider or collector of the customer experience information - Manually filled
            LDL: p_lew_core.t_item_rating.cx_info_provider_nr
            CORE_REL:t_nfpo_item_rating.nfpo_cx_info_provider_nr',
   nfpo_item_rating_sid                NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key for rating of an item_2
            SALESFORCE: salesforce_comment.case_number and cx_info_provider_nr
            ONLINE SHOP:online_shop_comment.comment_id and cx_info_provider_nr
            LDL:t_item_rating.item_rating_sid
            CORE_REL:t_nfpo_item_rating.nfpo_item_rating_sid',
   nfpo_item_sid                       NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key NFPO ITEM_2 INSTANCE.
            CBX: CNT_ITEM.REF_NO
            LDL: P_LEW_CORE.T_MDM_ITEM.MDM_ITEM_SID
            CORE_REL:t_nfpo_item_rating.ldl_item_ian_nr',
   nfpo_org_sid                        NUMBER(38,0)     NOT NULL COMMENT 'Surrogate key internal organization.
            CBX:
            LDL: P_LEW_CORE.T_INTERNAL_ORGANISATION.INT_ORG_SID
            CORE_REL:t_nfpo_item_rating.nfpo_org_sid',
   nfpo_item_rating_dt                 DATE             NOT NULL COMMENT 'Date of the item_2 rating event.
            SALESFORCE: salesforce_comment.created_date
            ONLINE SHOP:online_shop_comment.review_date
            LDL: p_lew_core.t_item_rating.item_rating_dt
            CORE_REL:t_nfpo_item_rating.nfpo_item_rating_dt',
   nfpo_rating_bias_type_cd            VARCHAR(100)     NOT NULL COMMENT 'The bias code of the rating derived from nfpo_cx_info_provider_nr: "Complaint" if SF_Google or "Unbiased" if LDI_Google
            LDL: p_lew_core.t_item_rating.cx_info_provider_nr
            CORE_REL:t_nfpo_item_rating.nfpo_cx_info_provider_nr',
   nfpo_item_rating_txt                VARCHAR(16000)   COMMENT 'Text given in the rating by the rater translated into English.
            ONLINE SHOP:online_shop_comment.comment
            LDL: p_lew_core.t_item_rating.item_rating_txt
            CORE_REL:t_nfpo_item_rating.nfpo_item_rating_txt',
   nfpo_keyword_unigram_list_txt       VARCHAR(16000)   COMMENT 'List of words used in the rating comment and has been identified as key word
            SALESFORCE: salesforce_word_types.word
            ONLINE SHOP:online_shop_word_types.word
            LDL:p_lew_core.t_item_rating_element_keyword.keyword_unigram_txt
            CORE_REL:t_nfpo_item_rating_element_keyword.nfpo_keyword_unigram_txt',
   nfpo_item_star_score_meas           NUMBER(38,5)     COMMENT 'Value of the calculated rating score for common star score (1-5)
            SALESFORCE: salesforce_comment.description_sentiment/number_words
            ONLINESHOP:online_shop_comment.comment_sentiment/number_words/rating
            LDL:p_lew_core.t_item_rating_score.rating_score_meas
            CORE_REL:t_nfpo_item_rating_score.nfpo_rating_score_meas',
   nfpo_item_sentiment_score_meas      NUMBER(38,5)     COMMENT 'Value of the calculated rating score for sentiment
            SALESFORCE:salesforce_comment.description_sentiment/ number_words
            ONLINESHOP:online_shop_comment.comment_sentiment/number_words/rating
            LDL:p_lew_core.t_item_rating_score.rating_score_meas
            CORE_REL:t_nfpo_item_rating_score.nfpo_rating_score_meas',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_FACT_NFPO_ITEM_RATING PRIMARY KEY (nfpo_src_item_rating_nr, nfpo_cx_info_provider_nr) NOT ENFORCED 
)  COMMENT = 'this table contains the facts related to single item_2 ratings';
