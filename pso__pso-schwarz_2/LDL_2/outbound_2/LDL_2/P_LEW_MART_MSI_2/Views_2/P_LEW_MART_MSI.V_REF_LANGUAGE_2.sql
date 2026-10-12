CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ref_language_2 AS SELECT L.language_id,
 L.language_desc,
 L.language_iso_cd
FROM ldl_p_lew_core_ac.v_wawi_ref_language_2 AS L
 INNER JOIN ldl_p_lew_mart_msi.t_msi_ref_user_language_2 AS RUL ON L.language_id = RUL.language_id AND SESSION_USER() =
   RUL.db_user;