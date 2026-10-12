/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_lpv_astber
Description		|	LPV source table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_lpv_astber (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse ID. Subset of Warehouse Number (lagernummer)'),
article_nr STRING(20) NOT NULL OPTIONS(description='Article number. FК: References LPV.AST.ANR. Original name - anr'),
area_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Number of the configured area. FК: References LPV.BEREICH.NR. Original name - bereich'),
fixbin_id STRING(11)
OPTIONS(description='Location that is set as the picking location (internal location ID). FК: References LPV.WHX.ORT. Original name - fixort1'),
change_tmsp DATETIME
OPTIONS(description='Time stamp of the record creation.19000101000000 if the record was created automatically in response to a WMI telegram. Original name - anlagezeit'),
creation_computer_id STRING(15)
OPTIONS(description='ID of the computer used to create the record. Empty if the record was created in response to a WMI telegram. Original name - anlagerechnerid'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_id, article_nr, area_nr, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='LPV - This table saves article picking locations for articles.');