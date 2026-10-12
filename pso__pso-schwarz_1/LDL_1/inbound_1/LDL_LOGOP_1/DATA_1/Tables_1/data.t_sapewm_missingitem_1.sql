/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_sapewm_missingitem_1
Description		|	SAP EWM - source table
====================================================================================================
*/

CREATE TABLE DATA.t_sapewm_missingitem_1 (
client_id 				NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country_1 code', 
lidl_country 			VARCHAR(3) 		NOT NULL 	COMMENT 'Country_1 code. Original field name bic_zmlila', 
wh_id					NUMBER(38,0)	NOT NULL 	COMMENT 'Warehouse ID. Subset of Warehouse Number',
mandt					VARCHAR(3)		NULL 	 	COMMENT 'Client',
zz_mi_no                VARCHAR(10)     NOT NULL 	COMMENT 'Missing item_1 number',
matnr                   VARCHAR(40)     NULL 		COMMENT 'Product',
lgnum                   VARCHAR(4)      NOT NULL 	COMMENT 'Warehouse Number/Warehouse Complex',
avlgrp                  VARCHAR(10)     NULL 	 	COMMENT 'Availability Group',
entitled                VARCHAR(10)     NULL 	 	COMMENT 'Party Entitled to Dispose',
zz_mi_status            VARCHAR(1)      NULL 	 	COMMENT 'Missing item_1 status_1',
zz_mi_status_cp         VARCHAR(1)      NULL 	 	COMMENT 'Missing item_1 status_1 cartonization planning',
zzernam                 VARCHAR(12)     NULL 	 	COMMENT 'Name of person who created the object',
zzerdat                 DATE            NULL 		COMMENT 'Date on which record was created',
zzerzet                 TIME(0)         NULL 		COMMENT 'Entry Time',
zzaenam                 VARCHAR(12)     NULL 	 	COMMENT 'Name of person who changed object',
zzaedat                 DATE            NULL 	 	COMMENT 'Changed On',
zzaezet                 TIME(0)         NULL 	 	COMMENT 'Time last change was made',
mi_reason               VARCHAR(2)      NULL 	 	COMMENT 'Missing Item_1 Reason',
mi_ernam                VARCHAR(12)     NULL 	 	COMMENT 'Reason Created by',
mi_erdat                DATE            NULL 	 	COMMENT 'Reason Created at',
mierzeit                TIME(0)         NULL 	 	COMMENT 'Reason Created on',
egr_date                DATE            NULL 	 	COMMENT 'Expected Goods Receipt Date',
egr_date_ernam          VARCHAR(12)     NULL 	 	COMMENT 'EGR Date Created by',
egr_date_erdat          DATE            NULL 	 	COMMENT 'EGR Date Created at',
egr_date_erzeit         TIME(0)         NULL 	 	COMMENT 'EGR Date Created on',
product_text			VARCHAR(40)		NULL		COMMENT 'Retrieving data. Wait a few seconds and try to cut or copy again.',
dwh_load_id 			NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
dwh_created				TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
dwh_updated				TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
PRIMARY KEY (client_id, lgnum, zz_mi_no)
) COMMENT = 'SAP EWM - Missing Items';