CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.vis_schwellwert (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
kjmo BIGNUMERIC(38,0) NOT NULL,
sw_thema_id BIGNUMERIC(38,0) NOT NULL,
sw_attribut_id BIGNUMERIC(38,0) NOT NULL,
sw_attribut_wert BIGNUMERIC(38,0) NOT NULL,
vis_schwellwert NUMERIC(9,4),
td_insert TIMESTAMP,
td_update TIMESTAMP
);