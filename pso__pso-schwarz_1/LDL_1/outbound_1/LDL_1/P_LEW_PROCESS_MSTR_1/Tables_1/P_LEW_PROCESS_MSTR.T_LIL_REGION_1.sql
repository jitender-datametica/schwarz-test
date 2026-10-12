CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_lil_region_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
region_sid BIGNUMERIC(38,0) NOT NULL,
region_id BIGNUMERIC(38,0) NOT NULL,
src_region_cd STRING(160) NOT NULL,
region_name_en STRING(160),
region_name_de STRING(160),
region_short_desc STRING(800),
region_long_desc STRING(800),
region_srt_cd BIGNUMERIC(38,0),
qr_srt_cd BIGNUMERIC(38,0),
region_lvl BIGNUMERIC(38,0),
sd_chld_below_12 STRING(800),
sd_chld_over_12 STRING(800),
active_fg BIGNUMERIC(38,0),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL
);