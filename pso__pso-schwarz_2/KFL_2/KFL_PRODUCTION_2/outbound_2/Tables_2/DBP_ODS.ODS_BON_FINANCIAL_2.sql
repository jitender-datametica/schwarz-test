CREATE TABLE IF NOT EXISTS kfl_production_dbp_ods.ods_bon_financial_2 (
bon_id STRING(100) NOT NULL,
bon_zeile BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
umsatz_brutto NUMERIC(18,4) NOT NULL,
financial_grund_id BIGNUMERIC(38,0),
financial_kommentar STRING(2040),
auszahlung_fg BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
start_bon_zeile DATETIME,
bon_dat DATE NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
) OPTIONS(description='ODS - Aus den Kassensystemen near Realtime geladene Bon-Finanz-Transaktionen');