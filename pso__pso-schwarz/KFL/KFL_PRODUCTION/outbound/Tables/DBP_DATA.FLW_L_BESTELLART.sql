--==============================================================
-- Table: flw_l_bestellart
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_bestellart
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_l_bestellart (
bestellart_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID der Einkaufsbelegart aus bsart'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
bestell_typ_id STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Typ des Einkaufsbelegs aus bstyp. Z.Bsp. K für Kontrakte'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id) NOT ENFORCED
) OPTIONS(description='FLW - Lookuptabelle der Bestellarten aus t161t');