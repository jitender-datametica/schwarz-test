CREATE TABLE P_LEW_CORE.T_WAWI_ORG_SALESORG
(
client_id SMALLINT NOT NULL,
st_loc_sid INTEGER NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
sales_manager_id INTEGER NOT NULL,
sales_manager_name VARCHAR(50) COLLATE 'en-ci',
account_manager_id INTEGER NOT NULL,
account_manager_name VARCHAR(50) COLLATE 'en-ci',
store_manager_id INTEGER NOT NULL ,
store_manager_name VARCHAR(50) COLLATE 'en-ci',
organisation_id INTEGER NOT NULL,
general_manager_id VARCHAR(9) COLLATE 'en-ci' NOT NULL,
general_manager_name VARCHAR(32) COLLATE 'en-ci',
district_id VARCHAR(200) COLLATE 'en-ci' NOT NULL,
dat_valid_from DATE NOT NULL,
dat_valid_until DATE,
wh_loc_sid_exp INTEGER NOT NULL,
load_id INTEGER NOT NULL);


