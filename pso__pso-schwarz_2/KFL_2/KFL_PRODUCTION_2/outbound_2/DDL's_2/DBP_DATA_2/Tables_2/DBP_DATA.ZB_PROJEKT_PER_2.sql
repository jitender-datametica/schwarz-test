CREATE OR REPLACE TABLE kfl_production_dbp_data.zb_projekt_per_2 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
projekt_nr STRING(100) NOT NULL OPTIONS(description='Eindeutige Code des Projektes aus ePPM. '),
dat_von DATE NOT NULL OPTIONS(description='Beginn der Gültigkeit, Teil der DWH-Historisierung.'),
dat_bis DATE NOT NULL OPTIONS(description='Ende der Gültigkeit, Teil der DWH-Historisierung.'),
wup_id INTEGER OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id INTEGER OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
psp_nr STRING(20) OPTIONS(description='PSP-Nummer des Projektes.'),
projekt_status_id INTEGER NOT NULL OPTIONS(description='ID des Projektstatus.'),
psp_status_id INTEGER NOT NULL
OPTIONS(description='ID des Status_2 des Buchungselementes (entspricht der PSP_NR). Kann vom Status_2 des Projektes abweichen.'),
projekt_name STRING(100) OPTIONS(description='Name des Projektes.'),
projekt_land_id STRING(2) NOT NULL
OPTIONS(description='Alphanumerischer Code des Landes in dem das Projekt stattfindet.'),
projekttyp_id INTEGER OPTIONS(description='ID des Projekttyps'),
projektart_cd STRING(20) NOT NULL OPTIONS(description='Alphanumerischer Coder der Projektart'),
projekt_region_name STRING(100)
OPTIONS(description='Name der Region_2 innerhalb des Landes in dem das Projekt stattfindet. Entsprich nicht den politischen Regionen, bspw. Bundesländer.'),
projekt_plz_nr STRING(40) OPTIONS(description='Nummer der Postleitzahl in dem das Projekt statfindet.'),
projekt_standort_name STRING(100)
OPTIONS(description='Name des Standortes an dem das Projekt stattfindet. Sollte in den meisten Fällen dem Namen der Stadt / der Gemeinde entsprechen.'),
projekt_stadtteil_name STRING(100) OPTIONS(description='Name des Stadtteils in dem das Projekt stattfindet.'),
projekt_strasse_name STRING(100) OPTIONS(description='Name der Straße an dem das Projekt stattfindet.'),
projekt_haus_nr STRING(40) OPTIONS(description='Hausnummer an dem das Projekt in der Straße stattfindet.'),
projekt_bemerkung_txt STRING(1000) OPTIONS(description='Freitext für projektbezogene Bemerkungen.'),
dat_storno DATE OPTIONS(description='Datum des Storno sollte ein Projekt nachträglich storniert werden.'),
gj_plan_eroeffnung INTEGER OPTIONS(description='Geplantes Geschäftsjahr für die Eröffnung.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, projekt_nr, dat_von) NOT ENFORCED
) OPTIONS(description='Enthält historisierte Stammdaten für Projekte im Bereich Zentralbereiche (ZB).');