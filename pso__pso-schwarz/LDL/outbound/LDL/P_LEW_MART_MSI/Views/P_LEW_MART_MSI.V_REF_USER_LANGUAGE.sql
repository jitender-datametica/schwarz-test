CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ref_user_language (db_user, language_id) AS SELECT db_user,
 language_id
FROM ldl_p_lew_mart_msi.t_msi_ref_user_language;