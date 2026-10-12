CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_customer_experience_information_provider_2 (cx_info_provider_nr
OPTIONS(description='Identifier of the provider or collector of the customer experience information.'),
cx_info_provider_descr
OPTIONS(description='Description of the provider or collector of the customer experience information.'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `THIS TABLE CONTAINS THE DATA PROVIDERS FOR CUSTOMER EXPERIENCE DATA. THIS CAN BE A PLATFORM OPERATOR (GOOGLE, ETC.) A MARKET REARCH COMPANY, OR THE RETAILER ITSELF.`)
AS SELECT cx_info_provider_nr,
 cx_info_provider_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_customer_experience_information_provider_2;