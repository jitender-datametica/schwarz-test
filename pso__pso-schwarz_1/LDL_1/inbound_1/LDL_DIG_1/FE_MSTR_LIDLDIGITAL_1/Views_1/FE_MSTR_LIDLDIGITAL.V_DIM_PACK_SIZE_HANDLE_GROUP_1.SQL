CREATE OR REPLACE VIEW fe_mstr_lidldigital.v_dim_pack_size_handle_group_1 
(
	pack_size_handle_group_cd
	, pack_size_handle_group_descr
) AS 
SELECT 
	pack_size_handle_group_cd
	, pack_size_handle_group_descr
FROM 
	lec_share.v_dim_pack_size_handle_group_1
UNION ALL
SELECT '-1', ''
;