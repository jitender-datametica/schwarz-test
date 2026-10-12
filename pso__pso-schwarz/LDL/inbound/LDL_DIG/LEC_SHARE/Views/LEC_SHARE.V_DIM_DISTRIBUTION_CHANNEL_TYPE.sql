CREATE OR REPLACE VIEW lec_share.v_dim_distribution_channel_type
AS
SELECT
	*
FROM
	core.t_dim_distribution_channel_type
;