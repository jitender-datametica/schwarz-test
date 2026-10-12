CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_indicator_day (
client_id BIGNUMERIC(38,0) NOT NULL,
org_type_id BIGNUMERIC(38,0) NOT NULL,
org_unit_nr BIGNUMERIC(38,0),
indicator_id BIGNUMERIC(38,0) NOT NULL,
indicator_type_id BIGNUMERIC(38,0) NOT NULL,
cy BIGNUMERIC(38,0) NOT NULL,
dat_formdate DATE NOT NULL,
val_indicator NUMERIC(18,4),
timestamp_fn DATETIME NOT NULL,
dat_dayend DATE NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);