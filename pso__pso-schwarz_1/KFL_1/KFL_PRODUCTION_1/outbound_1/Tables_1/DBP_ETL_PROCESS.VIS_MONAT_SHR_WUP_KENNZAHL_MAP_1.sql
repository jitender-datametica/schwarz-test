CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.vis_monat_shr_wup_kennzahl_map_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='PK - Mandant_1 im DWH'),
shr_kennzahl STRING(40) NOT NULL
OPTIONS(description='Bezeichnung der Kennzahl aus der Tabelle vis_monat_shr_wup_1 z.B. stunden_arztbesuch (zur Erstellung der Kennzahl muss auf Lohnarten eingeschränkt werden)'),
lohnart_id STRING(5) NOT NULL OPTIONS(description='ID der Lohnart - Zuordnung Kennzahl zu Lohnart'),
kjmo_bis BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Zuordnung der Kennzahl Gültig bis Monat_1 (eines Kalenderjahres, Format JJJJMM)'),
kjmo_von BIGNUMERIC(38,0)
OPTIONS(description='Zuordnung der Kennzahl Gültig ab Monat_1 (eines Kalenderjahres, Format JJJJMM)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
)
OPTIONS(description='VIS - Mappingtablle SHR-Kennzahlen aus der Tabelle vis_monat_shr_wup_1 zu Lohnarten mit Gültigszeitraum (kjmo_von - kjmo_bis)');