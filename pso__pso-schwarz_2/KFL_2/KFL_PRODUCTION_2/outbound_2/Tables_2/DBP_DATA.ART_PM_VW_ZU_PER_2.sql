--==============================================================
-- Table: art_pm_vw_zu_per_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_pm_vw_zu_per_2
   generated from Powerdesigner on Mittwoch, 10. August 2022 17:28:26
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_pm_vw_zu_per_2 (
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1'),
pm_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Preismodul, Wert von 1 bis 10'),
vw_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Vertriebsweges'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
preistyp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Preistyps'),
dat_bis DATE NOT NULL OPTIONS(description='Ende des Gueltigkeitszeitraums'),
wrg_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
dat_von DATE OPTIONS(description='Beginn des Gueltigkeitszeitraums'),
vk_brutto NUMERIC(9,3) OPTIONS(description='Verkaufspreis Brutto des Artikels im jeweiligen Markt je Preiskategorie'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (art_id, pm_id, vw_id, mandant_id, preistyp_id, dat_bis) NOT ENFORCED
)
OPTIONS(description='TP2 AIS - Zuordnung der Artikel_2 zu Preismodul, Vertriebsweg und Preistyp - MULTISET             Enthaelt Informationen, wie Verkaufspreise je Preiskategorie zum Artikel_2 und Vertriebsweg zugeordnet sind.');