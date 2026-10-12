--==============================================================
-- Table: art_art_gruppe_flw_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_art_gruppe_flw_1
   generated from Powerdesigner on Mittwoch, 30. November 2022 14:51:46
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_art_gruppe_flw_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_1 ID, Input: Artikel_1 - Id einschließlich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1.'),
art_gruppe_id STRING(5) OPTIONS(description='ID der Artikel_1-Gruppierung (System generiert im DWH).'),
art_gruppe_bez STRING(40) OPTIONS(description='Artikelgruppe Bezeichnung.'),
art_klasse_id STRING(5) OPTIONS(description='Artikelklasse ID.'),
art_klasse_bez STRING(40) OPTIONS(description='Artikelklasse Bezeichnung.'),
art_rohstoff_id STRING(5) OPTIONS(description='Artikelrohstoff ID.'),
art_rohstoff_bez STRING(40) OPTIONS(description='Artikelrohstoff Bezeichnung.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_id) NOT ENFORCED
) OPTIONS(description='Zuordnung Artikel_1 zu Artikelgruppe, -klasse und Rohostoff');