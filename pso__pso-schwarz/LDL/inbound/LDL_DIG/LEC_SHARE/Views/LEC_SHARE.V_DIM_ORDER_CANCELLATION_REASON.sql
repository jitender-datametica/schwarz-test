CREATE OR REPLACE VIEW lec_share.v_dim_order_cancellation_reason
AS
SELECT
	*
FROM
	core.t_dim_order_cancellation_reason
;