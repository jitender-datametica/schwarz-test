CREATE OR REPLACE VIEW lec_share.v_fact_intercompany_order_line
AS
SELECT
	*
FROM
	core.t_fact_intercompany_order_line
;