CREATE OR REPLACE TABLE PEP_KPI_WG_ABT_ZU_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	ARTHIERTYP_ID NUMBER(38,0) NOT NULL COMMENT 'Artikel_2 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
	WG_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Warengruppe',
	PEP_KPI_ID NUMBER(38,0) NOT NULL COMMENT 'ID der KPI - Treiberkennzahl für Personaleinsatzplanung',
	DAYFORCE_ABT_BEZ VARCHAR(40) NOT NULL DEFAULT ' ' COMMENT 'Abteilungsbezeichnung Dayforce HCM (PEP)',
	PEP_KPI_BEZ VARCHAR(40) COMMENT 'Bezeichnung der KPI - Treiberkennzahl für Personaleinsatzplanung (SQL-Name für die Ausführung des entsprechend SQL)',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='VIS - Steuerungstabelle für die Datenlieferung an Dayforce HCM (PEP) - Tabelle soll abgelöst werden'
;