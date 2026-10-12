create or replace TABLE KFL_PRODUCTION.DBP_DATA.SM (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	SM_ID NUMBER(38,0) NOT NULL COMMENT 'Sortimentsmodul ID. Es gibt 8 Sortimentsstufen. -1: keine Sortimentsstufe zugeordnet',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	SAP_SM_ID VARCHAR(2) COLLATE 'en-ci' COMMENT 'Originalinhalt aus SAP. Für KMO kann die bisherige Regel für die Vergabe der sm_id nicht angewendet werden. Daher erfolgt bei SAP-Char-Formaten eine Umsetzung auf ein numerisches Format',
	SM_BEZ VARCHAR(40) COLLATE 'en-ci' COMMENT 'Sortimentsmodul',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_SM primary key (SM_ID, MANDANT_ID, SPR_ID)
)COMMENT='Sortimentsmodul (=Sortimentsstufe). Inhalt DE: 1,2,3,4,5. Für KMO können auch negative Werte vorkommen'
;