--==============================================================
-- Table: art_lagernummer_zu_per_ewm_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_lagernummer_zu_per_ewm_2
   generated from Powerdesigner on Mittwoch, 26. Januar 2022 07:47:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_lagernummer_zu_per_ewm_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
art_guid_c22 STRING(22) NOT NULL OPTIONS(description='Materialnummer STRING 22'),
art_id BIGNUMERIC(38,0) OPTIONS(description='Artikelnummer       '),
scu_guid STRING(32) NOT NULL OPTIONS(description='GUID für Supply-Chain-Unit_2'),
lagernummer_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Lagernummer/Lagerkomplex'),
verfuegungsberechtigter_guid STRING(32) NOT NULL OPTIONS(description='Verfügungsberechtigter (GUID)'),
dat_von DATE NOT NULL OPTIONS(description='YYYY-MM_2-DD // Aktion_2 gültig (von)'),
dat_bis DATE OPTIONS(description='YYYY-MM_2-DD // Aktion_2 gültig (bis)'),
loesch_fg BIGNUMERIC(38,0) OPTIONS(description='Löschvormerkung'),
einlager_steuerung_id STRING(4) OPTIONS(description='Einlagerungssteuerung'),
lagerplatztyp_id STRING(4) OPTIONS(description='Lagerplatztyp'),
blocklagertyp_id STRING(4) OPTIONS(description='Blocklager'),
auslager_steuerung_id STRING(4) OPTIONS(description='Lagerbereichskennzeichen'),
lagerbereichskennzeichen_id STRING(4) OPTIONS(description='Auslagerungssteuerung'),
verpackungsklasse_id STRING(2) OPTIONS(description='Kaufland Verpackungsklasse'),
anz_ladtraeger_max INTEGER OPTIONS(description='Kaufland-Spezifische Informationen max Ladungsträger'),
artikelsortiment_id STRING(1) OPTIONS(description='Kauflandspezifische Info Sortiments ID'),
referenzgewicht_id NUMERIC(15,3) OPTIONS(description='referenzgewicht_id'),
dat_we_check DATE OPTIONS(description='Kaufland-specific information GR Check Date'),
anz_tage_bis_we_check BIGNUMERIC(38,0) OPTIONS(description='Kaufland-specific information GR Check Countdown'),
stellplatz_faktor NUMERIC(5,2) OPTIONS(description='Stellplatzfaktor'),
automation_kennz STRING(1) OPTIONS(description='Kennzeichen Automation'),
datzeit_aenderung NUMERIC(15) OPTIONS(description='Zeitpunkt an dem das Objekt zuletzt geändert wurde'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Materialdaten pro Lagernummer');