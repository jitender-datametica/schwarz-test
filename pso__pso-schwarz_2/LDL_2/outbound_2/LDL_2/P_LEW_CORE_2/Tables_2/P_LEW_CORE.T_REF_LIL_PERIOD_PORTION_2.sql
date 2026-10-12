CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_lil_period_portion_2 (
period_portion_id BIGNUMERIC(38,0) NOT NULL,
src_period_portion_cd STRING(160),
period_portion_descr STRING(800),
period_portion_short_descr STRING(160),
period_portion_descr_en STRING(800),
period_portion_short_descr_en STRING(160),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL
);