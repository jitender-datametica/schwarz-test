CREATE OR REPLACE VIEW lec_share.v_dim_delivery_order_status
AS
SELECT
	*
FROM
	core.t_dim_delivery_order_status
;