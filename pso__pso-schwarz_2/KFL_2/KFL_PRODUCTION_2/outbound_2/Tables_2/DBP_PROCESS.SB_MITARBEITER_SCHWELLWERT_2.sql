CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.sb_mitarbeiter_schwellwert_2 (
mitarbeiter_id BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
prozent_sbu_gelb_bis BIGNUMERIC(38,0),
prozent_sbu_rot_bis BIGNUMERIC(38,0),
soll_anz_schnellbeurteilung BIGNUMERIC(38,0),
sort_nr_bericht_anz_sb BIGNUMERIC(38,0),
sort_nr_bericht_filialentw BIGNUMERIC(38,0),
dat_bis DATE NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);