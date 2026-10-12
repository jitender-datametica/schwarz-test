/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_lpv_lhm_1
Description		|	LPV source table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_lpv_lhm_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_1 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_1 code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse ID. Subset of Warehouse Number (lagernummer)'),
location_id STRING(11)
OPTIONS(description='Internal location_1 ID of the pallets current location. FK: Referencing LPV.WHX.ORT. Original name - ORT'),
pallet_nr STRING(30) NOT NULL OPTIONS(description='Pallet number. Primary key. Original name - LHMNR'),
height BIGNUMERIC(38,0) OPTIONS(description='Height of the pallet in mm. Original name - HOEHE'),
pallet_type BIGNUMERIC(38,0) OPTIONS(description='Pallet type. Original name - STELLTYP'),
article_nr STRING(20) OPTIONS(description='Article number. FK: References LPV.AST.ANR. Original name - ANR'),
status_cd STRING(1) OPTIONS(description='Availability status. Original name - STATUS_1'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_id, pallet_nr, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='LPV - This table saves pallet information.');