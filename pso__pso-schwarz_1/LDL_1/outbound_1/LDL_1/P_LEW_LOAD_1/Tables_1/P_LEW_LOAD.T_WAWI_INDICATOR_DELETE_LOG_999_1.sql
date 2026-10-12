CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_indicator_delete_log_999_1 (
client_id BIGNUMERIC(38) NOT NULL,
org_type_id BIGNUMERIC(38) NOT NULL,
org_unit_nr BIGNUMERIC(38),
indicator_id BIGNUMERIC(38) NOT NULL,
indicator_type_id BIGNUMERIC(38) NOT NULL,
cy BIGNUMERIC(38),
dat_formdate_from DATE,
dat_formdate_until DATE,
cal_week_from BIGNUMERIC(38),
cal_week_until BIGNUMERIC(38),
month_id_from BIGNUMERIC(38),
month_id_until BIGNUMERIC(38),
timestamp_fn DATETIME NOT NULL,
dat_dayend DATE NOT NULL,
load_id BIGNUMERIC(38) NOT NULL
);