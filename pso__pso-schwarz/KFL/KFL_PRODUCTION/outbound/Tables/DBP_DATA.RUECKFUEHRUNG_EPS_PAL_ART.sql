CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.rueckfuehrung_eps_pal_art (
mandant_id BIGNUMERIC(38,0) NOT NULL,
handling_unit_id_ext STRING(20) COLLATE 'und:ci' NOT NULL,
art_id BIGNUMERIC(38,0) NOT NULL,
dat_erfassung DATE,
menge INTEGER,
td_update TIMESTAMP,
td_insert TIMESTAMP
);