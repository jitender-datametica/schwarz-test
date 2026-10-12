DROP TABLE IF EXISTS kfl_production_dbp_data.in_fi_beleg_kred;
CREATE OR REPLACE TABLE kfl_production_dbp_data.in_fi_beleg_kred (
mandant_id INTEGER NOT NULL,
in_lief_id INTEGER NOT NULL,
buchungskreis_id INTEGER NOT NULL,
ausgleich_beleg_id INTEGER NOT NULL,
in_fi_beleg_id INTEGER NOT NULL,
dat_ausgleich_beleg DATE NOT NULL,
in_fi_beleg_pos_id INTEGER NOT NULL,
gj INTEGER NOT NULL,
dat_erfasst DATE NOT NULL,
dat_buch DATE NOT NULL,
dat_beleg DATE NOT NULL,
buchung_schl_id STRING(2) COLLATE 'und:ci',
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL,
offen_posten_fg INTEGER DEFAULT 0 NOT NULL,
ext_ref_beleg_nr STRING(20) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
) CLUSTER BY mandant_id, gj;