CREATE OR REPLACE VIEW lec_share.v_fact_margin_contribution_order_line
AS
SELECT
	*
FROM
	core.t_fact_margin_contribution_order_line
;