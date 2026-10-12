CREATE OR REPLACE VIEW lec_share.v_dim_customer_blocked_reason
AS
SELECT
	*
FROM
	core.t_dim_customer_blocked_reason
;