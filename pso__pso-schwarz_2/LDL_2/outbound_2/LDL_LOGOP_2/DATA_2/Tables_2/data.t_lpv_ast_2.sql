/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_lpv_ast_2
Description		|	LPV source table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_lpv_ast_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_2 code'),
lidl_country STRING(4) NOT NULL OPTIONS(description='Country_2 code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source_system: LPV'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse ID. Subset of Warehouse Number (lagernummer)'),
article_nr STRING(20) NOT NULL OPTIONS(description='Article number. PK. Original name - ANR'),
article_descr STRING(50) OPTIONS(description='Article name. Original name - KTXT'),
article_unit_name STRING(10) OPTIONS(description='Artcile unit_2 name. Original name - UNIT_2'),
abc_id STRING(1) OPTIONS(description='ABC indicator. Original name - ABC'),
bbd_obligation_id BIGNUMERIC(38,0) OPTIONS(description='BBD obligation indicator. Original name - ERFASSE_MHD'),
weight_qty BIGNUMERIC(38,0) OPTIONS(description='Weight of one unit_2 in gram. Original name - GEWICHT'),
quantity_unit2 BIGNUMERIC(38,0)
OPTIONS(description='Number of units for each packaging unit_2 2. Original name - ANZAHL_VPE2'),
name_unit2 STRING(10) OPTIONS(description='Name of packaging unit_2 2. Original name - NAME_VPE2'),
batch_obligation_id BIGNUMERIC(38,0) OPTIONS(description='Batch oligation indicator. Original name - CHARGENPFLICHTIG'),
v1_attribute BIGNUMERIC(38,0)
OPTIONS(description='Article attribute. Must be stored on a storage location_2 with matching WHX.V1. Original name - V1'),
v2_item_group BIGNUMERIC(38,0) OPTIONS(description='Item_2 group. Original name - V2'),
v3_article_family BIGNUMERIC(38,0) OPTIONS(description='Article family. Original name - V3'),
v4_rlz BIGNUMERIC(38,0) OPTIONS(description='Minimum days before the BBD is reached (Restlaufzeit). Original name - V4'),
fefo_tolerance BIGNUMERIC(38,0)
OPTIONS(description='Configured FEFO tolerance in percentage. Original name - FEFOTOLERANZ'),
fifo_tolerance BIGNUMERIC(38,0)
OPTIONS(description='Configured FIFO tolerance in percentage. Original name - FIFOTOLERANZ'),
country_of_origin STRING(3) OPTIONS(description='Country_2 of origin. Original name - URSPRUNGSLAND'),
creation_tmsp DATETIME OPTIONS(description='Time of record creation. Original name - ANLAGEZEIT'),
change_tmsp DATETIME OPTIONS(description='Time of last record change. Original name - HOSTAENDERUNGSZEIT'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_id, article_nr, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='LPV - This table saves article master data, that is communicated from the WaWi via WMI.');