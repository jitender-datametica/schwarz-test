CREATE OR REPLACE VIEW smp_production_data_shared_ldl.p_lew_core_t_cal_month_descr (month_id, lang_sid, lang_cd,
month_descr, month_descr_short, dwh_load_id, dwh_created, dwh_updated) AS SELECT month_id,
 lang_sid,
 lang_cd,
 month_descr,
 month_descr_short,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_cal_month_descr;