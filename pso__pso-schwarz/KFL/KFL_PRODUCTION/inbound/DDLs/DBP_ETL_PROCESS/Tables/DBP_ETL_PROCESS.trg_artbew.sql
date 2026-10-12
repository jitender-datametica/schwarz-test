CREATE OR REPLACE TABLE TRG_ARTBEW (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	DATZEIT_AENDERUNG TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel eines Eintrags nach Triggering',
	DAT DATE NOT NULL COMMENT 'Datum, Format YYYY-MM-DD',
	TRG_ACTION NUMBER(38,0) NOT NULL COMMENT 'Trigger Aktion (1=Insert; 2=Update; 3= Delete)',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='AIS - Zieltabelle von Trigger trg_artbew zur Replikation von Daten nach Hadoop - Bei Änderungen auf die Tabelle artbew wir die entsprchend geänderte Partition hier mit einem Zeitstempel gespeichert.'
;