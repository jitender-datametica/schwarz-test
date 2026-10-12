/* --------------------------------------------------------------------------------
   DDL for table: t_customer_experience_information_provider
   generated from Powerdesigner on Montag, 18. November 2024 15:04:28
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_CUSTOMER_EXPERIENCE_INFORMATION_PROVIDER (
   cx_info_provider_nr                 VARCHAR(100)     NOT NULL COMMENT 'Identifier of the provider or collector of the customer experience information.',
   cx_info_provider_descr              VARCHAR(250)     COMMENT 'Description of the provider or collector of the customer experience information.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_CUSTOMER_EXPERIENCE_INFORMATION_PROVIDER PRIMARY KEY (cx_info_provider_nr) NOT ENFORCED 
)  COMMENT = 'This table contains the data providers for customer experience data. This can be a platform operator (Google, etc.) a market rearch company, or the retailer itself.';
