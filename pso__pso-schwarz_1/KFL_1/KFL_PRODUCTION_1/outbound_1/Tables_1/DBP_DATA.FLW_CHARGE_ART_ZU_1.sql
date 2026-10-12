--==============================================================
-- Table: flw_charge_art_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_charge_art_zu_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_charge_art_zu_1 (
flw_art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.'),
charge_id STRING(10) COLLATE 'und:ci' NOT NULL OPTIONS(description='Charge aus charg'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
objekt_schluessel_id STRING(50) COLLATE 'und:ci' DEFAULT '-1' NOT NULL
OPTIONS(description='Schlüssel des zu klassifizierenden Objektes aus dbp_data.flw_art_1 ; flw_art_nr und dbp_data.flw_charge_art_zu_1 ; charge_id - DWH generiert'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (flw_art_id, mandant_id) NOT ENFORCED
) OPTIONS(description='FLW - Chargenverwaltung aus mch1');