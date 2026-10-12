--==============================================================
-- Table: flw_qual_meldung_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_qual_meldung_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_qual_meldung_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
qual_meldung_id INTEGER NOT NULL OPTIONS(description='eindeutige ID der Qualitätsmeldung aus qmnum'),
meldungsart_id STRING(2) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID der Meldungsart aus qmart'),
flw_lief_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Lieferantennummer. Im DWH erzeugter numerischer Schlüssel'),
best_beleg_id INTEGER NOT NULL OPTIONS(description='Bestellbeleg aus ebeln'),
zeit_pforte BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Pfortenzeit. Wird aus qmtxt als String herausgelöst. Nullable, da nicht in allen Sätzen vorhanden'),
dat_erfasst DATE NOT NULL OPTIONS(description='Erfassdatum aus erdat'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, qual_meldung_id) NOT ENFORCED
) OPTIONS(description='FLW - Qualitätsmeldung aus qmel');