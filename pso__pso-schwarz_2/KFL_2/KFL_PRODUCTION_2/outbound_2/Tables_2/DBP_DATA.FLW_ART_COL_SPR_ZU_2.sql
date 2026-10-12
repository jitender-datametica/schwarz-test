--==============================================================
-- Table: flw_art_col_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_art_col_spr_zu_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_art_col_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH. In der Regel länderbezogen'),
flw_art_col_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Attributs - hier Artikelhierarchiestufe - eine_2 Zahl zwischen 1 und 7'),
art_col_auspr STRING(5) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Ausprägung des Attributs/ der Stufe, z.Bsp FFERT oder 01'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sprache im DWH'),
art_col_bez STRING(40) COLLATE 'und:ci' NOT NULL OPTIONS(description='Bezeichnung des Attributs, z.Bsp. Rind'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, flw_art_col_id, spr_id) NOT ENFORCED
) OPTIONS(description='FLW -Bezeichnungen der Attribute der Artikelstammdaten (Produkthierarchiestufen)');