create or replace TABLE KFL_PRODUCTION.DBP_ODS.KASSE_TYP_SPR_ZU_1 (
	KASSE_TYP_ID NUMBER(38,0) NOT NULL COMMENT 'Kassentyp. Folgende Typen kommen vor: 1 = default(Sales_1 POS), 2 = Info, 3 = Leergut (Empties), 4 = Server (Back-Office),5 = Imbiss, 6 = Mobile, 7 = Emergency, 8 = SCO (SelfCheckOut),  -1 = unbekannt',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	KASSE_TYP_BEZ VARCHAR(20) COLLATE 'en-ci' COMMENT 'Bezeichnung des Kassentyps (z.B. Normal, Info, Leergut, Server, Imbiss, SCO, etc.)',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	KASSE_NAME_BEZ VARCHAR(6) COMMENT 'Kassekurzbezeichnung. Z.B. POS, SCO, …'
)COMMENT='ODS - Sprachabhaengige Bezeichnungen fuer den Kassentyp (DE: z.B. Normal, Info, Leergut, Server, Imbiss, SCO, etc.)'
;