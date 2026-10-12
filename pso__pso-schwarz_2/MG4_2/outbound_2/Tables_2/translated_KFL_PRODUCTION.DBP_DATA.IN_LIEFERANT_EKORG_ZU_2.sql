CREATE OR REPLACE TABLE kfl_production_dbp_data.in_lieferant_ekorg_zu_2 (
in_lief_id INTEGER NOT NULL OPTIONS(description='Lieferantennummer. Im DWH erzeugter numerischer Schlüssel'),
einkaufsorganisation_id INTEGER NOT NULL OPTIONS(description='Einkaufsorganisation aus ekorg'),
mandant_id INTEGER NOT NULL OPTIONS(description='ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;'),
loesch_fg INTEGER NOT NULL OPTIONS(description='Zentrale Löschvormerkung für Stammsatz aus loevm'),
ek_sperr_fg INTEGER NOT NULL OPTIONS(description='zentral vergebene Einkaufssperre aus sperm'),
einkaeufer_grp_id STRING(3) COLLATE 'und:ci' OPTIONS(description='ID der Einkäufergruppe aus ekgr'),
zahlungsziel_id STRING(4) COLLATE 'und:ci' OPTIONS(description='ID der Zahlungsbedingung. Z.Bsp. 3030 = 30Tage, 3%'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (in_lief_id, einkaufsorganisation_id, mandant_id) NOT ENFORCED
) OPTIONS(description='BIS - Zuordnung Lieferant zu Einkaufsorganisation aus lfm1_2');