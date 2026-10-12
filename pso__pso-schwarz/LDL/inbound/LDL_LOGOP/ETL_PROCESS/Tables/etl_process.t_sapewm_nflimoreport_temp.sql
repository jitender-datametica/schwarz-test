/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	etl_process
DB table		|	t_sapewm_nflimoreport_temp
Description		|	SAP EWM - source table
====================================================================================================
*/

CREATE TABLE ETL_PROCESS.t_sapewm_nflimoreport_temp (
	client_id 			NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country code', 
	lidl_country 		VARCHAR(3) 		NOT NULL 	COMMENT 'Country code. Original field name bic_zmlila', 
	source_system 		VARCHAR(30) 	NOT NULL 	COMMENT 'Source system',
	wh_id				NUMBER(38,0)	NOT NULL 	COMMENT 'Warehouse ID. Subset of Warehouse Number',
	lgnum               VARCHAR(4)      NOT NULL 	COMMENT 'Warehouse Number/Warehouse Complex',
	zz_refbs			VARCHAR(10)		NOT NULL	COMMENT 'Return number',
	ret_status          VARCHAR(4)      NULL    	COMMENT 'Retrun Status',
	zz_kw               VARCHAR(2)      NOT NULL    COMMENT 'Calendar week',
	zz_year             VARCHAR(4)      NOT NULL    COMMENT 'Calendar year',
	action_cd           VARCHAR(60)     NULL    	COMMENT 'Action',
	reason              VARCHAR(40)     NULL    	COMMENT 'Reason',
	counted_hu          NUMBER(38,0)    NULL    	COMMENT 'WE EP',
	amount_stores       NUMBER(38,0)    NULL    	COMMENT 'Amount Stores in Return',
	avg_gr_p_s          NUMBER(38,0)    NULL    	COMMENT 'Average Goods Receipt per Store',
	avg_sum_pp          NUMBER(38,0)    NULL    	COMMENT 'Average Sum per Pallet',
	diff_art            NUMBER(38,0)    NULL    	COMMENT 'Different Articles',
	avg_pal_pc          NUMBER(38,0)    NULL    	COMMENT 'Average pieces/pallet',
	avg_rv_exp          NUMBER(38,0)    NULL    	COMMENT 'Average Return Value Expected',
	avg_val_s           NUMBER(38,0)    NULL    	COMMENT 'Average Value Store',
	val_pal             NUMBER(38,2)    NULL    	COMMENT 'Exp.Quantity per Counted HU',
	val_ex              NUMBER(38,2)    NULL    	COMMENT 'Value Ok Scanned materials',
	ex_quan             NUMBER(38,0)    NULL    	COMMENT 'Expected Quantities',
	avg_pc_exp          NUMBER(38,0)    NULL    	COMMENT 'Average Piece per Store expected',
	scan_am_val         NUMBER(38,0)    NULL    	COMMENT 'Scanned Amount Value',
	scan_pc_p_ret       NUMBER(38,0)    NULL    	COMMENT 'Scanned Pieces per Return',
	df_quan_per         NUMBER(38,2)    NULL    	COMMENT 'defect quantity percentage',
	df_quan             NUMBER(38,0)    NULL    	COMMENT 'NF complete defect qty',
	unkn_quan           NUMBER(38,0)    NULL    	COMMENT 'NF Complete Unknown Quantity',
	pack_pal        	NUMBER(38,0)    NULL    	COMMENT 'Packed Pallets',
	pack_pc        		NUMBER(38,0)    NULL    	COMMENT 'Packed Pieces',
	waers               VARCHAR(5)      NULL    	COMMENT 'Currency Key',
	dwh_load_id 		NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
	dwh_created			TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
	dwh_updated			TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
	PRIMARY KEY (client_id, lgnum, zz_refbs, zz_kw, zz_year)
) COMMENT = 'SAP EWM - Limo report'
;