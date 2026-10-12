/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_sapewm_telegram_1
Description		|	SAP EWM - source table
====================================================================================================
*/

CREATE TABLE DATA.t_sapewm_telegram_1 (
	client_id 				NUMBER(38,0) 	NOT NULL 	COMMENT 'Client id - calculated based on the country_1 code', 
	lidl_country 			VARCHAR(3) 		NOT NULL 	COMMENT 'Country_1 code. Original field name bic_zmlila', 
	source_system 			VARCHAR(30) 	NOT NULL 	COMMENT 'Source system',
	wh_id					NUMBER(38,0)	NOT NULL 	COMMENT 'Warehouse ID. Subset of Warehouse Number',
	mandt					VARCHAR(3)		NULL 	 	COMMENT 'Client',
	lgnum                   VARCHAR(4)      NOT NULL 	COMMENT 'Warehouse Number/Warehouse Complex',
	plc                     VARCHAR(8)      NULL 	 	COMMENT 'Programmable Logic Controller',
	channel                 VARCHAR(1)      NULL 	 	COMMENT 'Communication_1 Channel for PLC',
	ts_date                 DATE            NULL 		COMMENT 'Date of Telegram',
	ts_time                 TIME(0)         NULL 		COMMENT 'Time of Telegram',
	ts_time_ms              NUMBER(38,0)    NULL 	 	COMMENT 'Milliseconds of Telegram',
	TIMESTAMP               TIMESTAMP	    NOT NULL 	COMMENT 'UTC Time Stamp in Long Form (YYYYMMDDhhmmssmmmuuun)',
	sender                  VARCHAR(8)      NULL 	 	COMMENT 'Sender',
	receiver                VARCHAR(8)      NULL 	 	COMMENT 'Recipient(s)',
	cp                      VARCHAR(18)     NULL 	 	COMMENT 'Communication_1 Point for Conveyor Technique',
	handshake               VARCHAR(2)      NULL 	 	COMMENT 'Telegram Handshake (Request or Confirmation)',
	sequ_no                 NUMBER(38,0)    NOT NULL 	COMMENT 'Telegram Sequence Number',
	comm_error              VARCHAR(4)      NULL 	 	COMMENT 'Error During Telegram Communication_1',
	teletype                VARCHAR(4)      NOT NULL 	COMMENT 'Telegram Type',
	action                  VARCHAR(2)      NULL 	 	COMMENT 'Action',
	huident                 VARCHAR(20)     NOT NULL 	COMMENT 'Handling Unit_1 Identification',
	SOURCE                  VARCHAR(18)     NULL 	 	COMMENT 'Source Location_1 for Movements in MFS Environment',
	dest                    VARCHAR(18)     NULL 	 	COMMENT 'Destination Location_1 for Movements in MFS Environment',
	direction               VARCHAR(1)      NULL 	 	COMMENT 'Displays the Telegram Flow Direction',
	msg                     VARCHAR(1000)   NULL 	 	COMMENT 'Telegram',
	msg1                    VARCHAR(100)    NULL 	 	COMMENT 'Telegram Only 100 Characters (UI)',
	msg2                    VARCHAR(100)    NULL 	 	COMMENT 'Telegram Only 100 Characters (UI)',
	msg3                    VARCHAR(55)     NULL 	 	COMMENT 'Telegram Only 55 Characters (UI)',
	msg_len                 NUMBER(38,0)    NULL 	 	COMMENT 'Telegram Character Length',
	mfs_error               VARCHAR(4)      NULL 	 	COMMENT 'Error in Telegram',
	tanum                   NUMBER(38,0)    NULL	 	COMMENT 'Warehouse Task',
	who                     NUMBER(38,0)    NULL 	 	COMMENT 'Warehouse Order Number',
	hndshk_perf             NUMBER(38,0)    NULL 	 	COMMENT 'Handshake Performance (Milliseconds)',
	ewm_follup_perf         NUMBER(38,0)    NULL 	 	COMMENT 'SAP EWM Follow-Up Telegram Performance (Milliseconds)',
	plc_follup_perf         NUMBER(38,0)    NULL 	 	COMMENT 'PLC Follow-Up Telegram Performance (Milliseconds)',
	dummy_mfstelelog        VARCHAR(1)      NULL 	 	COMMENT 'Dummy_1 function in length 1',
	dwh_load_id 			NUMBER(38,0) 	NOT NULL 	COMMENT 'Load id',
	dwh_created				TIMESTAMP 		NOT NULL 	COMMENT 'Record created at',
	dwh_updated				TIMESTAMP 		NOT NULL 	COMMENT 'Record updated at',
	PRIMARY KEY (client_id, lgnum, TIMESTAMP, teletype, huident, sequ_no)
) COMMENT = 'SAP EWM - Logging of Telegram Flow & Convert Timestamp'
;