CREATE OR REPLACE VIEW lec_share.v_dim_sales_channel_type
AS
SELECT
	*
FROM
	core.t_dim_sales_channel_type
;