CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_ETL_PROCESS.EKC_ZEK_2 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH.'),
ART_ID INTEGER NOT NULL
OPTIONS(description='Artikelnummer im DWH. Input: Artikel_2-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_2-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1.'),
ZEK_ID STRING(3) OPTIONS(description='Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch'),
EIGENMARKE_FG INTEGER
OPTIONS(description='Flag Eigenmarke (wenn zek_id (Verhandler) und zek_vat_id (Verantwortlicher) in der Tabelle art_2 nicht identisch sind, wird das Flag auf 1 gesetzt (Eigenmarke-Artikel_2))'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, ART_ID) NOT ENFORCED
) OPTIONS(description='ETL-Process table. Is used in the loading of table DBP_DATA.ARTBEW_MO_EK_CP_SUM.');