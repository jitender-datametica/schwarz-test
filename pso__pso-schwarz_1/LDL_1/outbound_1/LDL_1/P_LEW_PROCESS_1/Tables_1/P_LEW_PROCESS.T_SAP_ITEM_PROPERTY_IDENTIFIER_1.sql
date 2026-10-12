CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_sap_item_property_identifier_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
identifier_id BIGNUMERIC(38,0) NOT NULL,
identifier_name STRING(50) COLLATE 'und:ci' NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME,
dwh_updated DATETIME
);