CREATE OR REPLACE VIEW lec_share.v_dim_product_online_status
AS
SELECT
	*
FROM
	core.t_dim_product_online_status
;