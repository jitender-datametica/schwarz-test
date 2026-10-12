--==============================================================
-- Table: art_ofentyp_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_ofentyp_zu
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_ofentyp_zu (
art_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH Artikelnummer'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
ofen_typ_id STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID des Ofentyps aus dem Quellfeld oventype, z.Bsp. A.'),
blech_belegung BIGNUMERIC(38,0) NOT NULL OPTIONS(description='optimale Anzahl des Artikels pro Backblech'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (art_id, mandant_id) NOT ENFORCED
)
OPTIONS(description='VIS Backshop - Diese Tabelle ordnet den Artikeln die Ofentypen zu. Quelle ist die SAP-Klassenbibliothek');