--==============================================================
-- Table: rpm_element_per_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: rpm_element_per_2
   generated from Powerdesigner on Dienstag, 18. Januar 2022 13:34:47
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.rpm_element_per_2 (
dat_von DATE NOT NULL OPTIONS(description='Datum, ab dem der Datensatz gueltig ist'),
rpm_hierarchie_id STRING(32) COLLATE 'und:ci' NOT NULL OPTIONS(description='Eindeutige ID der Immobilie'),
rpm_immobilie_id STRING(32) COLLATE 'und:ci'
OPTIONS(description='Eindeutige ID der Immobilie, auf die sich das Element bezieht aus initiative_guid'),
projekt_id STRING(32) COLLATE 'und:ci' NOT NULL OPTIONS(description='Eindeutige ID des Projekts'),
dat_bis DATE NOT NULL
OPTIONS(description='Datum, bis zu dem der Datensatz gueltig ist. Ist dieses Datum nicht bekannt, wird der 31.12.9999 eingestellt.'),
rpm_status_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Status_2 eines Projekts (Massnahme)'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
dat_start_prognose DATE OPTIONS(description='Startdatum Prognose aus forecast start'),
dat_start_plan DATE OPTIONS(description='Geplantes Startdatum aus planned start'),
dat_start DATE OPTIONS(description='Tatsaechliches Startdatum'),
dat_ende_prognose DATE OPTIONS(description='Endedatum Prognose aus forecast finish'),
dat_ende_plan DATE OPTIONS(description='Geplantes Endedatum aus planned finish'),
dat_ende DATE OPTIONS(description='Tatsaechliches Endedatum aus actual finish'),
land_id STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Land_2, in dem sich der Markt befindet. Hat immer Laenge von 2 Zeichen (PL, CZ, DE,..). Im Quellsystem SAP hat das Feld 3 Zeichen'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
strasse STRING(80) COLLATE 'und:ci' OPTIONS(description='Strasse des Objekts aus zppm_strasse'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_2 ID wird verwendet fuer Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0)
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
bereich_name STRING(3) COLLATE 'und:ci' OPTIONS(description='Bereichsname, Auswahlfeld aus zppm_bername'),
wup_standort STRING(40) COLLATE 'und:ci' OPTIONS(description='Standort aus zppm_standort'),
plz STRING(10) COLLATE 'und:ci' OPTIONS(description='Postleitzahl aus zppm_plz'),
expansionauftrag_nr STRING(10) COLLATE 'und:ci' OPTIONS(description='Nummer des Expansionsauftrags aus zppm_expauftr'),
eigenentw STRING(40) COLLATE 'und:ci' OPTIONS(description='Eigenentwicklung Text aus zppm_eigenentw. COMPRESS'),
angebot_nr STRING(10) COLLATE 'und:ci' OPTIONS(description='Angebotsnummer Expansion aus zppm_ang_nr'),
auftraggeber_name STRING(30) COLLATE 'und:ci' OPTIONS(description='Name des Auftraggebers aus zppm_auftrgeb'),
objekt_planer_name STRING(30) COLLATE 'und:ci' OPTIONS(description='Name des Objektplaners aus zppm_objplan'),
gj_umbvorschl BIGNUMERIC(38,0) OPTIONS(description='Umbauvorschlag - Geschaeftsjahr aus zppm_umbvorschl'),
rpm_projekt_typ_id STRING(20) COLLATE 'und:ci'
OPTIONS(description='Eindeutige ID fuer den Projekttyp eines Projekts (Massnahme) aus phase_t'),
rpm_phase_id STRING(20) COLLATE 'und:ci' OPTIONS(description='Phase ID, z.Bsp. ZPPM_EP_5 aus rpmphas'),
testmarkt_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Testmarkt-Flag aus zppm_testmarkt'),
massnahmentyp_id BIGNUMERIC(38,0) OPTIONS(description='ID des Maßnahmentyps'),
besitzverhaeltnis_id STRING(3) COLLATE 'und:ci' OPTIONS(description='ID des Besitzverhaeltnis'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='RPM - Projekte (Massnahmen) zu einer Immobilie (SOLL) aus item_d');