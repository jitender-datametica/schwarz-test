CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_itemdelete_hq_l_0_qas_2 (
country_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
wh_id_hq STRING(3) COLLATE 'und:ci' NOT NULL,
item_nr_long STRING(24) COLLATE 'und:ci',
orig_item_nr INTEGER,
case_size BIGNUMERIC(38,0),
item_delete_desc STRING(35) COLLATE 'und:ci',
dat_item_delete DATE,
status_item_delete BIGNUMERIC(38,0),
item_closed_fg INTEGER,
dat_dayend DATE,
load_id BIGNUMERIC(38,0),
dc_server_id BIGNUMERIC(38,0) NOT NULL,
bic_zmlila STRING(20),
extraction_ts DATETIME,
record_id INTEGER,
source_system STRING(20) COLLATE 'und:ci'
);