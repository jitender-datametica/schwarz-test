/* #DescStart#
#$Revision: 6761 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_itm_itemgroup_int_new (itemgroup_int_id, itemgroup_int_remark,
itemgroup_int_desc, language_id) AS SELECT *
FROM ldl_p_lew_mart_msi.v_itm_itemgroup_int_new;