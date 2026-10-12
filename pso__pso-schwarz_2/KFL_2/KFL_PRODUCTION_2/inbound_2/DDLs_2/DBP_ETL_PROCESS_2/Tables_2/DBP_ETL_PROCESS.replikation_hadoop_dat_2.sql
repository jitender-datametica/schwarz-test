CREATE OR REPLACE TABLE REPLIKATION_HADOOP_DAT_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	DAT DATE NOT NULL COMMENT 'Datum im Format JJJJ-MM_2-TT',
	ZIELTABELLE_BEZ VARCHAR(50) NOT NULL COMMENT 'Zieltabelle des Replikationsprozess',
	REPLIKATION_BEZ VARCHAR(255) COMMENT 'Beschreibung des Replikationsprozesses',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='HDP - Lookup-Tabelle für die Hadoop-Replikation'
;