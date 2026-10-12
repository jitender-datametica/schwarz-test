CREATE OR REPLACE TABLE PEP_INT_KPI_WG_ABT_ZU_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	WG_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Warengruppe',
	ARTHIERTYP_ID NUMBER(38,0) NOT NULL COMMENT 'Artikel_1 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
	PEP_KPI_KZ VARCHAR(40) NOT NULL COMMENT 'Eindeutiges Kennzeichen der KPI - Treiberkennzahl für Personaleinsatzplanung',
	DAYFORCE_ABT_BEZ VARCHAR(40) NOT NULL DEFAULT ' ' COMMENT 'Abteilungsbezeichnung Dayforce HCM (PEP)',
	PEP_KPI_BEZ VARCHAR(40) COMMENT 'Bezeichnung der KPI - Treiberkennzahl für Personaleinsatzplanung (SQL-Name für die Ausführung des entsprechend SQL)',
	AKTIV_FG NUMBER(38,0) NOT NULL COMMENT 'Aktiv-Flag für KPI (1=aktiv)',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='VIS - Steuerungstabelle für die Datenlieferung an Dayforce HCM (PEP) für alle KL-Länder (inkl. KMO) - kpi_kz anstatt kpi_id'
;