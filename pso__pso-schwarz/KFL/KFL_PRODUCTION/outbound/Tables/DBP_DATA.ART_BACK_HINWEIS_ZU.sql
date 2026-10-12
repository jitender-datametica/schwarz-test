--==============================================================
-- Table: art_back_hinweis_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_back_hinweis_zu
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_back_hinweis_zu (
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
back_hinweis_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='eindeutige ID für den Back-Hinweis aus dem Quellfeld ID'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (art_id, mandant_id, back_hinweis_id) NOT ENFORCED
) OPTIONS(description='VIS Backshop - Zuordnung von Backhinweisen zu Artikeln');