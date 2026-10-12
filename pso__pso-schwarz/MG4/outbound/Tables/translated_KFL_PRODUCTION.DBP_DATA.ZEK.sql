CREATE OR REPLACE TABLE kfl_production_dbp_data.zek (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
zek_id STRING(3) NOT NULL
OPTIONS(description='Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch'),
wbl_id INTEGER OPTIONS(description='Warenbereichsleiter ID'),
zek_name STRING(30) COLLATE 'und:ci'
OPTIONS(description='Name des Zentraleinkäufers, verschiedene Ausprägungen, wie Nachname,Vorname, aber auch die Funktion, wie Pflanzen N.N'),
zek_abt_bez STRING(20) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Bezeichnung einer Organisationseinheit, der ein Zentraleinkäufer zugeordnet ist. Quelle ist die Tabelle T024'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, zek_id) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Zentraleinkäufer');