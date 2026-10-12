/* --------------------------------------------------------------------------------
   DDL for table: t_fact_nfpo_item_word_group_1
   generated from Powerdesigner on Dienstag, 6. Mai 2025 11:43:50
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_NFPO_ITEM_WORD_GROUP_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_item_sid                       NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key NFPO ITEM_1 INSTANCE.
            CBX: CNT_ITEM.REF_NO
            LDL: P_LEW_CORE.T_MDM_ITEM.MDM_ITEM_SID
            CORE_REL: T_FACT_NFPO_ITEM_RATING.NFPO_ITEM_SID',
   nfpo_org_sid                        NUMBER(38,0)     NOT NULL COMMENT 'Surrogate key internal organization.
            LDL: P_LEW_CORE.T_INTERNAL_ORGANISATION.INT_ORG_SID
            CORE_REL:T_FACT_NFPO_ITEM_RATING.NFPO_ORG_SID',
   nfpo_cx_info_provider_nr            VARCHAR(100)     NOT NULL COMMENT 'Identifier of the provider or collector of the customer experience information - manually filled.
            LDL: P_LEW_CORE.T_ITEM_RATING.CX_INFO_PROVIDER_NR
            CORE_REL: T_FACT_NFPO_ITEM_RATING.NFPO_CX_INFO_PROVIDER_NR',
   nfpo_item_rating_dt                 DATE             NOT NULL COMMENT 'Date of the item_1 rating event.
            SALESFORCE: SALESFORCE_COMMENT.CREATED_DATE
            ONLINE SHOP: ONLINE_SHOP_COMMENT.REVIEW_DATE
            LDL: P_LEW_CORE.T_ITEM_RATING.ITEM_RATING_DT
            CORE_REL: T_FACT_NFPO_ITEM_RATING.NFPO_ITEM_RATING_DT',
   nfpo_word_grp_txt                   VARCHAR(1000)    NOT NULL COMMENT 'A word that is used in the rating comment and has been identified as key word.
            SALESFORCE: SALESFORCE_WORD_TYPES.WORD / BIGRAM / TRIGRAM
            ONLINE SHOP: ONLINE_SHOP_WORD_TYPES.WORD / BIGRAM / TRIGRAM
            LDL: P_LEW_CORE.T_ITEM_RATING_ELEMENT_KEYWORD.KEYWORD_UNIGRAM_TXT / KEYWORD_BIGRAM_TXT / KEYWORD_TRIGRAM_TXT
            CORE_REL: T_NFPO_ITEM_RATING_ELEMENT_KEYWORD.NFPO_KEYWORD_UNIGRAM_TXT / NFPO_KEYWORD_BIGRAM_TXT / NFPO_KEYWORD_TRIGRAM_TXT',
   nfpo_word_grp_type_cd               VARCHAR(100)     NOT NULL COMMENT 'Group type code of word that is used in the rating comment and has been identified as key word - depending on the source column ("unigram", "bigram" or "trigram").
            SALESFORCE: SALESFORCE_WORD_TYPES.WORD / BIGRAM / TRIGRAM
            ONLINE SHOP: ONLINE_SHOP_WORD_TYPES.WORD / BIGRAM / TRIGRAM
            LDL: P_LEW_CORE.T_ITEM_RATING_ELEMENT_KEYWORD.KEYWORD_UNIGRAM_TXT / KEYWORD_BIGRAM_TXT / KEYWORD_TRIGRAM_TXT
            CORE_REL: T_NFPO_ITEM_RATING_ELEMENT_KEYWORD.NFPO_KEYWORD_UNIGRAM_TXT / NFPO_KEYWORD_BIGRAM_TXT / NFPO_KEYWORD_TRIGRAM_TXT',
   nfpo_sentiment_cd                   VARCHAR(100)     NOT NULL COMMENT 'Code of the sentiment analysis depending on the value of the calculated rating score for sentiment (if score >= 0 then "positive" else "negative").
            SALESFORCE: SALESFORCE_COMMENT.DESCRIPTION_SENTIMENT / NUMBER_WORDS
            ONLINE SHOP: ONLINE_SHOP_COMMENT.COMMENT_SENTIMENT / NUMBER_WORDS / RATING
            LDL: P_LEW_CORE.T_ITEM_RATING_SCORE.RATING_SCORE_MEAS
            CORE_REL: T_FACT_NFPO_ITEM_RATING.NFPO_ITEM_SENTIMENT_SCORE_MEAS',
   nfpo_rating_bias_type_cd            VARCHAR(100)     NOT NULL COMMENT 'CORE_REL: T_NFPO_ITEM_RATING_ELEMENT_KEYWORD.NFPO_RATING_BIAS_TYPE_CD',
   nfpo_item_sentiment_rating_cnt      NUMBER(38,0)     NOT NULL COMMENT 'Count of sentiment ratings for the item.
            CORE_REL: T_NFPO_ITEM_RATING_ELEMENT_KEYWORD.NFPO_KEYWORD_UNIGRAM_TXT',
   nfpo_item_sentiment_rating_element_cnt NUMBER(38,0)     NOT NULL COMMENT 'Count of sentiment rating elements for the item.
            CORE_REL: T_NFPO_ITEM_RATING_ELEMENT_KEYWORD.NFPO_KEYWORD_UNIGRAM_TXT',
   nfpo_item_sentiment_word_grp_cnt    NUMBER(38,0)     NOT NULL COMMENT 'Count of sentiment word groups for the item.
            CORE_REL: T_NFPO_ITEM_RATING_ELEMENT_KEYWORD.NFPO_KEYWORD_UNIGRAM_TXT',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_FACT_NFPO_ITEM_WORD_GROUP PRIMARY KEY (nfpo_item_sid, nfpo_org_sid, nfpo_cx_info_provider_nr, nfpo_item_rating_dt, nfpo_word_grp_txt, nfpo_word_grp_type_cd, nfpo_sentiment_cd, nfpo_rating_bias_type_cd) NOT ENFORCED 
)  COMMENT = 'This table contains aggregated facts about wordgroup, wordgroup type, sentiment, rating bias, item_1, organization and date.';
