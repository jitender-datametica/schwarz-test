--==============================================================
-- Table: flw_energiedaten_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_energiedaten_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_energiedaten_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
zaehler_id STRING(10) COLLATE 'und:ci' NOT NULL OPTIONS(description='Eindeutige ID des Zählers.'),
dat DATE NOT NULL
OPTIONS(description='Tagesdatum. Zählerstände können täglich oder monatlich gemeldet werden. Vergleichbarkeit nur auf Monatsebene gegeben.'),
pc_id STRING(10) COLLATE 'und:ci' NOT NULL OPTIONS(description='Eindeutiger Fachschluessel fuer die Profitcenter'),
krk_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='globale ID des Kostenrechnungskreises'),
kjmo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Monat_1 eines Kalenderjahres, Format JJJJMM'),
menge_verbrauch BIGNUMERIC(38,5) NOT NULL OPTIONS(description='Verbrauchte Menge'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, dat) NOT ENFORCED
) OPTIONS(description='FLW - Verbrauchswerte pro Zähler');