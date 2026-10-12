create or replace TABLE KFL_PRODUCTION.DBP_DATA.ART_NIELSEN_WUG_ZU_PFLEGE_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	ART_NIELSEN_ID NUMBER(38,0) NOT NULL COMMENT 'Artikel_1-ID aus Nielsen',
	ART_NIELSEN_BEZ VARCHAR(1024) NOT NULL COLLATE 'en-ci' DEFAULT '-1' COMMENT 'Artikelbezeichnung aus Nielsen ',
	FB_PFLEGE_WG_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'ID der Warengruppe wie sie vom Fachbereich vorgeschlagen wurde.',
	FB_PFLEGE_WUG_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'ID der Warenuntergruppe (WGI) wie sie vom Fachbereich vorgeschlagen wurde.',
	NIELSEN_ABTEILUNG_BEZ VARCHAR(1024) NOT NULL COLLATE 'en-ci' DEFAULT '-1' COMMENT 'Nielsen Bezeichnung der Abteilung',
	NIELSEN_WG_BEZ VARCHAR(1024) NOT NULL COLLATE 'en-ci' DEFAULT '-1' COMMENT 'Nielsen Bezeichnung der Warengruppen',
	NIELSEN_UWG1_BEZ VARCHAR(1024) NOT NULL COLLATE 'en-ci' DEFAULT '-1' COMMENT 'Nielsen Bezeichnung der Unterwarengruppe 1',
	NIELSEN_UWG2_BEZ VARCHAR(1024) NOT NULL COLLATE 'en-ci' DEFAULT '-1' COMMENT 'Nielsen Bezeichnung der Unterwarengruppe 2',
	KALK_VORSCHL_WG_ID NUMBER(38,0) COMMENT 'Im Beladeprozess ermmittelte Warengruppe-ID (in welcher Kaufland-WG befinden sich die meisten Nielsen-Artikel_1 mit der gleichen Nielsen-UWG2)',
	KALK_VORSCHL_WUG_ID NUMBER(38,0) COMMENT 'Im Beladeprozess ermmittelte Warenuntergruppe-ID (WGI) (in welcher Kaufland-WG befinden sich die meisten Nielsen-Artikel_1 mit der gleichen Nielsen-UWG2).',
	DATZEIT_LETZTE_EINTRAGUNG_FB_PFLEGE TIMESTAMP_LTZ(9) COMMENT 'Zeitpunkt der letzten Eintragung für Pflege durch Fachbereich.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ART_NIELSEN_WUG_ZU_PFLEGE primary key (MANDANT_ID, ART_NIELSEN_ID)
)COMMENT='EK-SORT - TS Zuordnung Artikel_1 zu Artikelhierarchie'
;