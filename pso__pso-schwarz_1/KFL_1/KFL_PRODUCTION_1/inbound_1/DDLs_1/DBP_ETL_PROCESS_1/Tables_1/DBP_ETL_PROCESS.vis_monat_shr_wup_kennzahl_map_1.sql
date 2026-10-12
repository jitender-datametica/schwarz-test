CREATE OR REPLACE TABLE VIS_MONAT_SHR_WUP_KENNZAHL_MAP_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'PK - Mandant_1 im DWH',
	SHR_KENNZAHL VARCHAR(40) NOT NULL COMMENT 'Bezeichnung der Kennzahl aus der Tabelle vis_monat_shr_wup_1 z.B. stunden_arztbesuch (zur Erstellung der Kennzahl muss auf Lohnarten eingeschränkt werden)',
	LOHNART_ID VARCHAR(5) NOT NULL COMMENT 'ID der Lohnart - Zuordnung Kennzahl zu Lohnart',
	KJMO_BIS NUMBER(38,0) NOT NULL COMMENT 'Zuordnung der Kennzahl Gültig bis Monat_1 (eines Kalenderjahres, Format JJJJMM)',
	KJMO_VON NUMBER(38,0) COMMENT 'Zuordnung der Kennzahl Gültig ab Monat_1 (eines Kalenderjahres, Format JJJJMM)',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='VIS - Mappingtablle SHR-Kennzahlen aus der Tabelle vis_monat_shr_wup_1 zu Lohnarten mit Gültigszeitraum (kjmo_von - kjmo_bis)'
;