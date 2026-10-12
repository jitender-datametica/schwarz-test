/* --------------------------------------------------------------------------------
   DDL for table: t_location_organization_hist
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:14 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_location_organization_hist (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Niederlassung; FK auf LOCATION'),
loc_sid_exp BIGNUMERIC(38,0) NOT NULL OPTIONS(description='?'),
sales_manager_id BIGNUMERIC(38,0) OPTIONS(description='Sales-Manager - ID; WAWI: sales_manager_id'),
sales_manager_name STRING(100) COLLATE 'und:ci' OPTIONS(description='Sales-Manager - Name; WAWI: sales_manager_name'),
account_manager_id BIGNUMERIC(38,0) OPTIONS(description='Account-Manager - ID; WAWI: account_manager_id'),
account_manager_name STRING(100) COLLATE 'und:ci'
OPTIONS(description='Account-Manager - Name; WAWI: sales_manager_name'),
store_manager_id BIGNUMERIC(38,0) OPTIONS(description='Store-Manager - ID; WAWI: store_manager_id'),
store_manager_name STRING(100) COLLATE 'und:ci' OPTIONS(description='Store-Manager - Name; WAWI: store_manager_name'),
general_manager_id BIGNUMERIC(38,0) OPTIONS(description='General-Manager - ID; WAWI: general_manager_id'),
general_manager_name STRING(100) OPTIONS(description='General-Manager - Name; WAWI: general_manager_name'),
organisation_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Organisation - ID; WAWI: organisation_id'),
district_cd STRING(300) OPTIONS(description='WAWI: district_id'),
active_from_dt DATE NOT NULL OPTIONS(description='WAWI: dat_valid_from'),
active_to_dt DATE NOT NULL OPTIONS(description='WAWI: dat_valid_to'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='attribute set was not delivered by source system (anymore), if deleted_fg=1'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='End of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (loc_sid, organisation_id, dwh_valid_from) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. LORGH; Organisationsstruktur aus dem WaWi (keine aktuelle SAP-Schnittstelle vorhanden);             WAWI: t_org_salesorg');