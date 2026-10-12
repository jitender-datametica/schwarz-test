CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_MSI_DATA.ART_ZEK_ZU (
ART_ID INTEGER NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
ZEK_ID STRING(3) NOT NULL
OPTIONS(description='Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (ART_ID, MANDANT_ID, ZEK_ID) NOT ENFORCED
) OPTIONS(description='AIS_KMO - alle Artikel, die zu sehen ein Zentraleinkäufer berechtigt ist - MULTISET');