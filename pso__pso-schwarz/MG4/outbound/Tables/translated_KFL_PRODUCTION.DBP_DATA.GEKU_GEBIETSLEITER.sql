CREATE OR REPLACE TABLE kfl_production_dbp_data.geku_gebietsleiter (
gebietsleiter_uid INTEGER NOT NULL OPTIONS(description='Eindeutige ID des Gebietsleiters aus pc_nr'),
vertriebsbuero_uid INTEGER NOT NULL OPTIONS(description='Eindeutige ID eines Vertriebsbüros aus rvl_nr'),
gebietsleiter_bez STRING(60) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des Gebietsleiters'),
berichts_empfaenger_ldap STRING(10) COLLATE 'und:ci'
OPTIONS(description='LDAP für den automatischen Versand von Berichten für den Gebietsleiter'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (gebietsleiter_uid) NOT ENFORCED
) OPTIONS(description='GEKU - Lookup-Tabelle der Gebietsleiter aus wmd_pc_out');