CREATE OR REPLACE VIEW lec_share.v_dim_product_listing_status
AS
SELECT
	*
FROM
	core.t_dim_product_listing_status
;