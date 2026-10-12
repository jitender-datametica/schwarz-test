CREATE TABLE DATA.t_ewmps_lazk_2 (
client_id 					NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country_2 code',
lidl_country 				VARCHAR(3) 		NOT NULL 	COMMENT 'Country_2 code. Original field name bic_zmlila',
wh_id 						NUMBER(38,0) 	NOT NULL	COMMENT 'Warehouse ID. Subset of Warehouse Number (lgnum)',
mandt 						VARCHAR(3) 		NULL 		COMMENT 'Client',
lgnum 						VARCHAR(5) 		NOT NULL	COMMENT 'Warehouse Number/Warehouse Complex',
lazid_laznr					VARCHAR(5)		NOT NULL 	COMMENT 'Warehouse area',
lazbez             			VARCHAR(200)    NULL 	 	COMMENT 'Warehouse area description.',
dwh_load_id 				NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
dwh_created 				TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
dwh_updated 				TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
dwh_valid_from 				DATE 			NOT NULL 	COMMENT 'Valid from date',
dwh_valid_to 				DATE 			NOT NULL 	COMMENT 'Valid to date',
deleted_fg 					BOOLEAN 		NOT NULL 	COMMENT 'Flag if record is deleted',
PRIMARY KEY (client_id, wh_id, lazid_laznr, dwh_valid_from)
) COMMENT = 'SAP EWM PS - Warehouse area HEAD';