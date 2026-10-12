CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.artbew_konto_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
konto_id BIGNUMERIC(38,0) NOT NULL,
bewart_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
arthiertyp_id BIGNUMERIC(38,0) NOT NULL,
umsatz_brutto NUMERIC(18,2),
umsatz_netto NUMERIC(18,2),
umsatz_wrg STRING(3) COLLATE 'und:ci',
umsatz_brutto_konz NUMERIC(18,2),
umsatz_netto_konz NUMERIC(18,2),
kjmo BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);