CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.EREIGNIS_SPR_ZU_2 (
EREIGNIS_ID INTEGER NOT NULL OPTIONS(description='Ereignis_2 ID (fortlaufende Nummer)'),
EREIGNISTYP_ID INTEGER NOT NULL
OPTIONS(description='Ereignistyp_2 ID, Gruppierung der Ereignisse in z.Bsp. Allgemeine Feiertage, Sonntagsöffnungen, ...'),
SPR_ID INTEGER NOT NULL OPTIONS(description='ID der Sprache\n            '),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
EREIGNIS_BEZ_LANG STRING(60) COLLATE 'und:ci'
OPTIONS(description='Langbezeichnung eines Ereignisses, z.Bsp.\n            Lang = Ostersonntag\n            Mittel = Ostern\n            Kurz = O'),
EREIGNIS_BEZ_MITTEL STRING(60) COLLATE 'und:ci'
OPTIONS(description='Mittellangbezeichnung eines Ereignisses, z.Bsp.\n            Lang = Ostersonntag\n            Mittel = Ostern\n            Kurz = O'),
EREIGNIS_BEZ_KURZ STRING(60) COLLATE 'und:ci'
OPTIONS(description='Kurzbezeichnung eines Ereignisses, z.Bsp.\n            Lang = Ostersonntag\n            Mittel = Ostern\n            Kurz = O'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (EREIGNIS_ID, EREIGNISTYP_ID, SPR_ID, MANDANT_ID) NOT ENFORCED
) OPTIONS(description='VIS - Bezeichnung eines Ereignisses in den DWH-Sprachen');