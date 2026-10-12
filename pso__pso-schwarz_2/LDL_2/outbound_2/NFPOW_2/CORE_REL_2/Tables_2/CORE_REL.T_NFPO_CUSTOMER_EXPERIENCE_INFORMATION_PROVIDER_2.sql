/* --------------------------------------------------------------------------------
   DDL for table: t_nfpo_customer_experience_information_provider_2
   generated from Powerdesigner on Dienstag, 24. Oktober 2023 10:36:38
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_customer_experience_information_provider_2 (
nfpo_cx_info_provider_nr STRING(100) NOT NULL
OPTIONS(description='Identifier of the provider or collector of the customer experience information.            LDL: p_lew_core.t_customer_experience_information_provider.cx_info_provider_nr'),
nfpo_cx_info_provider_descr STRING(250)
OPTIONS(description='Description of the provider or collector of the customer experience information.            LDL: p_lew_core.t_customer_experience_information_provider.cx_info_provider_descr'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.            LDL: LDL: p_lew_core.t_customer_experience_information_provider.DWH_CREATED'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.            LDL: LDL: p_lew_core.t_customer_experience_information_provider.DWH_UPDATED'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_cx_info_provider_nr) NOT ENFORCED
)
OPTIONS(description='This table contains the data providers for customer experience data. This can be a platform operator (Google, etc.) a market rearch company, or the retailer itself.             LDL: p_lew_core.t_customer_experience_information_provider_2');