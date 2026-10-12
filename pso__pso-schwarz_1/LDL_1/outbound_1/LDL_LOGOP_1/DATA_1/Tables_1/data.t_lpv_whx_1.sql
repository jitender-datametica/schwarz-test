/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_lpv_whx_1
Description		|	LPV source table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_lpv_whx_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_1 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_1 code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse ID. Subset of Warehouse Number (lagernummer)'),
location_id STRING(11) NOT NULL OPTIONS(description='Internal location_1 number. Primary key. Original name - ORT'),
location_name STRING(20) OPTIONS(description='Location_1 label. Original name - BEZ'),
length BIGNUMERIC(38,0) OPTIONS(description='Location_1 length in cm. Original name - LAENGE'),
width BIGNUMERIC(38,0) OPTIONS(description='Location_1 width in cm. Original name - BREITE'),
height BIGNUMERIC(38,0) OPTIONS(description='Location_1 height in cm. Original name - HOEHE'),
area_nr BIGNUMERIC(38,0)
OPTIONS(description='Number of the area the stock is currently located in. FK: References LPV.BEREICH.NR. Original name - BEREICH'),
block_cd STRING(1)
OPTIONS(description='Whether the location_1 is currently locked. V = No block. S = Blocked. Original name - SPERRE'),
capacity BIGNUMERIC(38,0) OPTIONS(description='Location_1 capacity. Original name - PLATZ'),
capacity_available BIGNUMERIC(38,0) OPTIONS(description='Free location_1 capacity. Original name - PLATZ_V'),
max_weight BIGNUMERIC(38,0)
OPTIONS(description='Maximum weight in kg. The number is multiplied with 1000. Original name - MAXGEW'),
picking_indicator BIGNUMERIC(38,0)
OPTIONS(description='Indicator whether the location_1 is assigned to an article as a picking laction (table LPV.ASTBER). Original name - FIXPLATZ'),
v1_attribute BIGNUMERIC(38,0) OPTIONS(description='Article attribute. Original name - V1'),
v3_location_type BIGNUMERIC(38,0) OPTIONS(description='Storage location_1 type. Original name - V3'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_id, location_id, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='LPV - This table saves storage locations including gates and special locations like terminals.');