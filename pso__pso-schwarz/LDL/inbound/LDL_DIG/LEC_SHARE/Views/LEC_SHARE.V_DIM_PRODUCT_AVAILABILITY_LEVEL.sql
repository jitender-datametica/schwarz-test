CREATE OR REPLACE VIEW lec_share.v_dim_product_availability_level
AS
SELECT
	*
FROM
	core.t_dim_product_availability_level
;