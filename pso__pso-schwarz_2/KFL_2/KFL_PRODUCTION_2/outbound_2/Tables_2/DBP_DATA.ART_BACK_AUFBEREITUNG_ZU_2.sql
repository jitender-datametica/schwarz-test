--==============================================================
-- Table: art_back_aufbereitung_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_back_aufbereitung_zu_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_back_aufbereitung_zu_2 (
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
back_aufbereitung_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='eindeutige ID der Back-Aufbereitung aus dem Quellfeld ID, z.Bsp. 1'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (art_id, mandant_id, back_aufbereitung_id) NOT ENFORCED
) OPTIONS(description='VIS Backshop - Zuordnung von Aufbereitungsanweisungen  zu Artikeln');