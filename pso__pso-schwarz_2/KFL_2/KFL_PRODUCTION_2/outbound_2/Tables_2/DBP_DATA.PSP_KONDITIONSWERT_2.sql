CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.psp_konditionswert_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
psp_id BIGNUMERIC(38,0) NOT NULL,
wrg_id STRING(3) COLLATE 'und:ci',
betrag_konditionswert_gebucht NUMERIC(18,4) DEFAULT 0 NOT NULL,
betrag_konditionswert_ungebucht NUMERIC(18,4) DEFAULT 0 NOT NULL,
konditionsart_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);