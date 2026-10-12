--==============================================================
-- Table: csr_produktgruppe_art_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: csr_produktgruppe_art_zu_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.csr_produktgruppe_art_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
csr_produktgruppe_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der CSR-Produktgruppe (bspw. Food-Eigenmarken)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_id, csr_produktgruppe_id) NOT ENFORCED
) OPTIONS(description='AIS - Zuordnungstabelle Artikel_1 zu CSR-Produktgruppe');