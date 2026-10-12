CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.handling_unit_verwendung (
mandant_id BIGNUMERIC(38,0) NOT NULL,
handle STRING(22) NOT NULL,
beleg_typ STRING(2) COLLATE 'und:ci' NOT NULL,
beleg_id INTEGER NOT NULL,
datzeit INTEGER,
richtung BIGNUMERIC(38,0),
td_update TIMESTAMP,
td_insert TIMESTAMP
);