CREATE OR REPLACE VIEW lec_share.v_dim_product_category_ppe_2
AS
SELECT
	prod_category_ppe_name
FROM
	core.t_dim_product_category_ppe_2
;