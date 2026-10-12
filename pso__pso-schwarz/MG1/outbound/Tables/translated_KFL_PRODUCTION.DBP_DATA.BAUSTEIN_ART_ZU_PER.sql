CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.BAUSTEIN_ART_ZU_PER (
BAUSTEIN_ID INTEGER NOT NULL OPTIONS(description='ID eines Sortimentsbausteins'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
ART_ID INTEGER NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
DAT_BIS DATE NOT NULL OPTIONS(description='Ende der Gültigkeitsperiode. Format JJJJ-MM-TT\n            '),
DAT_VON DATE OPTIONS(description='Beginn der Gültigkeitsperiode\n            '),
AKZ_ID STRING(1) COLLATE 'und:ci'
OPTIONS(description='Artikelkennzeichen in der Form\n            A = Artikel über sich selbst gelistet\n            D = Artikel über Display (Stückliste Display) gelistet\n            K = Artikel als Komponente über Display gelistet'),
STUECKLISTE_ID INTEGER NOT NULL
OPTIONS(description='ID einer Stückliste, in der der Einzelartikel zusammen mit mehreren anderen Artikel zugeordnet werden kann. Die Stammdaten der Stücklisten befinden sich derzeit noch nicht im DWH'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (BAUSTEIN_ID, MANDANT_ID, ART_ID, DAT_BIS, STUECKLISTE_ID) NOT ENFORCED
) OPTIONS(description='TP2/7 AIS - Zuordnung Baustein zu Artikel - MULTISET - SAP RET Tabelle WSOP');