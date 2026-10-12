/* --------------------------------------------------------------------------------
   DDL for table: t_nfpo_item_rating_2
   generated from Powerdesigner on Dienstag, 24. Oktober 2023 10:32:50
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_item_rating_2 (
nfpo_item_rating_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key for rating of an item_2            LDL: p_lew_core.item_rating.item_rating_sid'),
nfpo_cx_info_provider_nr STRING(100) NOT NULL
OPTIONS(description='Identifier of the provider or collector of the customer experience information.            LDL: p_lew_core.t_item_rating.cx_info_provider_nr'),
nfpo_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate key internal organization.            LDL: P_LEW_CORE.Tt_item_rating.INT_ORG_SID'),
nfpo_src_item_rating_nr STRING(100) NOT NULL
OPTIONS(description='Identifier of the item_2 rating event in the system of the data provider.            LDL: p_lew_core.t_item_rating.src_item_rating_nr'),
ldl_item_ian_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Lidl International Item_2 Number            LDL: p_lew_core.t_item_rating.item_ian_nr'),
nfpo_item_rating_dt DATE NOT NULL
OPTIONS(description='Date of the item_2 rating event.            LDL: p_lew_core.t_item_rating.item_rating_dt'),
nfpo_item_rating_txt STRING(16000)
OPTIONS(description='Text given in the rating by the rater translated into English.            LDL: p_lew_core.t_item_rating.item_rating_txt'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.            LDL: LDL: p_lew_core.t_item_rating.DWH_CREATED'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.            LDL: LDL: p_lew_core.t_item_rating.DWH_UPDATED'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_item_rating_sid) NOT ENFORCED
)
OPTIONS(description='This table contains items ratings by real or potential customers giving their opinion about non food products of Lidl.             These ratings are provided by certain sevice providers (Predict, Medallia, Google, ...) and are available for both Lidl Stationary and Lidl Digital articles.             LDL: p_lew_core.t_item_rating_2');