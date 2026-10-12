DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_DATA.ART_LIST_WUP_ZU_PER;
CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ART_LIST_WUP_ZU_PER (
ART_ID INTEGER NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
DAT_BIS DATE NOT NULL OPTIONS(description='Ende des Gültigkeitszeitraums'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
LIST_QUELLE_ID STRING(1) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Listungsquelle aus der SAP-Tabelle wlk1. Z.Bsp 5 = Bausteinlistung. Eine Lookup-Tabelle existiert im DWH nicht.'),
STRUKTUR_ART_ID INTEGER NOT NULL
OPTIONS(description='Artikel ID des strukturierten Artikels, dessen Bestandteil der gelistete Artikel ist. Falls es sich bei dem Artikel nicht um einen strukturierten Artikel handelt, ist die Artikel ID des Artikels selbst enthalten. Achtung! Hier schreibt die Versorgung eine kl_art_id rein!'),
BAUSTEIN_ID INTEGER NOT NULL OPTIONS(description='ID eines Sortimentsbausteins'),
DAT_VON DATE NOT NULL OPTIONS(description='Datum wann ein Artikel zum ersten Mal in einem Markt gelistet ist'),
LIST_SAP_ID INTEGER NOT NULL
OPTIONS(description='in SAP zusammen mit Markt / Artikel / gilt-ab ein eindeutiger Schlüssel. Wird benötigt, um Updates aus SAP eindeutig zuordnen zu können. Wertebereich von 1 - 999, Standard ist 1'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
LIST_KOMPONENTE_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Sagt ob die Listung des Artikels eigenständig erfolgt ist (0) oder als Komponente eines Display (1) gelistet wurde.'),
PRIMARY KEY (ART_ID, WUP_ID, NB_ID, MANDANT_ID, STRUKTUR_ART_ID, DAT_VON) NOT ENFORCED
) CLUSTER BY MANDANT_ID
OPTIONS(description='TP2/7 AIS - Zuordnung Artikel zu Listung, Baustein und Wup - MULTISET. Enthält Informationen, aus welchen Listungsquellen Artikel und Markt zugeordnet sind, d.h. welcher Artikel in welchem Markt in den jeweiligen Bausteinen gelistet ist.');