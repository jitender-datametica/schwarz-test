/* --------------------------------------------------------------------------------
   DDL for table: t_nfpo_rating_keyword_type
   generated from Powerdesigner on Dienstag, 24. Oktober 2023 10:32:12
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_rating_keyword_type (
nfpo_rating_keyword_type_cd STRING(100) NOT NULL
OPTIONS(description='Code for the discriminator values for keyword types used in nfpo rating.            LDL: p_lew_core.t_ref_item_rating_keyword_type.item_rating_keyword_type_cd'),
nfpo_rating_keyword_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the discriminator value for keyword types used in nfpo item rating.            LDL: p_lew_core.t_ref_item_rating_keyword_type.item_keyword_type_descr'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.            LDL: LDL: p_lew_core.t_customer_experience_information_provider.DWH_CREATED'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.            LDL: LDL: p_lew_core.t_customer_experience_information_provider.DWH_UPDATED'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_rating_keyword_type_cd) NOT ENFORCED
)
OPTIONS(description='This table contains the data providers for customer experience data. This can be a platform operator (Google, etc.) a market rearch company, or the retailer itself.             LDL: p_lew_core.t_ref_item_rating_keyword_type');