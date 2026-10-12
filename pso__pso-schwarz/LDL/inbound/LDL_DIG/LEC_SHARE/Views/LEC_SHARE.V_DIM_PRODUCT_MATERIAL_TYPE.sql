CREATE OR REPLACE VIEW lec_share.v_dim_product_material_type
AS
SELECT
	*
FROM
	core.t_dim_product_material_type
;