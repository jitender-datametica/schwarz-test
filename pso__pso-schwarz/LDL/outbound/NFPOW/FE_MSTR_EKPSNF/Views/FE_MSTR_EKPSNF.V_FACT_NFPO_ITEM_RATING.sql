CREATE OR REPLACE VIEW nfpow_fe_mstr_ekpsnf.v_fact_nfpo_item_rating (nfpo_src_item_rating_nr
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
nfpo_cx_info_provider_nr
OPTIONS(description='''Identifier of the provider or collector of the customer experience information - Manually filled
			LDL: p_lew_core.t_item_rating.cx_info_provider_nr
			CORE_REL:t_nfpo_item_rating.nfpo_cx_info_provider_nr'''),
nfpo_item_rating_sid
OPTIONS(description='''Surrogate Key for rating of an item
			SALESFORCE: salesforce_comment.case_number and cx_info_provider_nr
			ONLINE SHOP:online_shop_comment.comment_id and cx_info_provider_nr
			LDL:t_item_rating.item_rating_sid
			CORE_REL:t_nfpo_item_rating.nfpo_item_rating_sid'''),
nfpo_item_sid
OPTIONS(description='''Surrogate Key NFPO ITEM INSTANCE.
			CBX: CNT_ITEM.REF_NO
			LDL: P_LEW_CORE.T_MDM_ITEM.MDM_ITEM_SID
			CORE_REL:t_nfpo_item_rating.ldl_item_ian_nr'''),
nfpo_org_sid
OPTIONS(description='''Surrogate key internal organization.
			CBX:
			LDL: P_LEW_CORE.T_INTERNAL_ORGANISATION.INT_ORG_SID
			CORE_REL:t_nfpo_item_rating.nfpo_org_sid'''),
nfpo_item_rating_dt
OPTIONS(description='''Date of the item rating event.
			SALESFORCE: salesforce_comment.created_date
			ONLINE SHOP:online_shop_comment.review_date
			LDL: p_lew_core.t_item_rating.item_rating_dt
			CORE_REL:t_nfpo_item_rating.nfpo_item_rating_dt'''),
nfpo_rating_bias_type_cd
OPTIONS(description='''The bias code of the rating derived from nfpo_cx_info_provider_nr: "Complaint" if SF_Google or "Unbiased" if LDI_Google
			LDL: p_lew_core.t_item_rating.cx_info_provider_nr
			CORE_REL:t_nfpo_item_rating.nfpo_cx_info_provider_nr'''),
nfpo_item_rating_txt
OPTIONS(description='''Text given in the rating by the rater translated into English.
			ONLINE SHOP:online_shop_comment.comment
			LDL: p_lew_core.t_item_rating.item_rating_txt
			CORE_REL:t_nfpo_item_rating.nfpo_item_rating_txt'''),
nfpo_keyword_unigram_list_txt
OPTIONS(description='''List of words used in the rating comment and has been identified as key word
			SALESFORCE: salesforce_word_types.word
			ONLINE SHOP:online_shop_word_types.word
			LDL:p_lew_core.t_item_rating_element_keyword.keyword_unigram_txt
			CORE_REL:t_nfpo_item_rating_element_keyword.nfpo_keyword_unigram_txt'''),
nfpo_item_star_score_meas
OPTIONS(description='''Value of the calculated rating score for common star score (1-5)
			SALESFORCE: salesforce_comment.description_sentiment/number_words
			ONLINESHOP:online_shop_comment.comment_sentiment/number_words/rating
			LDL:p_lew_core.t_item_rating_score.rating_score_meas
			CORE_REL:t_nfpo_item_rating_score.nfpo_rating_score_meas'''),
nfpo_item_sentiment_score_meas
OPTIONS(description='''Value of the calculated rating score for sentiment
			SALESFORCE:salesforce_comment.description_sentiment/ number_words
			ONLINESHOP:online_shop_comment.comment_sentiment/number_words/rating
			LDL:p_lew_core.t_item_rating_score.rating_score_meas
			CORE_REL:t_nfpo_item_rating_score.nfpo_rating_score_meas'''),
dwh_created_tmsp OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp OPTIONS(description='Timestamp of the last change to the data record in the DWH.'), dwh_src_tmsp
OPTIONS(description='Timestamp of source extraction.'))
OPTIONS(description = 'this table contains the facts related to single item ratings') 
AS SELECT *
FROM nfpow_core.t_fact_nfpo_item_rating;