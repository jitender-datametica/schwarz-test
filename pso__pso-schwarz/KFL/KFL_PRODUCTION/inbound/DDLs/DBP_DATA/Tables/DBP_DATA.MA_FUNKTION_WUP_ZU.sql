CREATE TABLE DBP_DATA.MA_FUNKTION_WUP_ZU (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Betriebsnummer',
	MA_ID NUMBER(38,0) NOT NULL COMMENT 'DWH ID des Mitarbeiters',
	MA_FUNKTION_ID VARCHAR(10) NOT NULL COLLATE 'en-ci' COMMENT 'eindeutige ID der Mitarbeiter-Funktion',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='VIS - alternative Hierarchiezuordnungen für alles, was in die normale Hierarchie nicht passt. Aus zrsvsother'
;