CREATE OR REPLACE TABLE kfl_production_dbp_ods.ods_bon_financial (
bon_id STRING(100) NOT NULL,
bon_zeile INTEGER NOT NULL,
mandant_id INTEGER NOT NULL,
umsatz_brutto NUMERIC(29,4) NOT NULL,
financial_grund_id INTEGER,
financial_kommentar STRING(2040),
auszahlung_fg INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
start_bon_zeile DATETIME,
bon_dat DATE NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
) OPTIONS(description='ODS - Aus den Kassensystemen near Realtime geladene Bon-Finanz-Transaktionen');