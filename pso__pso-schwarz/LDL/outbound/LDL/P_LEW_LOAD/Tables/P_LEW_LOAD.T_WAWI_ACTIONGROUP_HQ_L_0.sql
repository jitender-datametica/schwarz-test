CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_actiongroup_hq_l_0 (
country_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
wh_id_hq STRING(3) COLLATE 'und:ci' NOT NULL,
dat_valid_from DATE NOT NULL,
dat_valid_until DATE NOT NULL,
item_sub_actgroup_desc_country STRING(50) COLLATE 'und:ci',
item_sub_actgroup_desc_german STRING(50) COLLATE 'und:ci' NOT NULL,
item_sub_actiongroup_id BIGNUMERIC(38) NOT NULL,
item_actgroup_desc_country STRING(50) COLLATE 'und:ci',
item_actgroup_desc_german STRING(50) COLLATE 'und:ci' NOT NULL,
item_actiongroup_id BIGNUMERIC(38) NOT NULL,
dat_dayend DATE,
load_id BIGNUMERIC(38),
dc_server_id BIGNUMERIC(38) NOT NULL,
bic_zmlila STRING(20),
extraction_ts DATETIME,
record_id INTEGER,
source_system STRING(20) COLLATE 'und:ci'
);