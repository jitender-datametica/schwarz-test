CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_ref_lil_promotion_brand_2 (
promotion_brand_id BIGNUMERIC(38,0) NOT NULL,
promotion_brand_descr STRING(800),
liam1_srt_cd BIGNUMERIC(38,0),
lift1_srt_cd BIGNUMERIC(38,0),
active_fg BIGNUMERIC(38,0),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);