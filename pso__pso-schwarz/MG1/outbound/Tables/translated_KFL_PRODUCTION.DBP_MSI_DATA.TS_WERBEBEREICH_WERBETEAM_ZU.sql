CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_MSI_DATA.TS_WERBEBEREICH_WERBETEAM_ZU (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
WG_ID INTEGER NOT NULL OPTIONS(description='ID der Warengruppe.'),
WERBEBEREICH_CD STRING(100) OPTIONS(description='Code des Werbebereichs.'),
WERBETEAM_CD STRING(100) OPTIONS(description='Code des Werbeteams'),
WERBETEAM_BEZ STRING(100) OPTIONS(description='Werbeteam - Bezeichnung'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, WG_ID) NOT ENFORCED
) OPTIONS(description='Transaktionservice Tabelle mit Informationen über Werbebereich und Werbeteam einer Warengruppe.');