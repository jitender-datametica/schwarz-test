CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_fi_beleg_kred_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
in_lief_id BIGNUMERIC(38,0) NOT NULL,
buchungskreis_id BIGNUMERIC(38,0) NOT NULL,
ausgleich_beleg_id INTEGER NOT NULL,
in_fi_beleg_id INTEGER NOT NULL,
dat_ausgleich_beleg DATE NOT NULL,
in_fi_beleg_pos_id BIGNUMERIC(38,0) NOT NULL,
gj BIGNUMERIC(38,0) NOT NULL,
dat_erfasst DATE NOT NULL,
dat_buch DATE NOT NULL,
dat_beleg DATE NOT NULL,
buchung_schl_id STRING(2) COLLATE 'und:ci',
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL,
offen_posten_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
ext_ref_beleg_nr STRING(20) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
) CLUSTER BY mandant_id, gj;