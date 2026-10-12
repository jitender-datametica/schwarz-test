CREATE OR REPLACE TABLE kfl_production_dbp_data.zb_projekt_projektphase_zu_per_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
projekt_nr STRING(100) NOT NULL OPTIONS(description='Eindeutige Code des Projektes aus ePPM. '),
projektphase_id INTEGER NOT NULL OPTIONS(description='ID der Projektphase'),
dat_von DATE NOT NULL OPTIONS(description='Beginn der Gültigkeit, Teil der DWH-Historisierung.'),
dat_bis DATE NOT NULL OPTIONS(description='Ende der Gültigkeit, Teil der DWH-Historisierung.'),
projektphase_status_id INTEGER NOT NULL OPTIONS(description='ID des Status_1 der Projektphase.'),
projektphase_aktiv_fg INTEGER NOT NULL
OPTIONS(description='Kennzeichen, ob die Phase aktuell aktiv im Projekt ist (1) oder nicht (2).'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, projekt_nr, projektphase_id, dat_von) NOT ENFORCED
)
OPTIONS(description='Zuordnungstabelle zwischen einem Projekt aus den Zentralbereichen und den möglichen Projektphasen');