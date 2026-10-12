create or replace TABLE KFL_PRODUCTION.DBP_DATA.EREIGNIS_SPR_ZU (
	EREIGNIS_ID NUMBER(38,0) NOT NULL COMMENT 'Ereignis ID (fortlaufende Nummer)',
	EREIGNISTYP_ID NUMBER(38,0) NOT NULL COMMENT 'Ereignistyp ID, Gruppierung der Ereignisse in z.Bsp. Allgemeine Feiertage, Sonntagsöffnungen, ...',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache\n            ',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	EREIGNIS_BEZ_LANG VARCHAR(60) COLLATE 'en-ci' COMMENT 'Langbezeichnung eines Ereignisses, z.Bsp.\n            Lang = Ostersonntag\n            Mittel = Ostern\n            Kurz = O',
	EREIGNIS_BEZ_MITTEL VARCHAR(60) COLLATE 'en-ci' COMMENT 'Mittellangbezeichnung eines Ereignisses, z.Bsp.\n            Lang = Ostersonntag\n            Mittel = Ostern\n            Kurz = O',
	EREIGNIS_BEZ_KURZ VARCHAR(60) COLLATE 'en-ci' COMMENT 'Kurzbezeichnung eines Ereignisses, z.Bsp.\n            Lang = Ostersonntag\n            Mittel = Ostern\n            Kurz = O',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_EREIGNIS_SPR_ZU primary key (EREIGNIS_ID, EREIGNISTYP_ID, SPR_ID, MANDANT_ID)
)COMMENT='VIS - Bezeichnung eines Ereignisses in den DWH-Sprachen'
;