/* --------------------------------------------------------------------------------
   DDL for table: t_nfpo_item_rating_element_1
   generated from Powerdesigner on Dienstag, 24. Oktober 2023 10:35:45
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_item_rating_element_1 (
nfpo_item_rating_element_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key for rating element of an item_1            LDL: p_lew_core.item_rating_element.item_rating_element_sid'),
nfpo_cx_info_provider_nr STRING(100) NOT NULL
OPTIONS(description='Identifier of the provider or collector of the customer experience information.            LDL: p_lew_core.t_item_rating_element.cx_info_provider_nr'),
nfpo_src_item_rating_element_nr STRING(100) NOT NULL
OPTIONS(description='Identifier of the item_1 rating element in the system of the data provider.            LDL: p_lew_core.t_item_rating_element.src_item_rating_element_nr'),
nfpo_item_rating_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key for rating of an item_1            LDL: p_lew_core.item_rating_element.item_rating_sid'),
nfpo_item_rating_element_txt STRING(16000)
OPTIONS(description='Text element given in the rating by the rater translated into English.            LDL: p_lew_core.t_item_rating_element.item_rating_element_txt'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.            LDL: LDL: p_lew_core.t_item_rating_element.DWH_CREATED'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.            LDL: LDL: p_lew_core.t_item_rating_element.DWH_UPDATED'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_item_rating_element_sid) NOT ENFORCED
)
OPTIONS(description='This table contains elements ( for example individual sentences of a rating comment) of item_1 ratings by real or potential customers giving their opinion about Lidl.             These ratings are provided by certain sevice providers (Predict, Medallia, Google, ...) and are available for both Lidl Stationary and Lidl Digital articles.             LDL: p_lew_core.t_item_rating_element_1');