create or replace TABLE KFL_PRODUCTION.DBP_DATA.EREIGNIS (
	EREIGNIS_ID NUMBER(38,0) NOT NULL COMMENT 'Ereignis ID (fortlaufende Nummer)',
	EREIGNISTYP_ID NUMBER(38,0) NOT NULL COMMENT 'Ereignistyp ID, Gruppierung der Ereignisse in z.Bsp. Allgemeine Feiertage, Sonntagsöffnungen, ...',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	DEFAULT_OFFEN NUMBER(38,0) COMMENT 'gibt an, ob bei dem Ereignis der Markt normalerweise offen ist',
	SAP_EREIGNIS_ID NUMBER(38,0) COMMENT 'Die durch das SAP-System gelieferte ID wird im DWH auf die DWH-interne ID umgesetzt',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_EREIGNIS primary key (EREIGNIS_ID, EREIGNISTYP_ID, MANDANT_ID)
)COMMENT='VIS - Bildet Ereignisse ab, die sich auf den Umsatz auswirken können, wie Feiertage'
;