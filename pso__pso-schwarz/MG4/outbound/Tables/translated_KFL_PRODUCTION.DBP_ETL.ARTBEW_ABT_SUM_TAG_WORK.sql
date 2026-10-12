CREATE OR REPLACE TABLE kfl_production_dbp_etl.artbew_abt_sum_tag_work (
mandant_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
nb_id INTEGER NOT NULL,
abt_id INTEGER NOT NULL,
bewart_id INTEGER NOT NULL,
arthiertyp_id INTEGER NOT NULL,
umsatz_brutto NUMERIC(18,2),
umsatz_netto NUMERIC(18,2),
umsatz_wrg STRING(3) COLLATE 'und:ci',
umsatz_brutto_konz NUMERIC(18,2),
umsatz_netto_konz NUMERIC(18,2),
dat DATE NOT NULL
);