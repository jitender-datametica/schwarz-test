DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_DATA.ART_WUP_VK_PER_1;
CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ART_WUP_VK_PER_1 (
ART_ID INTEGER NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig);Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
DAT_VON DATE NOT NULL OPTIONS(description='Beginn der Gültigkeitsperiode\n            '),
DAT_BIS DATE NOT NULL
OPTIONS(description='Datum, bis zu dem die Zuordnung gilt. Bei bestehenden Zuordnungen: 9999-12-31'),
WRG_ID STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
VK_BRUTTO NUMERIC(9,2) NOT NULL OPTIONS(description='Verkaufspreis brutto'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (ART_ID, MANDANT_ID, WUP_ID, NB_ID, DAT_VON) NOT ENFORCED
) CLUSTER BY MANDANT_ID
OPTIONS(description='TP2_AIS - Verkaufspreise pro Markt. SAP-Quelle ist die Tabelle ZVKP_1');