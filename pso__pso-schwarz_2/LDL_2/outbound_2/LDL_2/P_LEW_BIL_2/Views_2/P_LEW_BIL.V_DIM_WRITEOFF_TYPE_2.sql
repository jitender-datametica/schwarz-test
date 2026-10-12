CREATE OR REPLACE VIEW ldl_p_lew_bil.v_dim_writeoff_type_2 (writeoff_type_cd, writeoff_type_descr, writeoff_type_descr_de
, writeoff_type_descr_en, writeoff_type_descr_bg, writeoff_type_descr_cs, writeoff_type_descr_da, writeoff_type_descr_el
, writeoff_type_descr_es, writeoff_type_descr_fi, writeoff_type_descr_fr, writeoff_type_descr_hr, writeoff_type_descr_hu
, writeoff_type_descr_it, writeoff_type_descr_lt, writeoff_type_descr_nl, writeoff_type_descr_pl, writeoff_type_descr_pt
, writeoff_type_descr_ro, writeoff_type_descr_sh, writeoff_type_descr_sk, writeoff_type_descr_sl, writeoff_type_descr_sv
, correction_fg, dwh_load_id, dwh_created, dwh_updated) AS SELECT writeoff_type_cd,
 writeoff_type_descr,
 COALESCE(writeoff_type_descr_de, writeoff_type_descr) AS writeoff_type_descr_de,
 COALESCE(writeoff_type_descr_en, writeoff_type_descr) AS writeoff_type_descr_en,
 COALESCE(writeoff_type_descr_bg, writeoff_type_descr) AS writeoff_type_descr_bg,
 COALESCE(writeoff_type_descr_cs, writeoff_type_descr) AS writeoff_type_descr_cs,
 COALESCE(writeoff_type_descr_da, writeoff_type_descr) AS writeoff_type_descr_da,
 COALESCE(writeoff_type_descr_el, writeoff_type_descr) AS writeoff_type_descr_el,
 COALESCE(writeoff_type_descr_es, writeoff_type_descr) AS writeoff_type_descr_es,
 COALESCE(writeoff_type_descr_fi, writeoff_type_descr) AS writeoff_type_descr_fi,
 COALESCE(writeoff_type_descr_fr, writeoff_type_descr) AS writeoff_type_descr_fr,
 COALESCE(writeoff_type_descr_hr, writeoff_type_descr) AS writeoff_type_descr_hr,
 COALESCE(writeoff_type_descr_hu, writeoff_type_descr) AS writeoff_type_descr_hu,
 COALESCE(writeoff_type_descr_it, writeoff_type_descr) AS writeoff_type_descr_it,
 COALESCE(writeoff_type_descr_lt, writeoff_type_descr) AS writeoff_type_descr_lt,
 COALESCE(writeoff_type_descr_nl, writeoff_type_descr) AS writeoff_type_descr_nl,
 COALESCE(writeoff_type_descr_pl, writeoff_type_descr) AS writeoff_type_descr_pl,
 COALESCE(writeoff_type_descr_pt, writeoff_type_descr) AS writeoff_type_descr_pt,
 COALESCE(writeoff_type_descr_ro, writeoff_type_descr) AS writeoff_type_descr_ro,
 COALESCE(writeoff_type_descr_sh, writeoff_type_descr) AS writeoff_type_descr_sh,
 COALESCE(writeoff_type_descr_sk, writeoff_type_descr) AS writeoff_type_descr_sk,
 COALESCE(writeoff_type_descr_sl, writeoff_type_descr) AS writeoff_type_descr_sl,
 COALESCE(writeoff_type_descr_sv, writeoff_type_descr) AS writeoff_type_descr_sv,
 correction_fg,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_bil.t_dim_writeoff_type_2;