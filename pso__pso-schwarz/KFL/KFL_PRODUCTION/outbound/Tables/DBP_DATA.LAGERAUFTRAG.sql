--==============================================================
-- Table: lagerauftrag
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: lagerauftrag
   generated from Powerdesigner on Mittwoch, 26. Januar 2022 07:21:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.lagerauftrag (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
lagernummer_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Lagernummer/Lagerkomplex      '),
lagerauftrag_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Lagerauftragsnummer'),
wcr_id STRING(4) COLLATE 'und:ci' OPTIONS(description='Lagerauftragserstellungsregel    '),
wcr_typ_id STRING(1) COLLATE 'und:ci' OPTIONS(description='Typ einer Lagerauftragerstellungsregel '),
lagerprozessart_id_belegkopf STRING(4) COLLATE 'und:ci' OPTIONS(description='Belegkopf-Lagerprozessart     '),
welle_id BIGNUMERIC(38,0) OPTIONS(description='Welle'),
lagerauftrag_status_id STRING(1) COLLATE 'und:ci' OPTIONS(description='Status des Lagerauftrags  '),
aktivitaetsbereich_id STRING(4) COLLATE 'und:ci' OPTIONS(description='Aktivitätsbereich'),
lagertyp_id STRING(4) COLLATE 'und:ci' OPTIONS(description='Lagertyp       '),
lagerplatz_id STRING(18) COLLATE 'und:ci' OPTIONS(description='Lagerplatz'),
queue_id STRING(10) COLLATE 'und:ci' OPTIONS(description='Queue'),
startzeit_fixiert_fg BIGNUMERIC(38,0) OPTIONS(description='Startzeit des Lagerauftrags fixiert         '),
ressource_id STRING(18) COLLATE 'und:ci' OPTIONS(description='Ressource (Transportmittel oder Benutzer)'),
manuelle_zuordnung_fg BIGNUMERIC(38,0) OPTIONS(description='Manuelle Zuordnung des Bearbeiters    '),
inventur_fg BIGNUMERIC(38,0) OPTIONS(description='Lagerauftrag beinhaltet Inventurbeleg   '),
lagerauftrag_id_split BIGNUMERIC(38,0) OPTIONS(description='Lagerauftragsnummer'),
split_fg BIGNUMERIC(38,0) OPTIONS(description='Lagerauftrag wurde gesplittet   '),
lagerplatz_id_start STRING(18) COLLATE 'und:ci' OPTIONS(description='Startplatz für bearbeitende Ressource      '),
lagerauftrag_bez STRING(40) COLLATE 'und:ci' OPTIONS(description='Bezeichnung    '),
handling_unit_id_joining STRING(20) COLLATE 'und:ci' OPTIONS(description='Joining HU   '),
nachschub_option_id BIGNUMERIC(38,0) OPTIONS(description='Nachschub option   '),
dauer_geplant BIGNUMERIC(38,0) OPTIONS(description='Geplante Ausführungszeit des Lagerauftrags  '),
menge_einh_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Lagerauftrag: Zeiteinheit   '),
lagerauftrag_guid STRING(32) OPTIONS(description='Eindeutige Identifikation des Lagerauftrags   '),
datzeit_start DATETIME OPTIONS(description='Startzeit in Lagerzeitzone       '),
datzeit_start_max DATETIME OPTIONS(description='Späteste Startzeit in Lagerzeitzone  '),
datzeit_erstellung DATETIME OPTIONS(description='Erstellungszeit in Lagerzeitzone  '),
datzeit_bestaetigung DATETIME OPTIONS(description='Bestätigungszeit in Lagerzeitzone '),
datzeit_aenderung DATETIME OPTIONS(description='Änderungszeit in Lagerzeitzone '),
datzeit_lsd_berechnung DATETIME OPTIONS(description='Uhrzeit, zu der der SST berechnet wurde '),
lsd_berechnungsart_id STRING(1) COLLATE 'und:ci' OPTIONS(description='Berechnungsmethode für SST'),
dat_bereitstellung DATE OPTIONS(description='Bereitstelldatum'),
zeit_bereitstellung TIME OPTIONS(description='Bereitstelllzeit'),
datzeit_bereitstellung DATETIME OPTIONS(description='Bereitstelllzeitstempel'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Lagerauftrag / Warehouse Order');