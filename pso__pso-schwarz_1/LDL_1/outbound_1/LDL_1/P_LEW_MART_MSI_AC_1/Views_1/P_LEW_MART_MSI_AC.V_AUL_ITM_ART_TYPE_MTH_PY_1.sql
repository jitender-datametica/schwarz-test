/* #DescStart#
#$Revision: 6295 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_aul_itm_art_type_mth_py_1 (client_id, item_id, cy_month,
buying_list_type_id, buying_list_type_desc, buying_list_type_id_py, buying_list_type_desc_py) AS SELECT *
FROM ldl_p_lew_mart_msi.v_aul_itm_art_type_mth_py_1;