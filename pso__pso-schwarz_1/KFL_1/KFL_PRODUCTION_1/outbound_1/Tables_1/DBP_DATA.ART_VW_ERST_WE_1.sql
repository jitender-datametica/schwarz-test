--==============================================================
-- Table: art_vw_erst_we_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_vw_erst_we_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_vw_erst_we_1 (
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
vw_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Vertriebsweges'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
dat_erst_we DATE OPTIONS(description='Datum des ersten Wareneingangs'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (art_id, vw_id, mandant_id) NOT ENFORCED
) OPTIONS(description='TP2 AIS - Erster Wareneingang pro Artikel_1 und Vertriebsweg');