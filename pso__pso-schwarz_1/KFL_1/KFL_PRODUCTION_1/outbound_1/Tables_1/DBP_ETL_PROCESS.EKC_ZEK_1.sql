CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.ekc_zek_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikelnummer im DWH. Input: Artikel_1-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_1-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1.'),
zek_id STRING(3) OPTIONS(description='Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch'),
eigenmarke_fg BIGNUMERIC(38,0)
OPTIONS(description='Flag Eigenmarke (wenn zek_id (Verhandler) und zek_vat_id (Verantwortlicher) in der Tabelle art_1 nicht identisch sind, wird das Flag auf 1 gesetzt (Eigenmarke-Artikel_1))'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_id) NOT ENFORCED
) OPTIONS(description='ETL-Process table. Is used in the loading of table DBP_DATA.ARTBEW_MO_EK_CP_SUM.');