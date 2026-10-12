CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_org_store_contact_810 (
st_loc_sid BIGNUMERIC(38,0),
client_id BIGNUMERIC(38,0),
dat_rec_start DATE,
dat_rec_end DATE,
zipcode STRING(15) COLLATE 'und:ci',
city STRING(100) COLLATE 'und:ci',
street STRING(70) COLLATE 'und:ci',
phone STRING(50) COLLATE 'und:ci',
zipcode_postbox STRING(15) COLLATE 'und:ci',
postbox STRING(50) COLLATE 'und:ci',
fax STRING(35) COLLATE 'und:ci',
modem STRING(50) COLLATE 'und:ci',
load_id BIGNUMERIC(38,0),
pol_region_sid BIGNUMERIC(38,0),
pol_region_cd STRING(100)
) OPTIONS(description='Filiale Kontaktinforamtionen - WORKTABLE 800');