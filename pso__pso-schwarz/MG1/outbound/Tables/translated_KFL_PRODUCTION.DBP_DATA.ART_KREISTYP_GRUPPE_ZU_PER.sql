CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ART_KREISTYP_GRUPPE_ZU_PER (
ART_ID INTEGER NOT NULL OPTIONS(description='Artikel - Id'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
KREISTYP_ID STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kreistyp'),
DAT_VON DATE NOT NULL OPTIONS(description='Beginn der Gültigkeitsperiode'),
KREISTYP_GRUPPE_ID STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Region / Gruppierung Kreistypen'),
DAT_BIS DATE NOT NULL OPTIONS(description='Endedatum der Gültigkeit, bei aktuellen Sätzen = 31.12.9999'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (ART_ID, MANDANT_ID, DAT_VON) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Zeitabhängige Zuordnung der Artikel zu Kreistyp und Kreistypgruppe');