/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_customer_experience_information_provider_2
   generated from Powerdesigner on Mittwoch, 24. Januar 2024 15:11:46
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_nfpo_customer_experience_information_provider_2 (
nfpo_cx_info_provider_nr STRING(100) NOT NULL
OPTIONS(description='Identifier of the provider or collector of the customer experience information.            LDL: p_lew_core.t_item_rating.cx_info_provider_nr'),
nfpo_cx_info_provider_descr STRING(250)
OPTIONS(description='Description of the provider or collector of the customer experience information.            LDL: p_lew_core.t_customer_experience_information_provider.cx_info_provider_descr'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.DWH_CREATED'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.DWH_UPDATED'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_cx_info_provider_nr) NOT ENFORCED
) OPTIONS(description='This table contains the list of customer experience information providers.');