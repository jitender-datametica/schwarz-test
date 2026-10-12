/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_wawi_xwh_stock_2
Description		|	WAWI table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_wawi_xwh_stock_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_2 code'),
wawi_instanz_kzl STRING(3) NOT NULL OPTIONS(description='Country_2 code'),
wh_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse number'),
idvalue BIGNUMERIC(38,10) NOT NULL OPTIONS(description=''),
dayenddate DATETIME OPTIONS(description=''),
whnum BIGNUMERIC(38,0) OPTIONS(description=''),
itemnr STRING(18) OPTIONS(description=''),
mhddate DATETIME OPTIONS(description=''),
cases BIGNUMERIC(38,0) OPTIONS(description=''),
pallets BIGNUMERIC(38,0) OPTIONS(description=''),
slotnr BIGNUMERIC(38,0) OPTIONS(description=''),
groupnr BIGNUMERIC(38,0) OPTIONS(description=''),
artgroupnr BIGNUMERIC(38,0) OPTIONS(description=''),
scn BIGNUMERIC(38,0) OPTIONS(description=''),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_nr, idvalue, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='WAWI - WHWAWIADM.WHWAWIADM.T1356_XWH_STOCK_2 table');