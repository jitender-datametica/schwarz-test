--==============================================================
-- Table: art_art_nielsen_matching_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_art_nielsen_matching_zu
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_art_nielsen_matching_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
art_nielsen_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikel-ID aus Nielsen'),
gtin_id NUMERIC(26,0) NOT NULL OPTIONS(description='Global Trade Item Number (GTIN)'),
art_matching_id BIGNUMERIC(38,0)
OPTIONS(description='Gruppierungskriterium für Artikel (kann auch nur ein Artikel sein), die über die GTIN zu Nielsen-Artikel gematched werden'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_id, art_nielsen_id) NOT ENFORCED
) OPTIONS(description='EK-INTEGER  - Mappingtabelle Nielsen-Artikel zu  Kaufland Artikel');