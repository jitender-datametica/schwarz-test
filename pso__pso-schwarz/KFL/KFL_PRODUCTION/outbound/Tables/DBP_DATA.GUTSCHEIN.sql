CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.gutschein (
gutschein_id INTEGER NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
transaktion_id BIGNUMERIC(38,0) NOT NULL,
zeitstempel DATETIME NOT NULL,
system_id BIGNUMERIC(38,0),
profil_id BIGNUMERIC(38,0) NOT NULL,
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL,
ausgeber_typ_id STRING(3) COLLATE 'und:ci' NOT NULL,
betrag_gutschein NUMERIC(9,2) NOT NULL,
ausgeber_id STRING(10) COLLATE 'und:ci' NOT NULL,
kostenstelle_id STRING(10) COLLATE 'und:ci' NOT NULL,
ereignisquelle_id BIGNUMERIC(38,0) NOT NULL,
geku_ticket_id INTEGER DEFAULT - 1 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);