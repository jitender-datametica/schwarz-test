CREATE OR REPLACE VIEW lec_share.v_dim_customer_order_position_delivery_status
AS
SELECT
	*
FROM
	core.t_dim_customer_order_position_delivery_status
;