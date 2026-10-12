CREATE TABLE p_lew_process.t_wawi_wh_new_1 (
client_id INTEGER NOT NULL,
country_iso_cd VARCHAR(3) COLLATE 'en-ci' NOT NULL,
wh_id INTEGER NOT NULL,
dat_dayend DATE NOT NULL,
dat_dayend_mmo_master DATE,
dat_dayend_mmo_move DATE,
wh_new_loc_sid INTEGER,
wh_new_time_trans TIMESTAMP(0),
wh_new_status VARCHAR(10) COLLATE 'en-ci',
wh_new_err_text VARCHAR(200) COLLATE 'en-ci',
UNIQUE ( country_iso_cd ,wh_id ,dat_dayend)
);