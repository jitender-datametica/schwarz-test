--==============================================================
-- Table: flw_bestellart_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_bestellart_spr_zu_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_bestellart_spr_zu_1 (
bestellart_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID der Einkaufsbelegart aus bsart'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
bestell_typ_id STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Typ des Einkaufsbelegs aus bstyp. Z.Bsp. K für Kontrakte'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sprache im DWH'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
bestellart_bez STRING(20) COLLATE 'und:ci' NOT NULL OPTIONS(description='Bezeichnung der Einkaufsbelegart aus batxt'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
)
OPTIONS(description='FLW - Sprachabhängige Bezeichnung der Bestellarten aus t161t. Durch den Systemsplitt IND-FLW wird diese Tabelle überflüssig');