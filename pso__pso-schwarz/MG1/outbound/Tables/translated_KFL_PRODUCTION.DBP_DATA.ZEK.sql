CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ZEK (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
ZEK_ID STRING(3) NOT NULL
OPTIONS(description='Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch'),
WBL_ID INTEGER OPTIONS(description='Warenbereichsleiter ID'),
ZEK_NAME STRING(30) COLLATE 'und:ci'
OPTIONS(description='Name des Zentraleinkäufers, verschiedene Ausprägungen, wie Nachname,Vorname, aber auch die Funktion, wie Pflanzen N.N'),
ZEK_ABT_BEZ STRING(20) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Bezeichnung einer Organisationseinheit, der ein Zentraleinkäufer zugeordnet ist. Quelle ist die Tabelle T024'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, ZEK_ID) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Zentraleinkäufer');