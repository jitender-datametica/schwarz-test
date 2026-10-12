CREATE OR REPLACE VIEW dbp_data_center.tv_vaus_intranet
AS
SELECT
*
FROM dbp_data_center.vaus_intranet
WHERE landessprache_fg = 1;
