CREATE OR REPLACE VIEW kfl_production_dbp_data_center.tv_vaus_intranet_transcript AS SELECT *
FROM kfl_production_dbp_data_center.vaus_intranet
WHERE landessprache_fg = 0;