CREATE OR REPLACE TABLE kfl_production_dbp_data.zb_projekt_projektrolle_zu_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
projekt_nr STRING(100) NOT NULL OPTIONS(description='Eindeutige Nummer des Projektes aus ePPM. '),
projektrolle_cd STRING(100) NOT NULL OPTIONS(description='Eindeutiger Code der Projektrolle.'),
mitarbeiter_name STRING(100) NOT NULL
OPTIONS(description='Name des Mitarbeiters der zum aktuellen Zeitpunkt die Rolle innerhalb des Projektes ausübt.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, projekt_nr, projektrolle_cd) NOT ENFORCED
)
OPTIONS(description='Zuordnungstabelle zwischen einem  Projekt aus den Zentralbereichen und alle darin ausgeübten Projektrollen.');