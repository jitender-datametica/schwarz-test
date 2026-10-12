--==============================================================
-- Table: art_art_nielsen_matching_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_art_nielsen_matching_zu_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_art_nielsen_matching_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
art_nielsen_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikel_1-ID aus Nielsen'),
gtin_id NUMERIC(26,0) NOT NULL OPTIONS(description='Global Trade Item_1 Number (GTIN)'),
art_matching_id BIGNUMERIC(38,0)
OPTIONS(description='Gruppierungskriterium für Artikel_1 (kann auch nur ein Artikel_1 sein), die über die GTIN zu Nielsen-Artikel_1 gematched werden'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_id, art_nielsen_id) NOT ENFORCED
) OPTIONS(description='EK-INTEGER  - Mappingtabelle Nielsen-Artikel_1 zu  Kaufland Artikel_1');