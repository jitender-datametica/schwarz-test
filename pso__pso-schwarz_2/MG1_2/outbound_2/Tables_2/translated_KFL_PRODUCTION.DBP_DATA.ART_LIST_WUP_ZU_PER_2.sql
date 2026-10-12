DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_DATA.ART_LIST_WUP_ZU_PER_2;
CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ART_LIST_WUP_ZU_PER_2 (
ART_ID INTEGER NOT NULL
OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
DAT_BIS DATE NOT NULL OPTIONS(description='Ende des Gültigkeitszeitraums'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
LIST_QUELLE_ID STRING(1) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Listungsquelle aus der SAP-Tabelle wlk1. Z.Bsp 5 = Bausteinlistung. Eine_2 Lookup-Tabelle existiert im DWH nicht.'),
STRUKTUR_ART_ID INTEGER NOT NULL
OPTIONS(description='Artikel_2 ID des strukturierten Artikels, dessen Bestandteil der gelistete Artikel_2 ist. Falls es sich bei dem Artikel_2 nicht um einen strukturierten Artikel_2 handelt, ist die Artikel_2 ID des Artikels selbst enthalten. Achtung! Hier schreibt die Versorgung eine_2 kl_art_id rein!'),
BAUSTEIN_ID INTEGER NOT NULL OPTIONS(description='ID eines Sortimentsbausteins'),
DAT_VON DATE NOT NULL OPTIONS(description='Datum wann ein Artikel_2 zum ersten Mal in einem Markt gelistet ist'),
LIST_SAP_ID INTEGER NOT NULL
OPTIONS(description='in SAP zusammen mit Markt / Artikel_2 / gilt-ab ein eindeutiger Schlüssel. Wird benötigt, um Updates aus SAP eindeutig zuordnen zu können. Wertebereich von 1 - 999, Standard ist 1'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
LIST_KOMPONENTE_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Sagt ob die Listung des Artikels eigenständig erfolgt ist (0) oder als Komponente eines Display (1) gelistet wurde.'),
PRIMARY KEY (ART_ID, WUP_ID, NB_ID, MANDANT_ID, STRUKTUR_ART_ID, DAT_VON) NOT ENFORCED
) CLUSTER BY MANDANT_ID
OPTIONS(description='TP2/7 AIS - Zuordnung Artikel_2 zu Listung, Baustein und Wup_2 - MULTISET. Enthält Informationen, aus welchen Listungsquellen Artikel_2 und Markt zugeordnet sind, d.h. welcher Artikel_2 in welchem Markt in den jeweiligen Bausteinen gelistet ist.');