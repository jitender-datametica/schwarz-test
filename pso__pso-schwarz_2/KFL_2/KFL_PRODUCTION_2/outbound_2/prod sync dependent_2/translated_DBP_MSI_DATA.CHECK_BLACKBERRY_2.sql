CREATE OR REPLACE TABLE kfl_production_dbp_msi_data.check_blackberry_2 (
dat DATE NOT NULL,
mandant_id INTEGER NOT NULL,
lieferquote_real NUMERIC(29,2) NOT NULL,
lieferquote_def NUMERIC(29,2) NOT NULL,
datenquote_real NUMERIC(29,2) NOT NULL,
datenquote_def NUMERIC(29,2) NOT NULL,
bb_fg INTEGER NOT NULL,
check_fg INTEGER NOT NULL,
umsatz_ist NUMERIC(29,2) NOT NULL,
umsatz_vj NUMERIC(29,2) NOT NULL,
umsatz_plan NUMERIC(29,2) NOT NULL,
umsatz_vortag NUMERIC(29,2) NOT NULL,
umsatz_vorwoche NUMERIC(29,2) NOT NULL,
kunden_ist INTEGER NOT NULL,
kunden_vj INTEGER NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);