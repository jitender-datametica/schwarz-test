CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.AS_PHASEN (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
WG_ID INTEGER NOT NULL OPTIONS(description='ID der Warengruppe'),
POSTEN_KZ_SAP STRING(2) NOT NULL
OPTIONS(description='Postenkennzeichen. Für Artikel, die nicht ständig im Sortiment sind (Unterschied zur posten_id: für KMO werden die tatsächlichen Werte aus SAP gespeichert)'),
WTAG_PHASENBEGINN INTEGER NOT NULL OPTIONS(description='Wochentag Phasenbeginn aus dem Quellfeld WEEKDAY (Montag = 1)'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='AIS - Länderspezifische Einstellungen für Artikelauslistung - SAP RET - ZRS_RVCUST');