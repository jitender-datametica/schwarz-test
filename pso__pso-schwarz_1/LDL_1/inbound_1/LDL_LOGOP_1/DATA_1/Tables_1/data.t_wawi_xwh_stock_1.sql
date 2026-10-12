/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_wawi_xwh_stock_1
Description		|	WAWI table
====================================================================================================
*/

CREATE TABLE DATA.t_wawi_xwh_stock_1 (
client_id 			NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country_1 code',
wawi_instanz_kzl 	VARCHAR(3) 		NOT NULL	COMMENT 'Country_1 code',
wh_nr 				NUMBER(38,0) 	NOT NULL 	COMMENT 'Warehouse number',
idvalue 			NUMBER(38,10) 	NOT NULL	COMMENT '',
dayenddate 			TIMESTAMP 		NULL		COMMENT '',
whnum 				NUMBER(38,0)	NULL		COMMENT '',
itemnr 				VARCHAR(18)		NULL		COMMENT '',
mhddate 			TIMESTAMP		NULL		COMMENT '',
cases 				NUMBER(38,0)	NULL		COMMENT '',
pallets 			NUMBER(38,0)	NULL		COMMENT '',
slotnr 				NUMBER(38,0)	NULL		COMMENT '',
groupnr 			NUMBER(38,0)	NULL		COMMENT '',
artgroupnr 			NUMBER(38,0)	NULL		COMMENT '',
scn 				NUMBER(38,0)	NULL		COMMENT '',
dwh_load_id 		NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
dwh_created 		TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
dwh_updated 		TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
dwh_valid_from 		DATE 			NOT NULL 	COMMENT 'Valid from date',
dwh_valid_to 		DATE 			NOT NULL 	COMMENT 'Valid to date',
deleted_fg 			BOOLEAN 		NOT NULL 	COMMENT 'Flag if record is deleted',
PRIMARY KEY (client_id, wh_nr, idvalue, dwh_valid_from)
) COMMENT = 'WAWI - WHWAWIADM.WHWAWIADM.T1356_XWH_STOCK_1 table';