/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	etl_process
DB table		|	t_sapewm_nfstoreevaluation_temp_2
Description		|	SAP EWM - source table
====================================================================================================
*/

CREATE TABLE ETL_PROCESS.t_sapewm_nfstoreevaluation_temp_2 (
	client_id 		    NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country_2 code', 
	lidl_country 	    VARCHAR(3) 		NOT NULL 	COMMENT 'Country_2 code. Original field name bic_zmlila', 
	source_system 	    VARCHAR(30) 	NOT NULL 	COMMENT 'Source system',
	wh_id			    NUMBER(38,0)	NOT NULL 	COMMENT 'Warehouse ID. Subset of Warehouse Number',
	lgnum               VARCHAR(4)      NOT NULL 	COMMENT 'Warehouse Number/Warehouse Complex',
	zz_kw				VARCHAR(2)		NOT NULL	COMMENT 'Calendar_2 week',
	zz_year             VARCHAR(4)      NOT NULL    COMMENT 'Calendar_2 year',
	zz_refbs            VARCHAR(10)     NOT NULL    COMMENT 'Return number',
	zz_refbs_top        VARCHAR(10)     NULL    	COMMENT 'Return number',
	partyno             VARCHAR(10)     NULL    	COMMENT 'Company number',
	bu_sort1            VARCHAR(40)     NULL    	COMMENT 'Description',
	zz_werks            VARCHAR(4)      NOT NULL    COMMENT 'Store',
	party_text          VARCHAR(40)     NULL    	COMMENT 'Description',
	bu_partner          VARCHAR(10)     NULL    	COMMENT 'Business Partner Number',
	productno           VARCHAR(40)     NOT NULL    COMMENT 'Product Number',
	maktx               VARCHAR(40)     NULL    	COMMENT 'Product Short Description',
	mat_price           NUMBER(38,2)    NULL    	COMMENT 'Material price',
	ok_prep_qty         NUMBER(38,0)    NULL    	COMMENT 'Dataelement scanned ok quantity',
	dfkt_qty            NUMBER(38,0)    NULL    	COMMENT 'NF complete defect qty',
	total_quan          NUMBER(38,0)    NULL    	COMMENT 'scanned quantity',
	credit              NUMBER(38,2)    NULL    	COMMENT 'Credit value',
	exp_quan            NUMBER(38,0)    NULL    	COMMENT 'Expected Quantity',
	total_value         NUMBER(38,2)    NULL    	COMMENT 'Total value',
	dif_quan            NUMBER(38,0)    NULL    	COMMENT 'Dataelement difference quantity',
	dif_value           NUMBER(38,2)    NULL    	COMMENT 'Dataelement difference value',
	matnr_dummy         VARCHAR(40)     NULL    	COMMENT 'Dummy_2 material number',
	maktxd              VARCHAR(40)     NULL    	COMMENT 'Product Short Description',
	dummy_price         NUMBER(38,2)    NULL    	COMMENT 'dummy_2 material price',
	dummy_quan          NUMBER(38,0)    NULL    	COMMENT 'Dataelement Dummy_2 quantity',
	waers               VARCHAR(5)      NULL    	COMMENT 'Currency Key',
	dwh_load_id 		NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
	dwh_created			TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
	dwh_updated			TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
	PRIMARY KEY (client_id, lgnum, zz_refbs, zz_kw, zz_year, zz_werks, productno)
)COMMENT = 'SAP EWM - Store evaluation'
;