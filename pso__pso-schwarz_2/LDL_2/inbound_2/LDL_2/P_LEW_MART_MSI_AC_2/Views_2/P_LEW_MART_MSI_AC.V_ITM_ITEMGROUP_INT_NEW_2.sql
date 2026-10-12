CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_ITM_ITEMGROUP_INT_NEW_2
/*
#DescStart#
#$Revision: 6761 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    itemgroup_int_id
    , itemgroup_int_remark
    , itemgroup_int_desc
    , language_id
)
AS
SELECT
itemgroup_int_id,
itemgroup_int_remark,
itemgroup_int_desc,
language_id
FROM p_lew_mart_msi.v_itm_itemgroup_int_new_2
;


