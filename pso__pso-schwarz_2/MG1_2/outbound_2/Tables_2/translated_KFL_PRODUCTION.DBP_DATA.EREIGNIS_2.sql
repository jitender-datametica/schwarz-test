CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.EREIGNIS_2 (
EREIGNIS_ID INTEGER NOT NULL OPTIONS(description='Ereignis_2 ID (fortlaufende Nummer)'),
EREIGNISTYP_ID INTEGER NOT NULL
OPTIONS(description='Ereignistyp_2 ID, Gruppierung der Ereignisse in z.Bsp. Allgemeine Feiertage, Sonntagsöffnungen, ...'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
DEFAULT_OFFEN INTEGER OPTIONS(description='gibt an, ob bei dem Ereignis_2 der Markt normalerweise offen ist'),
SAP_EREIGNIS_ID INTEGER
OPTIONS(description='Die durch das SAP-System gelieferte ID wird im DWH auf die DWH-interne ID umgesetzt'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (EREIGNIS_ID, EREIGNISTYP_ID, MANDANT_ID) NOT ENFORCED
) OPTIONS(description='VIS - Bildet Ereignisse ab, die sich auf den Umsatz auswirken können, wie Feiertage');