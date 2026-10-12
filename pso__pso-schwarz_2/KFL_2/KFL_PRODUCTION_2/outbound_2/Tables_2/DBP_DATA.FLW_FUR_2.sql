--==============================================================
-- Table: flw_fur_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_fur_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_fur_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
flw_art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.'),
flw_kunde_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im DWH generierter Surrogate Key für die Kundennummer aus SAP'),
dat DATE NOT NULL OPTIONS(description='Auf dieses Datum bezieht sich die Prognose'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
menge_sicherheit NUMERIC(9,3) DEFAULT 0 NOT NULL OPTIONS(description='Sicherheitsbestand'),
menge_plan NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='Geplante Menge aus der FuR-Prognose'),
dat_erstellung DATE NOT NULL OPTIONS(description='Erstelldatum der Prognose'),
einh_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID der Internationalen Maßeinheit aus msehi'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, flw_art_id, flw_kunde_id, dat) NOT ENFORCED
) OPTIONS(description='FLW - Prognosedaten aus der Anwendung Forecast & Replenishment - Multiset');