--==============================================================
-- Table: art_back_hinweis_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_back_hinweis_zu_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_back_hinweis_zu_1 (
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
back_hinweis_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='eindeutige ID für den Back-Hinweis aus dem Quellfeld ID'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (art_id, mandant_id, back_hinweis_id) NOT ENFORCED
) OPTIONS(description='VIS Backshop - Zuordnung von Backhinweisen zu Artikeln');