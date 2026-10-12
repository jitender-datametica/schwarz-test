/* #DescStart#
#$Revision: 6524 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_bo_abs_descs (client_id, country_desc, country_id, country_iso_cd,
store_id, orig_store_nr, store_desc, city, wh_id, wh_desc, sales_manager_id, sales_manager_name, account_manager_id,
account_manager_name, dat_closing_ovis) AS SELECT *
FROM ldl_p_lew_mart_msi.v_bo_abs_descs;