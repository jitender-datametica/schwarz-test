--==============================================================
-- Table: flw_besch_partner_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_besch_partner_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_besch_partner_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH. In der Regel länderbezogen'),
faktura_beleg_id INTEGER NOT NULL OPTIONS(description='Faktura Belegnummer aus vbeln'),
partner_verwendung_id STRING(2) COLLATE 'und:ci' NOT NULL OPTIONS(description='aus parvw'),
faktura_beleg_pos_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Belegposition aus posnr'),
flw_kunde_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im DWH generierter Surrogate Key für die Kundennummer aus SAP'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, faktura_beleg_id, faktura_beleg_pos_id) NOT ENFORCED
) OPTIONS(description='FLW - Partnertabelle aus SAP VBPA');