CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.L_NACHHALTIGKEITSLOGO_2 (
NACHHALTIGKEITSLOGO_ID INTEGER NOT NULL OPTIONS(description='Id des Nachhaltigkeitslogos (bspw. Blauer Engel)'),
NACHHALTIGKEITSLOGO_BEZ STRING(50) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Bezeichnung des Nachhaltigkeitslogos (bspw. Blauer Engel)'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
LOGO_KZSTG STRING(3) DEFAULT '' NOT NULL OPTIONS(description='Nachhaltigkeitslogo SAP'),
PRIMARY KEY (NACHHALTIGKEITSLOGO_ID, LOGO_KZSTG) NOT ENFORCED
) OPTIONS(description='AIS - Lookup für Nachhaltigkeitslogos. Initialbeladung durch DWH.');