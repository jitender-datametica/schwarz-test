CREATE OR REPLACE TABLE REPLIKATION_HADOOP_DAT (
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant im DWH',
	DAT DATE NOT NULL COMMENT 'Datum im Format JJJJ-MM-TT',
	ZIELTABELLE_BEZ VARCHAR(50) NOT NULL COMMENT 'Zieltabelle des Replikationsprozess',
	REPLIKATION_BEZ VARCHAR(255) COMMENT 'Beschreibung des Replikationsprozesses',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='HDP - Lookup-Tabelle für die Hadoop-Replikation'
;