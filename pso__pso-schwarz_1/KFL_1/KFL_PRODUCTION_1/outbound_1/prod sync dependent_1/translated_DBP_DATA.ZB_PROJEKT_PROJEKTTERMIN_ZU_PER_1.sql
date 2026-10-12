CREATE OR REPLACE TABLE kfl_production_dbp_data.zb_projekt_projekttermin_zu_per_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
projekt_nr STRING(100) NOT NULL OPTIONS(description='Eindeutige Code des Projektes aus ePPM. '),
projekttermin_cd STRING(100) NOT NULL OPTIONS(description='Code des Projekttermins.'),
dat_von DATE NOT NULL OPTIONS(description='Beginn der Gültigkeit, Teil der DWH-Historisierung.'),
dat_bis DATE NOT NULL OPTIONS(description='Ende der Gültigkeit, Teil der DWH-Historisierung.'),
dat_termin_ist DATE OPTIONS(description='Ist-Datum des Termins.'),
dat_termin_prognose DATE NOT NULL OPTIONS(description='Prognostiziertes Datum des Termins.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, projekt_nr, projekttermin_cd, dat_von) NOT ENFORCED
)
OPTIONS(description='Zuordnungstabelle zwischen einem  Projekt aus den Zentralbereichen und allen darin vorhandenen Termine.');