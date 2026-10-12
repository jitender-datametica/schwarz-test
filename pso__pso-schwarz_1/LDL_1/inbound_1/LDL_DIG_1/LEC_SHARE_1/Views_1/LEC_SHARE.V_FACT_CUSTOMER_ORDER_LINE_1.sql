CREATE OR REPLACE VIEW lec_share.v_fact_customer_order_line_1
AS
SELECT
	*
FROM
	core.t_fact_customer_order_line_1
;