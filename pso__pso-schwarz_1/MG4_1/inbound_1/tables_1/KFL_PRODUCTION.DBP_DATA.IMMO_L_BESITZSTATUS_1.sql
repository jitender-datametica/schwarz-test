create or replace TABLE KFL_PRODUCTION.DBP_DATA.IMMO_L_BESITZSTATUS_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	BESITZSTATUS_ID VARCHAR(1) NOT NULL COLLATE 'en-ci' COMMENT 'Besitzstatus ',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_IMMO_L_BESITZSTATUS primary key (MANDANT_ID, BESITZSTATUS_ID)
)COMMENT='IMMO - Lookup-Tabelle Besitzstatus der Wirtschaftseinheit - SAP REFX - ZRE_BESITZSTATT'
;