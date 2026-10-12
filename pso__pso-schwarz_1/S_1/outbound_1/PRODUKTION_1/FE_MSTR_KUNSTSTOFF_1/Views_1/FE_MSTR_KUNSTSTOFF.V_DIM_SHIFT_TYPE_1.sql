CREATE OR REPLACE VIEW produktion_fe_mstr_kunststoff.v_dim_shift_type_1 (shift_type_id, shift_type_descr,
shift_type_descr_de, shift_type_descr_en) AS SELECT shift_type_id,
 shift_type_descr,
 shift_type_descr_de,
 shift_type_descr_en
FROM produktion_core.t_dim_shift_type_1;