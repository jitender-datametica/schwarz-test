CREATE OR REPLACE VIEW lec_share.v_dim_coupon_type
AS
SELECT
	*
FROM
	core.t_dim_coupon_type
;