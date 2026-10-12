CREATE OR REPLACE TABLE kfl_production_dbp_data.ma_abwesenh_zu_per (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
abwesenheit_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID der Abwesenheit, z.Bsp, OKA2'),
mitarbeiter_id STRING(20) NOT NULL OPTIONS(description='Eindeutige anonymisierte ID des Mitarbeiters'),
kjmo INTEGER NOT NULL OPTIONS(description='Kalenderjahresmonaz, z.Bsp 200908'),
dat_von DATE NOT NULL OPTIONS(description='Beginn der Gueltigkeit'),
dat_bis DATE NOT NULL OPTIONS(description='Ende der Gueltigkeit'),
abwesenheit_stunden NUMERIC(9,2) DEFAULT 0 NOT NULL
OPTIONS(description='Abwesenheitsstunden Mitarbeiter auf Ebene Abwesenheitsart aus SAP HCM Infotyp 2001 - Feld stdaz'),
abrechnung_tage NUMERIC(9,2) DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl Abrechnungstage ; Feld: ABRTG ; Quelle: IT2001-abrtage'),
abrechnung_stunden NUMERIC(9,2) DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl Abrechnungsstunden ; Feld: ABRST ; Quelle: IT2001-abrstdn'),
td_insert TIMESTAMP,
td_update TIMESTAMP
);