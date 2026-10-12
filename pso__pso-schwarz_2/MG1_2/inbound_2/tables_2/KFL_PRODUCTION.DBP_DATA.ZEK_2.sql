create or replace TABLE KFL_PRODUCTION.DBP_DATA.ZEK_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	ZEK_ID VARCHAR(3) NOT NULL COMMENT 'Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch',
	WBL_ID NUMBER(38,0) COMMENT 'Warenbereichsleiter ID',
	ZEK_NAME VARCHAR(30) COLLATE 'en-ci' COMMENT 'Name des Zentraleinkäufers, verschiedene Ausprägungen, wie Nachname,Vorname, aber auch die Funktion, wie Pflanzen N.N',
	ZEK_ABT_BEZ VARCHAR(20) NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Bezeichnung einer Organisationseinheit, der ein Zentraleinkäufer zugeordnet ist. Quelle ist die Tabelle T024_2',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ZEK primary key (MANDANT_ID, ZEK_ID)
)COMMENT='TP2_AIS - Zentraleinkäufer'
;