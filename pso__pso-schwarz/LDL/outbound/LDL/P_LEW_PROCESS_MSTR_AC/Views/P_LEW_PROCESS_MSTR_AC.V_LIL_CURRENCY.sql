CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_lil_currency (currency_iso_cd, currency_desc, currency_srt_cd,
dwh_load_id, dwh_created, dwh_updated) AS SELECT currency_iso_cd,
 currency_desc,
 currency_srt_cd,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process_mstr.t_lil_currency;