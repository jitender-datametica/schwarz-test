/* --------------------------------------------------------------------------------
   DDL for table: t_customer_experience_information_provider_1
   generated from Powerdesigner on Montag, 18. November 2024 15:04:28
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_customer_experience_information_provider_1 (
cx_info_provider_nr STRING(100) NOT NULL
OPTIONS(description='Identifier of the provider or collector of the customer experience information.'),
cx_info_provider_descr STRING(250)
OPTIONS(description='Description of the provider or collector of the customer experience information.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (cx_info_provider_nr) NOT ENFORCED
)
OPTIONS(description='This table contains the data providers for customer experience data. This can be a platform operator (Google, etc.) a market rearch company, or the retailer itself.');