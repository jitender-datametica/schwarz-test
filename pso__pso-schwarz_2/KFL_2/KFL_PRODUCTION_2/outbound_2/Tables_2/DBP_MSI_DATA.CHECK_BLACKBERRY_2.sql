CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.check_blackberry_2 (
dat DATE NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
lieferquote_real NUMERIC(9,2) NOT NULL,
lieferquote_def NUMERIC(9,2) NOT NULL,
datenquote_real NUMERIC(9,2) NOT NULL,
datenquote_def NUMERIC(9,2) NOT NULL,
bb_fg BIGNUMERIC(38,0) NOT NULL,
check_fg BIGNUMERIC(38,0) NOT NULL,
umsatz_ist NUMERIC(18,2) NOT NULL,
umsatz_vj NUMERIC(18,2) NOT NULL,
umsatz_plan NUMERIC(18,2) NOT NULL,
umsatz_vortag NUMERIC(18,2) NOT NULL,
umsatz_vorwoche NUMERIC(18,2) NOT NULL,
kunden_ist BIGNUMERIC(38,0) NOT NULL,
kunden_vj BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);