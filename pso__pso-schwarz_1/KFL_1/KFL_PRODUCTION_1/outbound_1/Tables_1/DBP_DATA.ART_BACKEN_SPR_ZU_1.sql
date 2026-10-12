--==============================================================
-- Table: art_backen_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_backen_spr_zu_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_backen_spr_zu_1 (
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache            '),
art_backen_bez STRING(50) COLLATE 'und:ci' OPTIONS(description='Artikelbezeichnung speziell für den Backshop'),
feierabend_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (art_id, mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='VIS Backshop - Im Backshop werden von den Stammdaten abweichende Artikelbezeichnungen verwendet');