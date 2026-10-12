CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.L_WERBETEAM_2 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
WERBETEAM_CD STRING(100) NOT NULL OPTIONS(description='Code des Werbeteams'),
WERBEBEREICH_CD STRING(100) OPTIONS(description='Code des Werbebereichs'),
WERBETEAM_BEZ STRING(100) OPTIONS(description='Werbeteam - Bezeichnung'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, WERBETEAM_CD) NOT ENFORCED
)
OPTIONS(description='Fachlich verantwortliche Personen (auch Planer genannt) die für eine_2 Kategorie an Artikel_2 die über die WGs identifziert werden, die Werbungen in Deutschland planen.\n             ');