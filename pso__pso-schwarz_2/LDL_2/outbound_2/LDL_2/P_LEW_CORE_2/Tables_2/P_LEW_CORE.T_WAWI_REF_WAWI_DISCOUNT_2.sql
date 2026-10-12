CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_wawi_discount_2 (
client_id INTEGER NOT NULL,
discount_nr_wawi INTEGER NOT NULL,
dat_valid_from DATE NOT NULL,
dat_valid_until DATE NOT NULL,
discount_desc STRING(50) COLLATE 'und:ci' NOT NULL,
discount_type_id INTEGER NOT NULL,
discount_booking_type_id INTEGER NOT NULL,
dat_last_export DATETIME,
dat_storno DATETIME,
dat_dayend DATE NOT NULL,
load_id INTEGER NOT NULL
);