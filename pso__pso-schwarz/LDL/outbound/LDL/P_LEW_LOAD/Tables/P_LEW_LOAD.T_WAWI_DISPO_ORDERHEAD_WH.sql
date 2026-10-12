CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_dispo_orderhead_wh (
client_id BIGNUMERIC(38) NOT NULL,
wh_id BIGNUMERIC(38) NOT NULL,
po_nr STRING(12) COLLATE 'und:ci' NOT NULL,
supplier_id BIGNUMERIC(38) NOT NULL,
dat_delivery DATE NOT NULL,
dispo_lfd_nr STRING(2) COLLATE 'und:ci' NOT NULL,
status_dispo BIGNUMERIC(38),
dat_dispo_create DATETIME,
dat_dispo_modify DATETIME,
batch_id_dispo BIGNUMERIC(38),
timestamp_fn DATETIME NOT NULL,
dat_dayend DATE,
load_id BIGNUMERIC(38)
);