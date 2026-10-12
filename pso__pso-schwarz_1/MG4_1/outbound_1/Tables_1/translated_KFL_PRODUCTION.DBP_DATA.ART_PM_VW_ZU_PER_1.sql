CREATE OR REPLACE TABLE kfl_production_dbp_data.art_pm_vw_zu_per_1 (
art_id INTEGER NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
pm_id INTEGER NOT NULL OPTIONS(description='Preismodul, Wert von 1 bis 10'),
vw_id INTEGER NOT NULL OPTIONS(description='ID des Vertriebsweges'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
preistyp_id INTEGER NOT NULL OPTIONS(description='ID des Preistyps'),
dat_bis DATE NOT NULL OPTIONS(description='Ende des Gueltigkeitszeitraums'),
dat_von DATE OPTIONS(description='Beginn des Gueltigkeitszeitraums'),
vk_brutto NUMERIC(9,3) OPTIONS(description='Verkaufspreis Brutto des Artikels im jeweiligen Markt je Preiskategorie'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
wrg_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
PRIMARY KEY (art_id, pm_id, vw_id, mandant_id, preistyp_id, dat_bis) NOT ENFORCED
)
OPTIONS(description='TP2 AIS - Zuordnung der Artikel_1 zu Preismodul, Vertriebsweg und Preistyp - MULTISET\n             Enthaelt Informationen, wie Verkaufspreise je Preiskategorie zum Artikel_1 und Vertriebsweg zugeordnet sind.');