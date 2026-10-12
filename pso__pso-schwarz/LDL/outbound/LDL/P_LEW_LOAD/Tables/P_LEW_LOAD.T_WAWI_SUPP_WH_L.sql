CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_supp_wh_l (
country_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
wh_id STRING(3) COLLATE 'und:ci' NOT NULL,
orig_supplier_nr STRING(7) COLLATE 'und:ci' NOT NULL,
dispo_info STRING(254) COLLATE 'und:ci',
fax STRING(35) COLLATE 'und:ci',
name_cont_person STRING(35) COLLATE 'und:ci',
phone STRING(35) COLLATE 'und:ci',
fax_contact_fg INTEGER,
dat_dayend DATE,
load_id BIGNUMERIC(38)
);