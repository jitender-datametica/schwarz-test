CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_AUL_ITM_ART_TYPE_MTH_PY
/*
#DescStart#
#$Revision: 6295 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
client_id
, item_id
, cy_month
, buying_list_type_id
, buying_list_type_desc
, buying_list_type_id_py
, buying_list_type_desc_py
 )
AS
SELECT
client_id,
item_id,
cy_month,
buying_list_type_id,
buying_list_type_desc,
buying_list_type_id_py,
buying_list_type_desc_py
FROM p_lew_mart_msi.v_aul_itm_art_type_mth_py;


