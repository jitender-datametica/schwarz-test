CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_CUSTOMER_EXPERIENCE_INFORMATION_PROVIDER_1 (
   cx_info_provider_nr                      COMMENT 'Identifier of the provider or collector of the customer experience information.'
  ,cx_info_provider_descr                   COMMENT 'Description of the provider or collector of the customer experience information.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'This table contains the data providers for customer experience data. This can be a platform operator (Google, etc.) a market rearch company, or the retailer itself.'
AS SELECT
   cx_info_provider_nr
  ,cx_info_provider_descr
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_CUSTOMER_EXPERIENCE_INFORMATION_PROVIDER_1
;