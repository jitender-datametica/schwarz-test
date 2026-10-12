CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.tour_we_det (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
lagernummer_id STRING(3) COLLATE 'und:ci' NOT NULL,
tour_id INTEGER NOT NULL,
wgvgrp_id BIGNUMERIC(38,0) NOT NULL,
lief_beleg_id INTEGER NOT NULL,
seq_nummer BIGNUMERIC(38,0) NOT NULL,
art_id BIGNUMERIC(38,0) NOT NULL,
kj_lief_beleg BIGNUMERIC(38,0) NOT NULL,
gruppenzone_id STRING(10) COLLATE 'und:ci',
ausschluss_manuell_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
ausschluss_regel_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
blockartikel_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
lagerplatz_id STRING(10) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);