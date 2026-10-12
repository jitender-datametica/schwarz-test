CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wup_abschoepfung (
wup_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
dat DATE NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
betrag_markt_vor_geldabhlg NUMERIC(18,2),
betrag_geldabhlg NUMERIC(18,2),
betrag_markt_nach_geldabhlg NUMERIC(18,2),
betrag_tresor_nach_geldabhlg NUMERIC(18,2),
betrag_schieb_nach_geldabhlg NUMERIC(18,2),
betrag_geldabholg_90_prozent NUMERIC(18,2),
betrag_diff_90_prozent NUMERIC(18,2),
quote_geldabhlg NUMERIC(9,2),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);