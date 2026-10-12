/* #DescStart#
#$Revision: 11351 $, $LastChangedBy: spalmeri $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics_ac.v_item_hist_1 (client_id, item_sid, item_fam_grp_sid, item_type_sid,
item_grp_sid, item_sid_pricing_ref, pack_type_sid, uom_sid_base, uom_sid_sales, uom_sid_packaging, brand_sid,
pur_grp_nat_sid, uom_cd_base, uom_cd_sales, gross_content_val, uom_cd_packaging, pack_cont_qty, state_bges_cd,
hazardous_material_cd, pricing_ref_item_cd, tax_class_cd, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id,
dwh_created, dwh_updated) AS SELECT *
FROM ldl_p_lew_mart_analytics.v_item_hist_1;