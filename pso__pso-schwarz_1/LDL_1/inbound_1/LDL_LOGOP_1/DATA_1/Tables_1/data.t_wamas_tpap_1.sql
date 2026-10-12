/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_wamas_tpap_1
Description		|	WAMAS source table
====================================================================================================
*/

CREATE TABLE DATA.t_wamas_tpap_1 (
	client_id 				NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country_1 code',
	lidl_country 			VARCHAR(4) 		NOT NULL 	COMMENT 'Country_1 code. Original field name bic_zmlila',
	source_system 			VARCHAR(30)		NOT NULL 	COMMENT 'Source_system: LPV',
	wh_id 					NUMBER(38,0) 	NOT NULL	COMMENT 'Warehouse ID. Subset of Warehouse Number (lagernummer)',
	tanr					FLOAT			NOT NULL 	COMMENT 'Transport order number',
	posnr                   FLOAT           NOT NULL 	COMMENT 'Transport order position number',
	protnr                  FLOAT           NULL 	 	COMMENT 'Protocol number',
	teid                    VARCHAR(18)     NULL 	 	COMMENT 'TE-ID',
	ksnr                    FLOAT           NULL 	 	COMMENT 'Picklistnumber (WAMAS)',
	vplpidx                 FLOAT           NULL 	 	COMMENT 'VPLP Index',
	cmd                     VARCHAR(6)      NULL 	 	COMMENT 'TPAP-Command',
	bearbid_posnr           FLOAT           NULL 	 	COMMENT 'Position number',
	bearbid_mandant         VARCHAR(3)      NULL 	 	COMMENT 'Mandant_1',
	bearbid_bearbnr         VARCHAR(16)     NULL 	 	COMMENT 'Edit number',
	bearbid_bearbkz         VARCHAR(5)      NULL 	 	COMMENT 'End indicator',
	bearbid_bearbtyp        VARCHAR(3)      NULL 	 	COMMENT 'Edit type',
	matid_artid_mandant     VARCHAR(3)      NULL 	 	COMMENT 'Mandant_1',
	artikelnr		        VARCHAR(20)     NULL 	 	COMMENT 'Product number. Original name: matid_artid_artnr',
	matid_artid_variante    VARCHAR(4)      NULL 	 	COMMENT 'Variant',
	matid_charge            VARCHAR(20)     NULL 	 	COMMENT 'Charge',
	artbez                  VARCHAR(35)     NULL 	 	COMMENT 'Product description',
	intartbez               VARCHAR(35)     NULL 	 	COMMENT 'International product description',
	veeinheit               VARCHAR(3)      NULL 	 	COMMENT 'Unit_1 of EVE',
	heeinheit               VARCHAR(3)      NULL 	 	COMMENT 'Unit_1 of HE',
	le2einheit              VARCHAR(3)      NULL 	 	COMMENT 'Unit_1 of LE2',
	le3einheit              VARCHAR(3)      NULL 	 	COMMENT 'Unit_1 of LE3',
	teeinheit               VARCHAR(3)      NULL 	 	COMMENT 'Unit_1 of TE',
	vonmngs_mng             FLOAT           NULL 	 	COMMENT 'Quantity',
	vonmngs_vehefakt        FLOAT           NULL 	 	COMMENT 'EVE/HE',
	vonmngs_hele2fakt       FLOAT           NULL 	 	COMMENT 'HE/LE2',
	vonmngs_hele3fakt       FLOAT           NULL 	 	COMMENT 'HE/LE3',
	vonmngs_hetefakt        FLOAT           NULL 	 	COMMENT 'HE/TE',
	vonmngs_gewicht         FLOAT           NULL 	 	COMMENT 'Weight',
	info                    VARCHAR(70)     NULL 	 	COMMENT 'Information',
	endhoststatus           VARCHAR(6)      NULL 	 	COMMENT 'End HOSTSTATUS',
	acode                   VARCHAR(2)      NULL 	 	COMMENT 'End code',
	laghost                 VARCHAR(4)      NULL 	 	COMMENT 'Storage location_1 host',
	hist_anzeit             DATE       		NULL 	 	COMMENT 'Created on',
	hist_anuser             VARCHAR(10)     NULL 	 	COMMENT 'Created from',
	hist_aezeit             DATE       		NULL 	 	COMMENT 'Changed on',
	hist_aeuser             VARCHAR(10)     NULL 	 	COMMENT 'Changed from',
	hist_lozeit             DATE       		NULL 	 	COMMENT 'Deletion on',
	hist_louser             VARCHAR(10)     NULL 	 	COMMENT 'Deleted from',
	dwh_load_id 			NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
	dwh_created 			TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
	dwh_updated 			TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
	dwh_valid_from 			DATE 			NOT NULL 	COMMENT 'Valid from date',
	dwh_valid_to 			DATE 			NOT NULL 	COMMENT 'Valid to date',
	deleted_fg 				BOOLEAN 		NOT NULL 	COMMENT 'Flag if record is deleted',
	PRIMARY KEY (client_id, wh_id, tanr, posnr, dwh_valid_from)
) COMMENT = 'WAMAS - Transport order POSITION'
; 