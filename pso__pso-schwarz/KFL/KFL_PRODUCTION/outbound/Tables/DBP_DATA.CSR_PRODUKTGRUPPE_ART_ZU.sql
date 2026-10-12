--==============================================================
-- Table: csr_produktgruppe_art_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: csr_produktgruppe_art_zu
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.csr_produktgruppe_art_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
csr_produktgruppe_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der CSR-Produktgruppe (bspw. Food-Eigenmarken)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_id, csr_produktgruppe_id) NOT ENFORCED
) OPTIONS(description='AIS - Zuordnungstabelle Artikel zu CSR-Produktgruppe');