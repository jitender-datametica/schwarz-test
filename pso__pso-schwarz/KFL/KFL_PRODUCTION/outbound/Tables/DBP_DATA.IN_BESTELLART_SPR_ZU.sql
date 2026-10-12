--==============================================================
-- Table: in_bestellart_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_bestellart_spr_zu
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_bestellart_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
bestellart_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID der Einkaufsbelegart aus bsart'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sprache im DWH'),
bestell_typ_id STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Typ des Einkaufsbelegs aus bstyp. Z.Bsp. K für Kontrakte'),
bestellart_bez STRING(20) COLLATE 'und:ci' OPTIONS(description='Bezeichnung der Einkaufsbelegart aus batxt'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='BIS- Sprachabhängige Bezeichnung der Bestellarten aus t161t');