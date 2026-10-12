CREATE OR REPLACE VIEW lec_share.v_dim_product_category_ppe
AS
SELECT
	prod_category_ppe_name
FROM
	core.t_dim_product_category_ppe
;