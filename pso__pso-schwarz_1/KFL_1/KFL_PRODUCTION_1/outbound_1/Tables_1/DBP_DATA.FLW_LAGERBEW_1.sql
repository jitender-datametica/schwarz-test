--==============================================================
-- Table: flw_lagerbew_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_lagerbew_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:40 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_lagerbew_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH. In der Regel länderbezogen'),
lagerbew_beleg_id INTEGER NOT NULL
OPTIONS(description='Das Feld enthält die ID der Lagerbewegung und dient zusammen mit dem Kalenderjahr der eindeutigen Identifikation der Lagerbewegung.'),
kj BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderjahr, Format JJJJ'),
vorgangsart_id STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Gibt einen Schlüssel zur Identifizierung einer Vorgangsart (z.B. WE für Wareneingang zur Bestellung) an. Quelle ist mkpf.vgart'),
dat_beleg DATE NOT NULL
OPTIONS(description='Das Belegdatum gibt das Ausstellungsdatum des Originalbeleges an. Quelle ist mkpf.bldat'),
dat_buch DATE NOT NULL
OPTIONS(description='Datum, unter dem der Beleg in der Buchhaltung bzw. in der Kostenrechnung_1 erfasst wird. Quelle ist mkpf.budat'),
dat_erfasst DATE NOT NULL
OPTIONS(description='Gibt das Datum an, an dem der Materialbeleg erfasst wurde. Quelle ist mkpf.cpudt'),
ref_lagerbew_beleg_id STRING(20) COLLATE 'und:ci'
OPTIONS(description='Die Referenzbelegnummer  aus SAP XBLNR kann die Belegnummer beim Geschäftspartner enthalten. Quelle ist mkpf.xblnr. Compress -1'),
zeit_erfasst BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Zeitpunkt der Datenerfassung aus cputm'),
belegkopftext STRING(30) COLLATE 'und:ci' OPTIONS(description='Belegkopftext aus bktxt. Compress blank'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, lagerbew_beleg_id, kj) NOT ENFORCED
) OPTIONS(description='FLW - Lagerbewegungen Kopfdaten aus Quelle SAP mkpf');