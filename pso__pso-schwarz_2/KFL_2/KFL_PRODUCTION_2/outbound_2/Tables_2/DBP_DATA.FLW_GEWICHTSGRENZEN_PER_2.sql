--==============================================================
-- Table: flw_gewichtsgrenzen_per_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_gewichtsgrenzen_per_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_gewichtsgrenzen_per_2 (
flw_art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.'),
dat_von DATE NOT NULL OPTIONS(description='Datum, ab dem der Satz gültig ist'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
system_id BIGNUMERIC(38,0) OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
dat_bis DATE NOT NULL
OPTIONS(description='Datum, bis zu dem der Satz gültig ist. Bei aktuell gültigen Sätzen = 31.12.9999'),
gewicht_kg_von NUMERIC(18,3) NOT NULL OPTIONS(description='Gewichts-Untergrenze in Kilogramm'),
gewicht_kg_bis NUMERIC(18,3) NOT NULL OPTIONS(description='Gewichts-Obergrenze in Kilogramm'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (flw_art_id, dat_von, mandant_id) NOT ENFORCED
)
OPTIONS(description='FLW - historisierte Gewichtsgrenzen gemäß der KL- Spezifikationen. Basis für EK- und für SB - Gewichtsgrenzen. Quelle ist Hyperion');