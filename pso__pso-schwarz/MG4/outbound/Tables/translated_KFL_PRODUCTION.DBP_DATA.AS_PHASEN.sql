CREATE OR REPLACE TABLE kfl_production_dbp_data.as_phasen (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
wg_id INTEGER NOT NULL OPTIONS(description='ID der Warengruppe'),
posten_kz_sap STRING(2) NOT NULL
OPTIONS(description='Postenkennzeichen. Für Artikel, die nicht ständig im Sortiment sind (Unterschied zur posten_id: für KMO werden die tatsächlichen Werte aus SAP gespeichert)'),
wtag_phasenbeginn INTEGER NOT NULL OPTIONS(description='Wochentag Phasenbeginn aus dem Quellfeld WEEKDAY (Montag = 1)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='AIS - Länderspezifische Einstellungen für Artikelauslistung - SAP RET - ZRS_RVCUST');