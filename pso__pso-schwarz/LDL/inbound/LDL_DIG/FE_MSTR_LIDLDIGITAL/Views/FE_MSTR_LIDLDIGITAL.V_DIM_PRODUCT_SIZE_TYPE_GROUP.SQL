CREATE OR REPLACE VIEW fe_mstr_lidldigital.v_dim_product_size_type_group 
(
	prod_size_type_group_cd
	, prod_size_type_group_descr
) AS 
SELECT 
	prod_size_type_group_cd
	, prod_size_type_group_descr
FROM 
	lec_share.v_dim_product_size_type_group
UNION ALL
SELECT '-1', ''
;