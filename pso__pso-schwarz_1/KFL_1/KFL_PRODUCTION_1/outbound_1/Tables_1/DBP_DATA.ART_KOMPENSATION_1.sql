--==============================================================
-- Table: art_kompensation_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_kompensation_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:31 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_kompensation_1 (
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
komp_basismenge_einh_id STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Mengeneinheit des Kompensationsartikels. Kann abweichend von der normalen Mengeneinheit sein. Aus meins'),
art_id_ref BIGNUMERIC(38,0) OPTIONS(description='Artkel ID DWH - Kompensationsgruppe Referenzartikel'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (art_id, mandant_id) NOT ENFORCED
)
OPTIONS(description='WWC - Kompensationsartikel aus der Quelle zminvco_ar. Tabelle wird zunächst separat angelegt, die Attribute gehören aber prinzipiell in die Tabelle art_1');