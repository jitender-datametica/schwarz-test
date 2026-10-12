CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_plan_planheader_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
plan_id BIGNUMERIC(38,0) NOT NULL,
plan_nr BIGNUMERIC(38,0),
dat_plan DATE NOT NULL,
dat_dayend DATE,
dat_busyear_from DATE,
dat_busyear_until DATE,
plantype_id BIGNUMERIC(38,0) NOT NULL,
plan_version STRING(20) COLLATE 'und:ci' NOT NULL,
plan_titel STRING(200) COLLATE 'und:ci' NOT NULL,
plan_desc STRING(200) COLLATE 'und:ci' NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);