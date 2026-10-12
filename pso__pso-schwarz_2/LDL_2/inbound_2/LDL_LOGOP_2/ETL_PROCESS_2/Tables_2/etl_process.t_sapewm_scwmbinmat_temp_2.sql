/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	etl_process
DB table		|	t_sapewm_scwmbinmat_temp_2
Description		|	SAP EWM - source table
====================================================================================================
*/

CREATE TABLE ETL_PROCESS.t_sapewm_scwmbinmat_temp_2 (
	client_id 			NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country_2 code', 
	lidl_country 		VARCHAR(3) 		NOT NULL 	COMMENT 'Country_2 code. Original field name bic_zmlila', 
	source_system 		VARCHAR(30) 	NOT NULL 	COMMENT 'Source system',
	wh_id				NUMBER(38,0)	NOT NULL 	COMMENT 'Warehouse ID. Subset of Warehouse Number',
	lgnum               VARCHAR(5)      NOT NULL    COMMENT 'Warehouse Number/Warehouse Complex',
	matid               VARCHAR(50)     NULL        COMMENT 'Product',
	entitled            VARCHAR(10)     NULL        COMMENT 'Party Entitled to Dispose',
	lgpla               VARCHAR(18)     NOT NULL    COMMENT 'Storage Bin',
	lgtyp               VARCHAR(4)      NULL        COMMENT 'Storage Type',
	outcon              VARCHAR(1)      NULL        COMMENT 'Storage Bin Improvable',
	datout              DATE            NULL        COMMENT 'Storage Bin Improvable Changed On',
	maxqty              NUMBER(38,3)    NULL        COMMENT 'Maximum Quantity',
	maxqty_uom_dsp      VARCHAR(3)      NULL        COMMENT 'Display Unit_2 of Measure for Maximum Quantity',
	minqty              NUMBER(38,3)    NULL        COMMENT 'Minimum Quantity',
	minqty_uom_dsp      VARCHAR(3)      NULL        COMMENT 'Display Unit_2 of Measure for Minimum Quantity',
	matnr               VARCHAR(40)     NOT NULL    COMMENT 'Product',
	rmmqty_fix          VARCHAR(1)      NULL        COMMENT 'Minimum/Maximum/Replenishment Quantity Fixed',
	created_at          TIMESTAMP       NULL        COMMENT 'Creation Time',
	created_by          VARCHAR(12)     NULL        COMMENT 'Created By',
	improv_fix          VARCHAR(1)      NULL        COMMENT 'Storage Bin Improvable Fixed',
	zz_campaign         VARCHAR(1)      NULL        COMMENT 'Campaign',
	zz_maxhufixbin      NUMBER(38,0)    NULL        COMMENT 'Maximal HUs in Fixbin',
	zz_reservefixbin    NUMBER(38,0)    NULL        COMMENT 'Reserve HUs for Fix bins',
	zz_acp_sqty         VARCHAR(1)      NULL        COMMENT 'ACP Small qty',
	dwh_load_id 		NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
	dwh_created			TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
	dwh_updated			TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
	PRIMARY KEY (client_id, lgnum, lgpla, matnr)
) COMMENT = 'SAP EWM - Assignment Table for Fixed Bins - Product'
;