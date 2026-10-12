--==============================================================
-- Table: cpr_aufgabe_per_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cpr_aufgabe_per_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.cpr_aufgabe_per_2 (
cpr_aufgabe_id STRING(32) COLLATE 'und:ci' NOT NULL OPTIONS(description='Eindeutige ID der Aufgabe aus xlctask'),
dat_von DATE NOT NULL OPTIONS(description='Datum, ab dem der Datensatz gültig ist'),
dat_bis DATE NOT NULL
OPTIONS(description='Datum, bis zu dem der Datensatz gültig ist. Ist dieses Datum nicht bekannt, wird der 31.12.9999 eingestellt.'),
projekt_phase_id STRING(32) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutige ID einer Projektphase aus xlcphase'),
cpr_suchfeld_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Diese ID wird bei der Versorgung aus dem von der Quelle gelieferten Feld generiert'),
aufgabenart_id STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID der Aufgabenart. In der Regel werden nur 2 Byte benutzt'),
sortier_nummer BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='interne Sortiernummer aus der Schnittstelle aus cpr_sort_nr'),
dat_start_ist DATE OPTIONS(description='tatsächliches Startdatum aus actualstartdate'),
dat_ende_ist DATE OPTIONS(description='tatsächliches Endedatum aus actualfinishdate'),
dat_start_plan DATE OPTIONS(description='geplantes Startdatum aus planstartdate'),
dat_ende_plan DATE OPTIONS(description='geplantes Endedatum aus planfinishdate'),
dat_start_max DATE OPTIONS(description='Spätest_2 mögliches Startdatum aus lateststartdate'),
dat_ende_max DATE OPTIONS(description='Spätest_2 mögliches Endedatum aus latest_finishdate'),
cpr_systemstatus1_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Schluessel für den Systemstatus1, Enthält numerische Werte von 1 aufsteigend. Aus xlcstat1'),
cpr_systemstatus2_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Schluessel für den Systemstatus2.  Enthält numerische Werte von 1 aufsteigend aus xlcstat2'),
cpr_systemstatus3_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Schluessel für den Systemstatus3.  Enthält numerische Werte von 1 aufsteigend aus xlcstat3'),
cpr_duunit STRING(3) COLLATE 'und:ci' OPTIONS(description='Einheit der Dauer (Tage,Stunden_2,..) aus cpr_duunit'),
dauer NUMERIC(18,3) OPTIONS(description='Dauer in Einheit cpr_duunit aus cpr_durati'),
dat_start_einschraenkung DATE OPTIONS(description='Einschränkungsdatum aus cpr_constr'),
dat_ende_einschraenkung DATE OPTIONS(description='weiteres Einschränkungsdatum aus cpr_confin'),
cpr_prio BIGNUMERIC(38,0) OPTIONS(description='Angabe zur Priorität aus cpr_prio'),
gesamt_puffer NUMERIC(18,3) OPTIONS(description='Gesamtpuffer in ??? aus cpr_buffer'),
dat_start_vorhersage DATE OPTIONS(description='Prognostizierter Starttermin aus forecast_start'),
dat_ende_vorhersage DATE OPTIONS(description='Prognostizierter Endetermin aus forecast_ende'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (dat_von) NOT ENFORCED
) OPTIONS(description='IOS - Aufgaben aus dem System cProjects aus der Quelle ctask');