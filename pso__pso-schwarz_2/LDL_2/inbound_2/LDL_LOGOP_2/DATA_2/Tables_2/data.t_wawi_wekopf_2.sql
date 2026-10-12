/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_wawi_wekopf_2
Description		|	WAWI table
====================================================================================================
*/

CREATE TABLE DATA.t_wawi_wekopf_2 (
	client_id 			NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country_2 code', 
	wh_id				NUMBER(38,0)	NOT NULL 	COMMENT 'Warehouse number. Original name: gesellschaftsnr',
	delnotenorm			VARCHAR(20)		NULL 	 	COMMENT 'Standardized delivery note number without special characters and leading zeros.',
	id                  NUMBER(38,0)    NOT NULL 	COMMENT 'ID of the Goods receipt document. Unique ID pulled from the ID table',
	integra_adhoc_id    NUMBER(38,0)    NULL 	 	COMMENT 'FK T400 INTEGRA Adhoc head',
	issue_slip          VARCHAR(30)     NULL 	 	COMMENT 'The column is used for delivery documents.',
	krednr              VARCHAR(7)      NULL 	 	COMMENT 'Supplier_2 number',
	lagerortnr          NUMBER(38,0)    NOT NULL 	COMMENT 'Storage location_2 number',
	lieferscheinnr      VARCHAR(60)     NULL 	 	COMMENT 'delivery receipt number',
	old_wekorrdatum     DATE            NULL 	 	COMMENT '',
	po_nr               VARCHAR(12)     NULL 	 	COMMENT 'Order number',
	status_2              NUMBER(38,0)    NULL 	 	COMMENT 'Status_2: 1 = posted by DAY; 4 = booked by DHQ',
	statussatz          VARCHAR(2)      NULL 	 	COMMENT '',
	terminaljob_id      NUMBER(38,0)    NULL 	 	COMMENT 'Reference to T604_DELIVERIES.C604_DELIVERY_ID',
	tgstatus            NUMBER(38,0)    NULL 	 	COMMENT 'Status_2 for daily closing: 1 = ready to be posted by DAY; 2 = posted by DAY; 5 = booked by DHQ; 10 = Direct delivery ready for booking by DAY',
	wareneingangszeit   TIMESTAMP       NULL 	 	COMMENT 'Goods receipt time',
	we_art              NUMBER(38,0)    NULL 	 	COMMENT 'Property of the data: 1 = Goods receipt; 2 = ?; 3 = return',
	wedatum             DATE            NULL 	 	COMMENT 'Goods receipt date',
	wekorrdatum         DATE            NULL 	 	COMMENT 'Correction date',
	wawi_instanz_kzl 	VARCHAR(3) 		NOT NULL 	COMMENT 'Country_2 code',
	ewm_refnr 			VARCHAR(25)		NULL 		COMMENT '',
	scn 				NUMBER(38,0)	NULL 		COMMENT '',
	storenr 			NUMBER(4,0)		NULL 		COMMENT '',
	lia_reference 		VARCHAR(30)		NULL 		COMMENT '',
	dwh_load_id    		NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
	dwh_created    		TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
	dwh_updated    		TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
	dwh_valid_from 		DATE 			NOT NULL 	COMMENT 'Valid from date',
	dwh_valid_to   		DATE 			NOT NULL 	COMMENT 'Valid to date',
	deleted_fg     		BOOLEAN 		NOT NULL 	COMMENT 'Flag if record is deleted',
	PRIMARY KEY (client_id, wh_id, id, lagerortnr, wawi_instanz_kzl, dwh_valid_from)
) COMMENT = 'WAWI - Storage of the header information of a goods receipt.'
;