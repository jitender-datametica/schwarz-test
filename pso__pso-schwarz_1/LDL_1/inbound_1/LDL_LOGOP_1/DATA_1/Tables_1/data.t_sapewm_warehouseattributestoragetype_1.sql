/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_sapewm_warehouseattributestoragetype_1
Description		|	SAP EWM - source table
====================================================================================================
*/

CREATE TABLE DATA.t_sapewm_warehouseattributestoragetype_1 (
	client_id 					NUMBER(38,0) 		NOT NULL 		COMMENT 'Client id - calculated based on the country_1 code', 
	lidl_country 				VARCHAR(3) 			NOT NULL 		COMMENT 'Country_1 code. Original field name bic_zmlila', 
	source_system 				VARCHAR(30) 		NOT NULL 		COMMENT 'Source system',
	wh_id						NUMBER(38,0)		NOT NULL 		COMMENT 'Warehouse ID. Subset of Warehouse Number',
	lgnum                       VARCHAR(5)          NOT NULL        COMMENT 'Client of the EWM system',
	matid                       VARCHAR(22)         NULL            COMMENT 'Warehouse Number/Warehouse Complex',
	matnr                       VARCHAR(40)         NOT NULL        COMMENT 'Product',
	entitled                    VARCHAR(10)         NOT NULL        COMMENT 'Party Entitled to Dispose',
	lgtyp                       VARCHAR(4)          NOT NULL        COMMENT 'Storage Type',
	sectind                     VARCHAR(4)          NULL            COMMENT 'Storage Section Indicator',
	sectind_fix                 BOOLEAN             NULL            COMMENT 'Preferred Storage Section Indicator: Fixed',
	sectind_plan                VARCHAR(4)          NULL            COMMENT 'Planned Storage Section Indicator',
	bintype                     VARCHAR(4)          NULL            COMMENT 'Storage Bin Type',
	bintype_fix                 BOOLEAN             NULL            COMMENT 'Preferred Storage Bin Type Fixed',
	bintype_plan                VARCHAR(4)          NULL            COMMENT 'Planned Storage Bin Type',
	maxfixbin                   NUMBER(38,0)        NULL            COMMENT 'Maximum No. of Bins',
	maxfixbin_fix               BOOLEAN             NULL            COMMENT 'Maximum Number of Fixed Bins: Fixed',
	maxfixbin_plan              NUMBER(38,0)        NULL            COMMENT 'Planned Maximum Number of Bins',
	binsrch                     VARCHAR(1)          NULL            COMMENT 'Sort Rule for Empty Storage Bin Search',
	splitth                     NUMBER(38,2)        NULL            COMMENT 'Putaway Threshold Addition (in Percent of Storage Bin)',
	splitput                    BOOLEAN             NULL            COMMENT 'Split During Putaway',
	norpln                      BOOLEAN             NULL            COMMENT 'No Replenishment',
	repqty                      NUMBER(38,3)        NULL            COMMENT 'Minimum Replenishment Quantity',
	repqty_uom_dsp              VARCHAR(3)          NULL            COMMENT 'Display Unit_1 of Measure for Replenishment Quantity',
	repqty_plan                 NUMBER(38,3)        NULL            COMMENT 'Planned Minimum Replenishment Quantity',
	minqty                      NUMBER(38,3)        NULL            COMMENT 'Minimum Quantity',
	minqty_uom_dsp              VARCHAR(3)          NULL            COMMENT 'Display Unit_1 of Measure for Minimum Quantity',
	minqty_plan                 NUMBER(38,3)        NULL            COMMENT 'Planned Minimum Quantity in Storage Type',
	maxqty                      NUMBER(38,3)        NULL            COMMENT 'Maximum Quantity',
	maxqty_uom_dsp              VARCHAR(3)          NULL            COMMENT 'Display Unit_1 of Measure for Maximum Quantity',
	maxqty_plan                 NUMBER(38,3)        NULL            COMMENT 'Planned Maximum Quantity in Storage Type',
	rmmqty_fix                  BOOLEAN             NULL            COMMENT 'Minimum/Maximum/Replenishment Quantity Fixed',
	permxqty                    NUMBER(38,2)        NULL            COMMENT 'Minimum Quantity as Percentage of Maximum Quantity',
	quancla                     VARCHAR(1)          NULL            COMMENT 'Quantity Classification in Warehouse',
	quanclaput                  VARCHAR(1)          NULL            COMMENT 'Putaway Quantity Classification',
	seqput                      VARCHAR(2)          NULL            COMMENT 'Putaway Sequence',
	seqput_fix                  BOOLEAN             NULL            COMMENT 'Sequence of Putaway Fixed',
	seqput_plan                 VARCHAR(2)          NULL            COMMENT 'Planned Putaway Sequence',
	skipptw                     BOOLEAN             NULL            COMMENT 'Skip During Putaway',
	skipptw_fix                 BOOLEAN             NULL            COMMENT 'Skip in Putaway Fixed',
	skipptw_plan                BOOLEAN             NULL            COMMENT 'Planned Skip During Putaway',
	meins                       VARCHAR(3)          NULL            COMMENT 'Base Unit_1 of Measure',
	no_whstdata                 VARCHAR(1)          NULL            COMMENT 'Product Has No Storage Type Warehouse Data View',
	whst_data_exists            VARCHAR(8)          NULL            COMMENT 'Storage Type Warehouse Data Exists',
	mtart                       VARCHAR(4)          NULL            COMMENT 'Material Type',
	mmsta                       VARCHAR(2)          NULL            COMMENT 'Plant-Specific Material Status_1',
	dummy_whst_incl_eew_ps      VARCHAR(1)          NULL            COMMENT 'Dummy_1 Field for Enhancement Fields',
	z_ptwy_max_qty              NUMBER(38,3)        NULL            COMMENT 'EEW: LIDL PTWY Max. Quantity',
	zz_ptwy_max_0001            VARCHAR(3)          NULL            COMMENT 'Ref field for Quantity in EEW',
	dwh_load_id    				NUMBER(38,0) 		NOT NULL 		COMMENT 'Load id',
	dwh_created    				TIMESTAMP 			NOT NULL 		COMMENT 'Record created at',
	dwh_updated    				TIMESTAMP 			NOT NULL 		COMMENT 'Record updated at',
	dwh_valid_from 				DATE 				NOT NULL 		COMMENT 'Valid from date',
	dwh_valid_to   				DATE 				NOT NULL 		COMMENT 'Valid to date',
	deleted_fg     				BOOLEAN 			NOT NULL 		COMMENT 'Flag if record is deleted',
	PRIMARY KEY (client_id, lgnum, matnr, lgtyp, entitled, dwh_valid_from)
) COMMENT = 'SAP EWM - Product storage type attributes'
;