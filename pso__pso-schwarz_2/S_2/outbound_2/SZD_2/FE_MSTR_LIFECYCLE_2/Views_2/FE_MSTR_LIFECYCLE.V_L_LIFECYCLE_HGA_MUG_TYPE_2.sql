CREATE OR REPLACE VIEW szd_fe_mstr_lifecycle.v_l_lifecycle_hga_mug_type_2 (mug_type_id, mug_type_descr_de, mug_type_descr
, mug_type_descr_ch, mug_type_descr_en, mug_type_descr_cz, mug_type_descr_lt, mug_type_descr_sk, mug_type_descr_si,
mug_type_descr_ro) AS SELECT mug_type_id,
 mug_type_descr_de,
 mug_type_descr_de AS mug_type_descr,
 mug_type_descr_de AS mug_type_descr_ch,
 mug_type_descr AS mug_type_descr_en,
 mug_type_descr AS mug_type_descr_cz,
 mug_type_descr AS mug_type_descr_lt,
 mug_type_descr AS mug_type_descr_sk,
 mug_type_descr AS mug_type_descr_si,
 mug_type_descr AS mug_type_descr_ro
FROM szd_core.t_dim_hga_mug_type_2;