CREATE OR REPLACE VIEW dbp_data_center.tv_vaus_intranet_transcript_1
AS
SELECT
*
FROM dbp_data_center.vaus_intranet_1
WHERE landessprache_fg = 0;
