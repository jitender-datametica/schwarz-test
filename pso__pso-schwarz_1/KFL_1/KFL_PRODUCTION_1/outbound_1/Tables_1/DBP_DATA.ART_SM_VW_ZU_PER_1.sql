--==============================================================
-- Table: art_sm_vw_zu_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_sm_vw_zu_per_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_sm_vw_zu_per_1 (
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
vw_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Vertriebsweges'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
dat_von DATE NOT NULL OPTIONS(description='Beginn des Gültigkeitszeitraums'),
dat_bis DATE NOT NULL OPTIONS(description='Ende der Gültigkeitsperiode. Format JJJJ-MM_1-TT'),
sm_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Sortimentsmodul ID. Es gibt 5 Sortimentsstufen, von 1 bis 5. -1: keine Sortimentsstufe zugeordnet'),
ksm_id STRING(4) COLLATE 'und:ci'
OPTIONS(description='Kaufland Sortimentsmodul, das in den KMO Ländern eingeführt wurde für parallele Listungen zu sm_id.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (art_id, vw_id, mandant_id, dat_von) NOT ENFORCED
)
OPTIONS(description='AIS_KMO - Zuordnung der Artikel_1 zu Sortimentsmodul und Vertriebsweg aus der Quelle mvke_1 - MULTISET');