/* --------------------------------------------------------------------------------
   DDL for table: t_nfpo_item_rating_element_keyword
   generated from Powerdesigner on Dienstag, 24. Oktober 2023 10:36:11
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_item_rating_element_keyword (
nfpo_item_rating_element_keyword_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='surrogate identifier for the nfpo item rating element keyword record. the same keyword can be used multiple times in a sentence in similar context.            LDL: p_lew_core.item_rating_element_keyword.item_rating_element_keyword_sid'),
nfpo_cx_info_provider_nr STRING(100) NOT NULL
OPTIONS(description='Identifier of the provider or collector of the customer experience information.            LDL: p_lew_core.t_item_rating_element_keyword.cx_info_provider_nr'),
nfpo_item_rating_element_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key for rating element of an item            LDL: p_lew_core.item_rating_element_keyword.item_rating_element_sid'),
nfpo_src_item_rating_element_nr STRING(100) NOT NULL
OPTIONS(description='Identifier of the item rating element in the system of the data provider.            LDL: p_lew_core.t_item_rating_element_keyword.src_item_rating_element_nr'),
nfpo_rating_keyword_type_cd STRING(100) NOT NULL
OPTIONS(description='Code for the discriminator values for keyword types used in nfpo rating.            LDL: p_lew_core.t_ref_item_rating_element_keyword.item_rating_keyword_type_cd'),
nfpo_keyword_unigram_txt STRING(1000) NOT NULL
OPTIONS(description='A word that is used in the rating comment and has been identified as key word            LDL: p_lew_core.t_item_rating_element_keyword.keyword_unigram_txt'),
nfpo_keyword_bigram_txt STRING(1000)
OPTIONS(description='A 2 word combinaton consisting of the keyword and related significant word that is used in rating            LDL: p_lew_core.t_item_rating_element_keyword.keyword_bigram_txt'),
nfpo_keyword_trigram_txt STRING(1000)
OPTIONS(description='A 3 words combinaton from target word and related significant words that is used in rating            LDL: p_lew_core.t_item_rating_element_keyword.keyword_trigram_txt'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.            LDL: p_lew_core.t_item_rating_element_keyword.DWH_CREATED'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.            LDL: p_lew_core.t_item_rating_element_keyword.DWH_UPDATED'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_item_rating_element_keyword_sid) NOT ENFORCED
)
OPTIONS(description='This table contains the keywords related to item rating elements.             LDL: p_lew_core.t_item_rating_element_keyword');