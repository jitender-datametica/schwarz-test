create or replace TABLE KFL_PRODUCTION.DBP_DATA.COS_BONUSPUNKTE_TRANSAKTION (
	CRM_KONTO_ID VARCHAR(144) NOT NULL COMMENT 'The ID of the loyalty account.',
	DATZEIT_BONUSPUNKTE_TRANSAKTION TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the points.',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'KFL country where the bonus transaction happens.',
	BONUSPUNKTE_TRANSAKTION_ID VARCHAR(144) COMMENT 'Unique key to identify a bonustransaction. Key to get from table bonustransactions to transactions table.',
	ANZ_BONUSPUNKTE_TRANSAKTION NUMBER(38,0) COMMENT 'Total value of the bonus transaction.',
	BONUSPUNKTE_TRANSAKTION_RICHTUNG NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'Shows the direction of the bonus transaction (1 = earn, 2 = burn).',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	DATZEIT_UPDATE TIMESTAMP_LTZ(9) COMMENT 'timestamp of when the record was last updated in the source system. it is used to monitor the correctness of the loading process by comparing what is in the dwh and in the source.',
	constraint PK_COS_BONUSPUNKTE_TRANSAKTION primary key (CRM_KONTO_ID, DATZEIT_BONUSPUNKTE_TRANSAKTION)
)COMMENT='Bonus points awarded or spent by customer per transaction.'
;