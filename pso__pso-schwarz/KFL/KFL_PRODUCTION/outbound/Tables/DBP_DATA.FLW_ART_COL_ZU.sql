--==============================================================
-- Table: flw_art_col_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_art_col_zu
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_art_col_zu (
flw_art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.'),
flw_art_col_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Attributs - hier Artikelhierarchiestufe - eine Zahl zwischen 1 und 7'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
art_col_auspr STRING(5) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Ausprägung des Attributs/ der Stufe, z.Bsp FFERT oder 01'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (flw_art_id, flw_art_col_id, mandant_id) NOT ENFORCED
) OPTIONS(description='FLW - Zuordnung von Attributen zum Artikelstamm (hier Elemente der Produkthierarchie)');