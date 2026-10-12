create or replace TABLE KFL_PRODUCTION.DBP_DATA.IN_BUCHUNGSKREIS_SPR_ZU (
	BUCHUNGSKREIS_ID NUMBER(38,0) NOT NULL COMMENT 'Zuordnung des Buchungskreises zu dem WUP über die SAP Quelle T001K und T001. Der Buchungskreis entspricht unter dem Mandanten einer Zusammenfassung von Werken (Hierarchie: Mandant, Buchungskreis, Werk/Betrieb). Bsp: Buchungskreis 282 entspricht Kaufland',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.',
	BUCHUNGSKREIS_BEZ VARCHAR(30) COLLATE 'en-ci' COMMENT 'Bezeichnung des Buchungskreises aus butxt',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_IN_BUCHUNGSKREIS_SPR_ZU primary key (BUCHUNGSKREIS_ID, MANDANT_ID, SPR_ID)
)COMMENT='IMS - Sprachabhängige Bezeichnungen der Buchungskreise aus SAP Industrie. Quelle ist t001'
;