CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.MONAT_SPR_ZU_2 (
MO_ID INTEGER NOT NULL OPTIONS(description='Nummer des Monats (zwischen 1 und 12)'),
SPR_ID INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
MO_BEZ STRING(20) COLLATE 'und:ci' OPTIONS(description='Bezeichnung eines Kalendermonats'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MO_ID, SPR_ID) NOT ENFORCED
) OPTIONS(description='Bezeichnung der Monate in den DWH-Sprachen');