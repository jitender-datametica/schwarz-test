CREATE OR REPLACE VIEW dbp_data_center.tv_vaus_intranet_2
AS
SELECT
*
FROM dbp_data_center.vaus_intranet_2
WHERE landessprache_fg = 1;
