CREATE OR REPLACE VIEW lec_share.v_agg_sales_daily
AS
SELECT
	*
FROM
	core.t_agg_sales_daily
;