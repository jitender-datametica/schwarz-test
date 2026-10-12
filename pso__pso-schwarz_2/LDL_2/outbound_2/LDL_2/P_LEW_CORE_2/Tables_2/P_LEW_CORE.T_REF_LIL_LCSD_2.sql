CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_lil_lcsd_2 (
lcsd_id BIGNUMERIC(38,0) NOT NULL,
lcsd_cd STRING(800) NOT NULL,
lcsd_descr STRING(800),
lcsd_short_descr STRING(800),
lcsd_explain STRING(800),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);