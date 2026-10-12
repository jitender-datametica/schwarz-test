--==============================================================
-- Table: art_zek_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_zek_zu_1
   generated from Powerdesigner on Donnerstag, 31. August 2023 10:03:15
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.art_zek_zu_1 (
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
zek_id STRING(3) NOT NULL
OPTIONS(description='Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (art_id, mandant_id, zek_id) NOT ENFORCED
) OPTIONS(description='AIS_KMO - alle Artikel_1, die zu sehen ein Zentraleinkäufer berechtigt ist - MULTISET');