--==============================================================
-- Table: cpr_cl_punkt_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cpr_cl_punkt_per_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.cpr_cl_punkt_per_1 (
checkliste_punkt_id STRING(32) COLLATE 'und:ci' NOT NULL OPTIONS(description='Eindeutige ID eines Checklistenpunkts'),
dat_von DATE NOT NULL OPTIONS(description='Datum, ab dem der Datensatz gültig ist'),
dat_bis DATE NOT NULL
OPTIONS(description='Datum, bis zu dem der Datensatz gültig ist. Ist dieses Datum nicht bekannt, wird der 31.12.9999 eingestellt.'),
cpr_checkliste_id STRING(32) COLLATE 'und:ci'
OPTIONS(description='Eindeutige ID einer Projekt-Checkliste aus xlccheckl'),
cpr_apprel BIGNUMERIC(38,0) OPTIONS(description='???'),
aenderbar_kz STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Kennzeichnet die Änderbarkeit des Checklistenpunkts'),
cl_punkt_gruppe_id STRING(40) COLLATE 'und:ci' OPTIONS(description='Gruppierungsmerkmal'),
nicht_ok_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Gleich 1, wenn nicht ok'),
nicht_relevant_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='gleich 1, wenn nicht relevant'),
obligatorisch_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='gleich 1, wenn obligatorisch'),
ok_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='gleich 1, wenn ok'),
sortier_nummer BIGNUMERIC(38,0) OPTIONS(description='interne Sortiernummer aus der Schnittstelle'),
dat_start_ist DATE OPTIONS(description='tatsächliches Startdatum'),
dat_ende_ist DATE OPTIONS(description='tatsächliches Endedatum'),
dat_start_max DATE OPTIONS(description='spätest_1 mögliches Startdatum'),
dat_ende_max DATE OPTIONS(description='spätest_1 mögliches Endedatum'),
dat_start_plan DATE OPTIONS(description='geplantes Startdatum'),
dat_ende_plan DATE OPTIONS(description='geplantes Endedatum'),
term_einschr_typ STRING(1) COLLATE 'und:ci' OPTIONS(description='Art_1 der terminlichen Einschränkung'),
dat_start_einschraenkung DATE OPTIONS(description='Einschränkungsdatum'),
termin_einschraenk_kz STRING(1) COLLATE 'und:ci'
OPTIONS(description='Kennzeichen der terminlichen Einschränkung, z.Bsp. 7'),
dat_ende_einschraenkung DATE OPTIONS(description='weiteres Einschränkungsdatum'),
gesamt_puffer NUMERIC(18,3) OPTIONS(description='Gesamtpuffer in ???'),
cpr_prio BIGNUMERIC(38,0) OPTIONS(description='Angabe zur Priorität'),
cpr_systemstatus1_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Schluessel für den Systemstatus1, Enthält numerische Werte von 1 aufsteigend'),
cpr_systemstatus3_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Schluessel für den Systemstatus3.  Enthält numerische Werte von 1 aufsteigend'),
cpr_systemstatus2_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Schluessel für den Systemstatus2.  Enthält numerische Werte von 1 aufsteigend'),
cpr_suchfeld_id BIGNUMERIC(38,0)
OPTIONS(description='Diese ID wird bei der Versorgung aus dem von der Quelle gelieferten Feld generiert'),
dat_erstellung DATE NOT NULL OPTIONS(description='Anlagedatum'),
sortier_nr_mhrwrtgkt BIGNUMERIC(38,0) DEFAULT 1 NOT NULL
OPTIONS(description='Rangfolge bei mehreren gleichwertigen CL-Punkten. Wird im Versorgungsprozess ermittelt.'),
dat_start_vorhersage DATE OPTIONS(description='Prognostizierter Starttermin aus forecast_start'),
dat_ende_vorhersage DATE OPTIONS(description='Prognostizierter Endetermin aus forecast_ende'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (dat_von) NOT ENFORCED
) OPTIONS(description='IOS - Items und Termine zu den Checklisten');