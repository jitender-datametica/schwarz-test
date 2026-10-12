CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.werbe_typ_woche_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
werbe_typ_id BIGNUMERIC(38,0) NOT NULL,
kjwo BIGNUMERIC(38,0) NOT NULL,
werbewoche BIGNUMERIC(38,0) NOT NULL,
kjmo BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);