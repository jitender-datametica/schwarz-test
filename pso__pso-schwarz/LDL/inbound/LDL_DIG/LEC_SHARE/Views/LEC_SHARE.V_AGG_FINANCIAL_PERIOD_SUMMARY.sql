CREATE OR REPLACE VIEW lec_share.v_agg_financial_period_summary
AS
SELECT
	*
FROM
	core.t_agg_financial_period_summary
;