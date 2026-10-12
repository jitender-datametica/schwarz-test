CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.teku_bericht_per_2 (
teku_bericht_id BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
dat_besuchs_beginn DATE NOT NULL,
zeit_besuchs_beginn BIGNUMERIC(38,0) NOT NULL,
dat_besuchs_ende DATE NOT NULL,
zeit_besuchs_ende BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
teku_checkliste_id BIGNUMERIC(38,0) NOT NULL,
testkunde_id BIGNUMERIC(38,0) NOT NULL,
loeschung_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
nicht_auswerten_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
dat_erfasst DATE,
td_insert TIMESTAMP,
td_update TIMESTAMP
);