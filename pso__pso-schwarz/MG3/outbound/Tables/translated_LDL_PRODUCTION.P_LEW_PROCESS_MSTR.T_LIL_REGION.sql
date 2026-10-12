CREATE OR REPLACE TABLE ldl_production_p_lew_process_mstr.t_lil_region (
client_id INTEGER NOT NULL,
region_sid INTEGER NOT NULL,
region_id INTEGER NOT NULL,
src_region_cd STRING(160) NOT NULL,
region_name_en STRING(160),
region_name_de STRING(160),
region_short_desc STRING(800),
region_long_desc STRING(800),
region_srt_cd INTEGER,
qr_srt_cd INTEGER,
region_lvl INTEGER,
sd_chld_below_12 STRING(800),
sd_chld_over_12 STRING(800),
active_fg INTEGER,
dwh_load_id INTEGER NOT NULL,
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL
);