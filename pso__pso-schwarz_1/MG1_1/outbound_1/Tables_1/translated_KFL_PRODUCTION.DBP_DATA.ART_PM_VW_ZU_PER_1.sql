CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ART_PM_VW_ZU_PER_1 (
ART_ID INTEGER NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
PM_ID INTEGER NOT NULL OPTIONS(description='Preismodul, Wert von 1 bis 10'),
VW_ID INTEGER NOT NULL OPTIONS(description='ID des Vertriebsweges'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
PREISTYP_ID INTEGER NOT NULL OPTIONS(description='ID des Preistyps'),
DAT_BIS DATE NOT NULL OPTIONS(description='Ende des Gueltigkeitszeitraums'),
DAT_VON DATE OPTIONS(description='Beginn des Gueltigkeitszeitraums'),
VK_BRUTTO NUMERIC(9,3) OPTIONS(description='Verkaufspreis Brutto des Artikels im jeweiligen Markt je Preiskategorie'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
WRG_ID STRING(3) COLLATE 'und:ci' OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
PRIMARY KEY (ART_ID, PM_ID, VW_ID, MANDANT_ID, PREISTYP_ID, DAT_BIS) NOT ENFORCED
)
OPTIONS(description='TP2 AIS - Zuordnung der Artikel_1 zu Preismodul, Vertriebsweg und Preistyp - MULTISET\n             Enthaelt Informationen, wie Verkaufspreise je Preiskategorie zum Artikel_1 und Vertriebsweg zugeordnet sind.');