--==============================================================
-- Table: cpr_projekt_bauabschnitt_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cpr_projekt_bauabschnitt_zu
   generated from Powerdesigner on Dienstag, 27. Juni 2023 17:37:37
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.cpr_projekt_bauabschnitt_zu (
projekt_unter_id STRING(32) NOT NULL OPTIONS(description='eindeutige ID aus Aufgabe oder Checkliste_Punkt'),
projekt_id STRING(32) NOT NULL OPTIONS(description='Eindeutige ID des Projekts'),
bauabschnitt_id STRING(32)
OPTIONS(description='eindeutige ID der Bauabschnitte aus Aufgabe oder Phase, bzw. Kopf aus Projekt'),
cpr_ext_id STRING(30) DEFAULT ' ' NOT NULL OPTIONS(description='eindeutige Projektnummer pro Projekt und Sprache'),
cpr_systemstatus1_prj_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Schluessel für den Projekt-Systemstatus1, Enthält numerische Werte von 1 aufsteigend'),
cpr_systemstatus1_bauab_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Schluessel für den Bauabschnitt-Systemstatus1, Enthält numerische Werte von 1 aufsteigend'),
dat_eroeffnung_projekt DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL
OPTIONS(description='maximaler Eröffnungstermin pro Projekt'),
sort_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Quelle von bauabschnitt_id, 1 = cpr_projekt_per, 2 = cpr_phase_per oder cpr_aufgabe_per'),
cpr_suchfeld_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Diese ID wird bei der Versorgung aus dem von der Quelle gelieferten Feld generiert'),
dat_start_ist DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL OPTIONS(description='Isttermin Start'),
dat_ende_ist DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL OPTIONS(description='Isttermin Ende'),
dat_start_vorhersage DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL OPTIONS(description='Prognosetermin Start'),
dat_ende_vorhersage DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL OPTIONS(description='Prognosetermin Ende'),
dat_start_einschraenkung DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL OPTIONS(description='Solltermin Start'),
dat_ende_einschraenkung DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL OPTIONS(description='Solltermin Ende'),
projekt_existiert_vor_14tage_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Flag: War das Projekt vor 14 Tagen (actual date - 14) existent (1 = existent)'),
dat_start_ist_minus_14 DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL
OPTIONS(description='Isttermin Start - Stand vor 14 Tagen'),
dat_ende_ist_minus_14 DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL
OPTIONS(description='Isttermin Ende - Stand vor 14 Tagen'),
dat_start_vorhersage_minus_14 DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL
OPTIONS(description='Prognosetermin Start - Stand vor 14 Tagen'),
dat_ende_vorhersage_minus_14 DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL
OPTIONS(description='Prognosetermin Ende - Stand vor 14 Tagen'),
dat_start_einschraenkung_minus_14 DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL
OPTIONS(description='Solltermin Start - Stand vor 14 Tagen'),
dat_ende_einschraenkung_minus_14 DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL
OPTIONS(description='Solltermin Ende  - Stand vor 14 Tagen'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (projekt_unter_id) NOT ENFORCED
) OPTIONS(description='IOS - Tabelle für die korrekte Zuordnung von Terminen zu Bauabschnitten und Projekten');