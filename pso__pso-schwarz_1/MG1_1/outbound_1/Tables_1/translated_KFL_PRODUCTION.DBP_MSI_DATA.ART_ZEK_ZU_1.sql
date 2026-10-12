CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_MSI_DATA.ART_ZEK_ZU_1 (
ART_ID INTEGER NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
ZEK_ID STRING(3) NOT NULL
OPTIONS(description='Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (ART_ID, MANDANT_ID, ZEK_ID) NOT ENFORCED
) OPTIONS(description='AIS_KMO - alle Artikel_1, die zu sehen ein Zentraleinkäufer berechtigt ist - MULTISET');