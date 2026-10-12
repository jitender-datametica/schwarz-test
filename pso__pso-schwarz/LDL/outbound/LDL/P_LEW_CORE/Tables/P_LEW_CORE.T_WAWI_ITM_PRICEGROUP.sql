CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_itm_pricegroup (
client_id INTEGER NOT NULL,
pricegroup_id INTEGER NOT NULL,
wh_loc_sid INTEGER NOT NULL,
st_loc_sid INTEGER NOT NULL,
dat_valid_from DATE NOT NULL,
dat_valid_until DATE NOT NULL,
pricegroup_desc STRING(50) COLLATE 'und:ci' NOT NULL,
priority INTEGER NOT NULL,
language_id INTEGER NOT NULL,
load_id INTEGER NOT NULL
);