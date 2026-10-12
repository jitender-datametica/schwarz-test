CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_lil_period_portion_1 (period_portion_id, src_period_portion_cd,
period_portion_descr, period_portion_short_descr, period_portion_descr_en, period_portion_short_descr_en, dwh_load_id,
dwh_created, dwh_updated) AS SELECT period_portion_id,
 src_period_portion_cd,
 period_portion_descr,
 period_portion_short_descr,
 period_portion_descr_en,
 period_portion_short_descr_en,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_lil_period_portion_1;