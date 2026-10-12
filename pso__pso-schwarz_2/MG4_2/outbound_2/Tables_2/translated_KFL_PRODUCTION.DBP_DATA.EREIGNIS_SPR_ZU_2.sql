CREATE OR REPLACE TABLE kfl_production_dbp_data.ereignis_spr_zu_2 (
ereignis_id INTEGER NOT NULL OPTIONS(description='Ereignis_2 ID (fortlaufende Nummer)'),
ereignistyp_id INTEGER NOT NULL
OPTIONS(description='Ereignistyp_2 ID, Gruppierung der Ereignisse in z.Bsp. Allgemeine Feiertage, Sonntagsöffnungen, ...'),
spr_id INTEGER NOT NULL OPTIONS(description='ID der Sprache\n            '),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
ereignis_bez_lang STRING(60) COLLATE 'und:ci'
OPTIONS(description='Langbezeichnung eines Ereignisses, z.Bsp.\n            Lang = Ostersonntag\n            Mittel = Ostern\n            Kurz = O'),
ereignis_bez_mittel STRING(60) COLLATE 'und:ci'
OPTIONS(description='Mittellangbezeichnung eines Ereignisses, z.Bsp.\n            Lang = Ostersonntag\n            Mittel = Ostern\n            Kurz = O'),
ereignis_bez_kurz STRING(60) COLLATE 'und:ci'
OPTIONS(description='Kurzbezeichnung eines Ereignisses, z.Bsp.\n            Lang = Ostersonntag\n            Mittel = Ostern\n            Kurz = O'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (ereignis_id, ereignistyp_id, spr_id, mandant_id) NOT ENFORCED
) OPTIONS(description='VIS - Bezeichnung eines Ereignisses in den DWH-Sprachen');