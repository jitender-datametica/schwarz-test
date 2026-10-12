CREATE TABLE P_LEW_CORE.T_WAWI_ITM_PRICEGROUP_2
(
client_id SMALLINT NOT NULL,
pricegroup_id DECIMAL(8,0) NOT NULL,
wh_loc_sid INTEGER NOT NULL,
st_loc_sid INTEGER NOT NULL,
dat_valid_from DATE NOT NULL,
dat_valid_until DATE NOT NULL,
pricegroup_desc VARCHAR(50) COLLATE 'en-ci' NOT NULL,
priority DECIMAL(8,0) NOT NULL,
language_id SMALLINT NOT NULL,
load_id INTEGER NOT NULL);


