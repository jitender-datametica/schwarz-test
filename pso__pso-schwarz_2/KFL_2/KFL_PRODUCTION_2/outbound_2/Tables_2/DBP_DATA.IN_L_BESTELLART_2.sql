--==============================================================
-- Table: in_l_bestellart_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_l_bestellart_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_l_bestellart_2 (
bestellart_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID der Einkaufsbelegart aus bsart'),
mandant_id BIGNUMERIC(38,0) NOT NULL,
bestell_typ_id STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Typ des Einkaufsbelegs aus bstyp. Z.Bsp. K für Kontrakte'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id) NOT ENFORCED
) OPTIONS(description='BIS- Lookuptabelle der Bestellarten aus t161t.');