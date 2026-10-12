CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.tour_det (
mandant_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
tour_pos_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
tour_id INTEGER NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
mandant_id_kunde BIGNUMERIC(38,0),
reihenfolge_tour_dispo BIGNUMERIC(38,0),
lagernummer_id STRING(3) COLLATE 'und:ci',
kunde_id STRING(10) COLLATE 'und:ci',
lief_beleg_id INTEGER,
dat_plan_ankunft DATE,
loesch_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
dat_tourpos_erfasst DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL,
kj_lief_beleg BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);