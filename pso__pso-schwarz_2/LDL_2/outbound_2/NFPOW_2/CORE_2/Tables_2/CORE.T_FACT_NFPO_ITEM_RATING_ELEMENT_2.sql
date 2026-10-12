/* --------------------------------------------------------------------------------
   DDL for table: t_fact_nfpo_item_rating_element_2
   generated from Powerdesigner on Donnerstag, 12. September 2024 20:15:01
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_fact_nfpo_item_rating_element_2 (
nfpo_src_item_rating_nr STRING(100) NOT NULL
OPTIONS(description='Identifier of the item_2 rating in the system of the data provider.            LDL: P_LEW_CORE.T_ITEM_RATING.SRC_ITEM_RATING_NR            CORE_REL: T_NFPO_ITEM_RATING.NFPO_SRC_ITEM_RATING_NR'),
nfpo_src_item_rating_element_nr STRING(100) NOT NULL
OPTIONS(description='Identifier of the item_2 rating element in the system of the data provider.            LDL: P_LEW_CORE.T_ITEM_RATING_ELEMENT.SRC_ITEM_RATING_ELEMENT_NR            CORE_REL: T_NFPO_ITEM_RATING_ELEMENT.NFPO_SRC_ITEM_RATING_ELEMENT_NR'),
nfpo_cx_info_provider_nr STRING(100) NOT NULL
OPTIONS(description='Identifier of the provider or collector of the customer experience information - manually filled.            LDL: P_LEW_CORE.T_ITEM_RATING_ELEMENT.CX_INFO_PROVIDER_NR            CORE_REL: T_NFPO_ITEM_RATING_ELEMENT.NFPO_CX_INFO_PROVIDER_NR'),
nfpo_item_rating_element_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key for the rating element of an item.            LDL: P_LEW_CORE.ITEM_RATING_ELEMENT.ITEM_RATING_ELEMENT_SID            CORE_REL: T_NFPO_ITEM_RATING_ELEMENT.NFPO_ITEM_RATING_ELEMENT_SID'),
nfpo_item_rating_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key for the rating of an item.            SALESFORCE: SALESFORCE_COMMENT.CASE_NUMBER AND CX_INFO_PROVIDER_NR            ONLINE SHOP: ONLINE_SHOP_COMMENT.COMMENT_ID AND CX_INFO_PROVIDER_NR            LDL: T_ITEM_RATING_ELEMENT.ITEM_RATING_SID            CORE_REL: T_NFPO_ITEM_RATING_ELEMENT.NFPO_ITEM_RATING_SID'),
nfpo_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key NFPO ITEM_2 INSTANCE.            CBX: CNT_ITEM.REF_NO            LDL: P_LEW_CORE.T_MDM_ITEM.MDM_ITEM_SID            CORE_REL: T_NFPO_ITEM_RATING.LDL_ITEM_IAN_NR'),
nfpo_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate key internal organization.            CBX:            LDL: P_LEW_CORE.T_INTERNAL_ORGANISATION.INT_ORG_SID            CORE_REL: T_NFPO_ITEM_RATING.NFPO_ORG_SID'),
nfpo_item_rating_dt DATE NOT NULL
OPTIONS(description='Date of the item_2 rating event.            SALESFORCE: SALESFORCE_COMMENT.CREATED_DATE            ONLINE SHOP: ONLINE_SHOP_COMMENT.REVIEW_DATE            LDL: P_LEW_CORE.T_ITEM_RATING.ITEM_RATING_DT            CORE_REL: T_NFPO_ITEM_RATING.NFPO_ITEM_RATING_DT'),
nfpo_rating_bias_type_cd STRING(100) NOT NULL
OPTIONS(description='The bias code of the rating derived from NFPO_CX_INFO_PROVIDER_NR: "Complaint" if SF_Google or "Unbiased" if LDI_Google.            LDL: P_LEW_CORE.T_ITEM_RATING.CX_INFO_PROVIDER_NR            CORE_REL: T_NFPO_ITEM_RATING.NFPO_CX_INFO_PROVIDER_NR'),
nfpo_item_rating_element_txt STRING(16000)
OPTIONS(description='Text element given in the rating element by the rater translated into English.            LDL: P_LEW_CORE.T_ITEM_RATING_ELEMENT.ITEM_RATING_ELEMENT_TXT            CORE_REL: T_NFPO_ITEM_RATING_ELEMENT.NFPO_ITEM_RATING_ELEMENT_TXT'),
nfpo_keyword_unigram_list_txt STRING(16000)
OPTIONS(description='List of words used in the rating comment and have been identified as key words.            SALESFORCE: SALESFORCE_WORD_TYPES.WORD            ONLINE SHOP: ONLINE_SHOP_WORD_TYPES.WORD            LDL: P_LEW_CORE.T_ITEM_RATING_ELEMENT_KEYWORD.KEYWORD_UNIGRAM_TXT            CORE_REL: T_NFPO_ITEM_RATING_ELEMENT_KEYWORD.NFPO_KEYWORD_UNIGRAM_TXT'),
nfpo_item_rating_element_sentiment_score_meas BIGNUMERIC(38,5)
OPTIONS(description='Value of the calculated rating score for sentiment of the rating element.            SALESFORCE: SALESFORCE_COMMENT.DESCRIPTION_SENTIMENT/ NUMBER_WORDS            ONLINE SHOP: ONLINE_SHOP_COMMENT.COMMENT_SENTIMENT/NUMBER_WORDS/RATING            LDL: P_LEW_CORE.T_ITEM_RATING_ELEMENT_SCORE.RATING_SCORE_MEAS            CORE_REL: T_NFPO_ITEM_RATING_ELEMENT_SCORE.NFPO_RATING_SCORE_MEAS'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last change to the data record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_src_item_rating_nr, nfpo_src_item_rating_element_nr, nfpo_cx_info_provider_nr) NOT ENFORCED
) OPTIONS(description='This table contains the facts related to item_2 rating elements.');