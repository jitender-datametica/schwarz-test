/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_lpv_handy_1
Description		|	LPV source table
====================================================================================================
*/

CREATE TABLE DATA.t_lpv_handy_1 (
	client_id 				NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country_1 code', 
	lidl_country 			VARCHAR(3) 		NOT NULL 	COMMENT 'Country_1 code. Original field name bic_zmlila', 
	source_system 			VARCHAR(30) 	NOT NULL 	COMMENT 'Source system',
	wh_id 					NUMBER(38,0) 	NOT NULL	COMMENT 'Warehouse ID. Subset of Warehouse Number (lagernummer)',
	filenr					NUMBER(38,0)	NOT NULL 	COMMENT 'Internal ID. FK: References LPV.AUFTRAG.FILENR. Original name - filenr',
	typ                     VARCHAR(1)      NULL 	 	COMMENT 'Task type. Original name - typ',
	anlagezeit              TIMESTAMP     	NULL 	 	COMMENT 'Time stamp of the record creation. Original name - anlagezeit',
	startzeit               TIMESTAMP     	NULL 	 	COMMENT 'Time stamp of the task activation. Original name - startzeit',
	abschlusszeit           TIMESTAMP     	NULL 	 	COMMENT 'Time stamp of the finished task. Original name - abschlusszeit',
	status_1                  NUMBER(38,0)    NULL 	 	COMMENT 'Status_1 of the task. Original name - status_1',
	prio                    NUMBER(38,0)    NULL 	 	COMMENT 'Priority. Original name - prio',
	lagernr                 NUMBER(38,0)    NULL 	 	COMMENT 'Source warehouse number, usually 1. FK: Referencing LPV.LAGER.LAGERNR. Original name - lagernr',
	bereich                 NUMBER(38,0)    NULL 	 	COMMENT 'Source area. FK: Referencing LPV.BEREICH.NR. Original name - bereich',
	ziel_lagernr            NUMBER(38,0)    NULL 	 	COMMENT 'Target warehouse number. FK: Referencing LPV.LAGER.LAGERNR. Original name - ziel_lagernr',
	ziel_bereich            NUMBER(38,0)    NULL 	 	COMMENT 'Target area. FK: Referencing LPV.BEREICH.NR. Original name - ziel_bereich',
	anzahl                  NUMBER(38,0)    NULL 	 	COMMENT 'N/A. Original name - anzahl',
	bhtid                   VARCHAR(15)     NULL 	 	COMMENT 'N/A. Original name - bhtid',
	persnr                  VARCHAR(9)      NULL 	 	COMMENT 'Personal number of the operator. Original name - persnr',
	persnrpano              VARCHAR(9)      NULL 	 	COMMENT 'N/A. Original name - persnrpano',
	persnrpasp              VARCHAR(9)      NULL 	 	COMMENT 'N/A. Original name - persnrpasp',
	tour_1                    NUMBER(38,0)    NULL 	 	COMMENT 'N/A. Original name - tour_1',
	variant                 VARCHAR(100)    NULL 	 	COMMENT 'N/A. Original name - variant',
	anz_colli               NUMBER(38,0)    NULL 	 	COMMENT 'N/A. Original name - anz_colli',
	anz_pal                 NUMBER(38,0)    NULL 	 	COMMENT 'N/A. Original name - anz_pal',
	bexnr                   VARCHAR(20)     NULL 	 	COMMENT 'N/A. Original name - bexnr',
	dummy_1                   VARCHAR(150)    NULL 	 	COMMENT 'N/A. Original name - dummy_1',
	versandart              NUMBER(38,0)    NULL 	 	COMMENT 'N/A. Original name - versandart',
	sammelfnr               NUMBER(38,0)    NULL 	 	COMMENT 'N/A. Original name - sammelfnr',
	platznr                 NUMBER(38,0)    NULL 	 	COMMENT 'N/A. Original name - platznr',
	lhmnr                   VARCHAR(30)     NULL 	 	COMMENT 'Number of the pallet on which the stock is located. FK: References LPV.LHM.LHMNR and LPV.BEDSTAND.LHMNR. Original name - lhmnr',
	arbeitsart              NUMBER(38,0)    NULL 	 	COMMENT 'N/A. Original name - arbeitsart',
	mfrkz                   NUMBER(38,0)    NULL 	 	COMMENT 'N/A. Original name - mfrkz',
	gedruckt                NUMBER(38,0)    NULL 	 	COMMENT 'N/A. Original name - gedruckt',
	weggrp0status           NUMBER(38,0)    NULL 	 	COMMENT 'N/A. Original name - weggrp0status',
	weggrp1status           NUMBER(38,0)    NULL 	 	COMMENT 'N/A. Original name - weggrp1status',
	weggrp2status           NUMBER(38,0)    NULL 	 	COMMENT 'N/A. Original name - weggrp2status',
	weggrp3status           NUMBER(38,0)    NULL 	 	COMMENT 'N/A. Original name - weggrp3status',
	weggrp4status           NUMBER(38,0)    NULL 	 	COMMENT 'N/A. Original name - weggrp4status',
	gruppenr                NUMBER(38,0)    NULL 	 	COMMENT 'N/A. Original name - gruppenr',
	vongruppenr             NUMBER(38,0)    NULL 	 	COMMENT 'N/A. Original name - vongruppenr',
	subtyp                  VARCHAR(10)     NULL 	 	COMMENT 'N/A. Original name - subtyp',
	dwh_load_id    			NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
	dwh_created    			TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
	dwh_updated    			TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
	dwh_valid_from 			DATE 			NOT NULL 	COMMENT 'Valid from date',
	dwh_valid_to   			DATE 			NOT NULL 	COMMENT 'Valid to date',
	deleted_fg     			BOOLEAN 		NOT NULL 	COMMENT 'Flag if record is deleted',
	PRIMARY KEY (client_id, wh_id, filenr, dwh_valid_from)
) COMMENT = 'LPV - This table saves goods movement tasks, their type, status_1 and timestamps creation, activation and finishing of the task.'
;