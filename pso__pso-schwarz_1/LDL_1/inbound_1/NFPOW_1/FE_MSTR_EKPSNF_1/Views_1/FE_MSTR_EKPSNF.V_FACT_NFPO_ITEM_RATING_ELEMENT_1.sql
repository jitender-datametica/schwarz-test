CREATE OR REPLACE VIEW FE_MSTR_EKPSNF.V_FACT_NFPO_ITEM_RATING_ELEMENT_1 (
   nfpo_src_item_rating_nr                  COMMENT 'Identifier of the item_1 rating in the system of the data provider.
LDL: P_LEW_CORE.T_ITEM_RATING.SRC_ITEM_RATING_NR
CORE_REL: T_NFPO_ITEM_RATING.NFPO_SRC_ITEM_RATING_NR'
  ,nfpo_src_item_rating_element_nr          COMMENT 'Identifier of the item_1 rating element in the system of the data provider.
LDL: P_LEW_CORE.T_ITEM_RATING_ELEMENT.SRC_ITEM_RATING_ELEMENT_NR
CORE_REL: T_NFPO_ITEM_RATING_ELEMENT.NFPO_SRC_ITEM_RATING_ELEMENT_NR'
  ,nfpo_cx_info_provider_nr                 COMMENT 'Identifier of the provider or collector of the customer experience information - manually filled.
LDL: P_LEW_CORE.T_ITEM_RATING_ELEMENT.CX_INFO_PROVIDER_NR
CORE_REL: T_NFPO_ITEM_RATING_ELEMENT.NFPO_CX_INFO_PROVIDER_NR'
  ,nfpo_item_rating_element_sid             COMMENT 'Surrogate Key for the rating element of an item.
LDL: P_LEW_CORE.ITEM_RATING_ELEMENT.ITEM_RATING_ELEMENT_SID
CORE_REL: T_NFPO_ITEM_RATING_ELEMENT.NFPO_ITEM_RATING_ELEMENT_SID'
  ,nfpo_item_rating_sid                     COMMENT 'Surrogate Key for the rating of an item.
SALESFORCE: SALESFORCE_COMMENT.CASE_NUMBER AND CX_INFO_PROVIDER_NR
ONLINE SHOP: ONLINE_SHOP_COMMENT.COMMENT_ID AND CX_INFO_PROVIDER_NR
LDL: T_ITEM_RATING_ELEMENT.ITEM_RATING_SID
CORE_REL: T_NFPO_ITEM_RATING_ELEMENT.NFPO_ITEM_RATING_SID'
  ,nfpo_item_sid                            COMMENT 'Surrogate Key NFPO ITEM_1 INSTANCE.
CBX: CNT_ITEM.REF_NO
LDL: P_LEW_CORE.T_MDM_ITEM.MDM_ITEM_SID
CORE_REL: T_NFPO_ITEM_RATING.LDL_ITEM_IAN_NR'
  ,nfpo_org_sid                             COMMENT 'Surrogate key internal organization.
CBX:
LDL: P_LEW_CORE.T_INTERNAL_ORGANISATION.INT_ORG_SID
CORE_REL: T_NFPO_ITEM_RATING.NFPO_ORG_SID'
  ,nfpo_item_rating_dt                      COMMENT 'Date of the item_1 rating event.
SALESFORCE: SALESFORCE_COMMENT.CREATED_DATE
ONLINE SHOP: ONLINE_SHOP_COMMENT.REVIEW_DATE
LDL: P_LEW_CORE.T_ITEM_RATING.ITEM_RATING_DT
CORE_REL: T_NFPO_ITEM_RATING.NFPO_ITEM_RATING_DT'
  ,nfpo_rating_bias_type_cd                 COMMENT 'The bias code of the rating derived from NFPO_CX_INFO_PROVIDER_NR: "Complaint" if SF_Google or "Unbiased" if LDI_Google.
LDL: P_LEW_CORE.T_ITEM_RATING.CX_INFO_PROVIDER_NR
CORE_REL: T_NFPO_ITEM_RATING.NFPO_CX_INFO_PROVIDER_NR'
  ,nfpo_item_rating_element_txt             COMMENT 'Text element given in the rating element by the rater translated into English.
LDL: P_LEW_CORE.T_ITEM_RATING_ELEMENT.ITEM_RATING_ELEMENT_TXT
CORE_REL: T_NFPO_ITEM_RATING_ELEMENT.NFPO_ITEM_RATING_ELEMENT_TXT'
  ,nfpo_keyword_unigram_list_txt            COMMENT 'List of words used in the rating comment and have been identified as key words.
SALESFORCE: SALESFORCE_WORD_TYPES.WORD
ONLINE SHOP: ONLINE_SHOP_WORD_TYPES.WORD
LDL: P_LEW_CORE.T_ITEM_RATING_ELEMENT_KEYWORD.KEYWORD_UNIGRAM_TXT
CORE_REL: T_NFPO_ITEM_RATING_ELEMENT_KEYWORD.NFPO_KEYWORD_UNIGRAM_TXT'
  ,nfpo_item_rating_element_sentiment_score_meas COMMENT 'Value of the calculated rating score for sentiment of the rating element.
SALESFORCE: SALESFORCE_COMMENT.DESCRIPTION_SENTIMENT/ NUMBER_WORDS
ONLINE SHOP: ONLINE_SHOP_COMMENT.COMMENT_SENTIMENT/NUMBER_WORDS/RATING
LDL: P_LEW_CORE.T_ITEM_RATING_ELEMENT_SCORE.RATING_SCORE_MEAS
CORE_REL: T_NFPO_ITEM_RATING_ELEMENT_SCORE.NFPO_RATING_SCORE_MEAS'
  ,dwh_created_tmsp                         COMMENT 'Timestamp of the initial insertion of the data record into the DWH.'
  ,dwh_updated_tmsp                         COMMENT 'Timestamp of the last change to the data record in the DWH.'
  ,dwh_src_tmsp                             COMMENT 'Timestamp of source extraction.'
)
COMMENT = 'This table contains the facts related to item_1 rating elements.'
AS SELECT
   nfpo_src_item_rating_nr
  ,nfpo_src_item_rating_element_nr
  ,nfpo_cx_info_provider_nr
  ,nfpo_item_rating_element_sid
  ,nfpo_item_rating_sid
  ,nfpo_item_sid
  ,nfpo_org_sid
  ,nfpo_item_rating_dt
  ,nfpo_rating_bias_type_cd
  ,nfpo_item_rating_element_txt
  ,nfpo_keyword_unigram_list_txt
  ,nfpo_item_rating_element_sentiment_score_meas
  ,dwh_created_tmsp
  ,dwh_updated_tmsp
  ,dwh_src_tmsp
FROM CORE.T_FACT_NFPO_ITEM_RATING_ELEMENT_1
;