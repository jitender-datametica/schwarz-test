CREATE OR REPLACE VIEW FE_MSTR_EKPSNF.V_DIM_NFPO_ITEM_FAMILY_GROUP_1(
	 nfpo_item_fam_grp_sid
	,nfpo_item_fam_grp_nr
	,nfpo_item_fam_grp_name
	,nfpo_item_fam_grp_display_name
	,nfpo_assortment_area_id
	,nfpo_assortment_area_name
	,dwh_created_tmsp
	,dwh_updated_tmsp
	,dwh_src_tmsp
) AS
(SELECT 
	 nfpo_item_fam_grp_sid
	,nfpo_item_fam_grp_nr
	,nfpo_item_fam_grp_name
	,nfpo_item_fam_grp_nr || ' ' ||nfpo_item_fam_grp_name AS nfpo_item_fam_grp_display_name
	,nfpo_assortment_area_id
	,nfpo_assortment_area_name
	,dwh_created_tmsp
	,dwh_updated_tmsp
	,dwh_src_tmsp
FROM CORE.T_DIM_NFPO_ITEM_FAMILY_GROUP_1
);