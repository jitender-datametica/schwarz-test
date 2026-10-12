CREATE TABLE IF NOT EXISTS kfl_production_dbp_ods.ods_bon_zahlung_old (
bon_id STRING(100) NOT NULL,
bon_zeile BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
zahlung_typ_id BIGNUMERIC(38,0) NOT NULL,
start_bon_zeile TIMESTAMP NOT NULL,
betrag_zahlung NUMERIC(18,4) DEFAULT 0 NOT NULL,
wrg_id STRING(12) NOT NULL,
kpos_zahlung_typ_id STRING(2040),
bon_dat DATE NOT NULL,
bon_zeile_cashback_referenz BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
) CLUSTER BY mandant_id, bon_dat, wup_id
OPTIONS(description='ODS - Aus den Kassensystemen near Realtime geladene Zahlungsinformationen (Bon-Zeilen)');