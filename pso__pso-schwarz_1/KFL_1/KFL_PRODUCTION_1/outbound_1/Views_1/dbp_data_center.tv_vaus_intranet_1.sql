CREATE OR REPLACE VIEW kfl_production_dbp_data_center.tv_vaus_intranet_1 AS SELECT *
FROM kfl_production_dbp_data_center.vaus_intranet_1
WHERE landessprache_fg = 1;