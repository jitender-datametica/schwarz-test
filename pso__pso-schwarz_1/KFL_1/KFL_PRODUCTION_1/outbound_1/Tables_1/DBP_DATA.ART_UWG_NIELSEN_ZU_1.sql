--==============================================================
-- Table: art_uwg_nielsen_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_uwg_nielsen_zu_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_uwg_nielsen_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
kl_uwg_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID Kaufland Unterwarengruppen für Nielsen-Daten (Vergabe im Beladeprozess)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_id, kl_uwg_id) NOT ENFORCED
) OPTIONS(description='EK-INTEGER  - Mappingtabelle Kaufland-Artikel_1 zu  Kaufland Unterwarengruppen für Nielsen');