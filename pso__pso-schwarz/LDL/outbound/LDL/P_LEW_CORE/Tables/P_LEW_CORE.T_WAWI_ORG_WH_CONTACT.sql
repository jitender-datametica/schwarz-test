CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_org_wh_contact (
client_id BIGNUMERIC(38,0) NOT NULL,
wh_loc_sid BIGNUMERIC(38,0) NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
zipcode STRING(15) COLLATE 'und:ci',
city STRING(50) COLLATE 'und:ci',
street STRING(70) COLLATE 'und:ci',
phone STRING(50) COLLATE 'und:ci',
zipcode_postbox STRING(15) COLLATE 'und:ci',
postbox STRING(50) COLLATE 'und:ci',
fax STRING(50) COLLATE 'und:ci',
modem STRING(50) COLLATE 'und:ci',
load_id BIGNUMERIC(38,0) NOT NULL
);