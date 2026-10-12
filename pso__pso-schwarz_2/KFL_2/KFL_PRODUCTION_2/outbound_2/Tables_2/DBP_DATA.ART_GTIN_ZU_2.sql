--==============================================================
-- Table: art_gtin_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_gtin_zu_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:31 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_gtin_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1'),
altnv_menge_einh_id STRING(3) NOT NULL OPTIONS(description='Mengeneinheit für Anzeige'),
lfd_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Laufende Nummer'),
gtin_id NUMERIC(26,0) NOT NULL OPTIONS(description='Global Trade Item_2 Number (GTIN)'),
gtin_typ_kz STRING(2) COLLATE 'und:ci' DEFAULT '  ' NOT NULL
OPTIONS(description='Nummerntyp der Global Trade Item_2 Number (z.B. G1 = Hersteller GTIN)'),
haupt_gtin_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Kennzeichen Haupt-GTIN (x=1)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_id, altnv_menge_einh_id, lfd_nr) NOT ENFORCED
) OPTIONS(description='EK-INTEGER  - Zuordnungstabelle GTIN (Global Trade Item_2 Number) zum Artikel_2 in SAP PR1 - MEAN_2');