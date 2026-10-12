CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_itm_excise_duty_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
item_sid BIGNUMERIC(38,0) NOT NULL,
main_exduty BIGNUMERIC(38,0) NOT NULL,
sub_exduty BIGNUMERIC(38,0) NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
dat_valid_from DATE NOT NULL,
dat_valid_until DATE NOT NULL,
pct_exc_duty NUMERIC(5,3),
load_id BIGNUMERIC(38,0)
);