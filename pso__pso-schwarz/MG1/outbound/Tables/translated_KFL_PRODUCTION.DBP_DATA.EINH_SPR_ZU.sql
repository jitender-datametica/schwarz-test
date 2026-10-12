CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.EINH_SPR_ZU (
EINH_ID STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Masseinheit aus der Spalte msehi, zum Beispiel  %'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
SPR_ID INTEGER NOT NULL OPTIONS(description='ID der Sprache\n            '),
EINH_BEZ_KAUFM STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='externe Masseinheit kaufmaännische Darstellung aus mseh3'),
EINH_BEZ STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Kurztext der Masseinheiten Bezeichnung aus mseht (z.Bsp. Prozent)'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, SPR_ID) NOT ENFORCED
) OPTIONS(description='AIS - Sprachabhängige Bezeichnungen der Einheiten (für Einkauf) aus t006a');