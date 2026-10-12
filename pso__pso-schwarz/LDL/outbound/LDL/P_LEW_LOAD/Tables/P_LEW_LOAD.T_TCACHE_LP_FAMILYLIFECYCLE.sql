CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tcache_lp_familylifecycle (
client_id BIGNUMERIC(38,0),
customer_sid BIGNUMERIC(38,0),
child_age_range_cd STRING(100),
child_age_range_forecasted_fg BIGNUMERIC(38,0),
extraction_dt DATE,
dwh_load_id BIGNUMERIC(38,0),
dwh_created DATETIME,
dwh_updated DATETIME
);