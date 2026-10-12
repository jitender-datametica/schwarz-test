CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_ref_spaceman_item_merchandising_type_1 (item_merchandising_type_cd,
item_merchandising_type_cd_de, item_merchandising_type_descr, item_merchandising_type_cd_desc,
item_merchandising_type_cd_desc_de, item_merchandising_type_cd_desc_ch, item_merchandising_type_cd_desc_at,
item_merchandising_type_cd_desc_be, item_merchandising_type_cd_desc_be_fr, item_merchandising_type_cd_desc_bg,
item_merchandising_type_cd_desc_cy, item_merchandising_type_cd_desc_cz, item_merchandising_type_cd_desc_dk,
item_merchandising_type_cd_desc_es, item_merchandising_type_cd_desc_fi, item_merchandising_type_cd_desc_fr,
item_merchandising_type_cd_desc_gb, item_merchandising_type_cd_desc_gr, item_merchandising_type_cd_desc_hr,
item_merchandising_type_cd_desc_hu, item_merchandising_type_cd_desc_ie, item_merchandising_type_cd_desc_it,
item_merchandising_type_cd_desc_lt, item_merchandising_type_cd_desc_ni, item_merchandising_type_cd_desc_nl,
item_merchandising_type_cd_desc_pl, item_merchandising_type_cd_desc_pt, item_merchandising_type_cd_desc_ro,
item_merchandising_type_cd_desc_se, item_merchandising_type_cd_desc_si, item_merchandising_type_cd_desc_sk,
item_merchandising_type_cd_desc_cs, item_merchandising_type_cd_desc_mt, item_merchandising_type_cd_desc_us,
item_merchandising_type_cd_desc_rs) AS SELECT item_merchandising_type_cd,
  CASE
  WHEN item_merchandising_type_cd = 'Case'
  THEN 'VSE'
  WHEN item_merchandising_type_cd = 'Hand'
  THEN 'Einzeln'
  WHEN item_merchandising_type_cd = 'DD'
  THEN 'DD'
  WHEN item_merchandising_type_cd = 'EP'
  THEN 'EP'
  ELSE ' '
  END AS item_merchandising_type_cd_de,
 item_merchandising_type_descr,
  CASE
  WHEN item_merchandising_type_cd = 'Case'
  THEN 'VSE'
  WHEN item_merchandising_type_cd = 'Hand'
  THEN 'Einzeln'
  WHEN item_merchandising_type_cd = 'DD'
  THEN 'DD'
  WHEN item_merchandising_type_cd = 'EP'
  THEN 'EP'
  ELSE ' '
  END AS item_merchandising_type_cd_desc,
  CASE
  WHEN item_merchandising_type_cd = 'Case'
  THEN 'VSE'
  WHEN item_merchandising_type_cd = 'Hand'
  THEN 'Einzeln'
  WHEN item_merchandising_type_cd = 'DD'
  THEN 'DD'
  WHEN item_merchandising_type_cd = 'EP'
  THEN 'EP'
  ELSE ' '
  END AS item_merchandising_type_cd_desc_de,
  CASE
  WHEN item_merchandising_type_cd = 'Case'
  THEN 'VSE'
  WHEN item_merchandising_type_cd = 'Hand'
  THEN 'Einzeln'
  WHEN item_merchandising_type_cd = 'DD'
  THEN 'DD'
  WHEN item_merchandising_type_cd = 'EP'
  THEN 'EP'
  ELSE ' '
  END AS item_merchandising_type_cd_desc_ch,
  CASE
  WHEN item_merchandising_type_cd = 'Case'
  THEN 'VSE'
  WHEN item_merchandising_type_cd = 'Hand'
  THEN 'Einzeln'
  WHEN item_merchandising_type_cd = 'DD'
  THEN 'DD'
  WHEN item_merchandising_type_cd = 'EP'
  THEN 'EP'
  ELSE ' '
  END AS item_merchandising_type_cd_desc_at,
 item_merchandising_type_cd AS item_merchandising_type_cd_desc_be,
 item_merchandising_type_cd AS item_merchandising_type_cd_desc_be_fr,
 item_merchandising_type_cd AS item_merchandising_type_cd_desc_bg,
 item_merchandising_type_cd AS item_merchandising_type_cd_desc_cy,
 item_merchandising_type_cd AS item_merchandising_type_cd_desc_cz,
 item_merchandising_type_cd AS item_merchandising_type_cd_desc_dk,
 item_merchandising_type_cd AS item_merchandising_type_cd_desc_es,
 item_merchandising_type_cd AS item_merchandising_type_cd_desc_fi,
 item_merchandising_type_cd AS item_merchandising_type_cd_desc_fr,
 item_merchandising_type_cd AS item_merchandising_type_cd_desc_gb,
 item_merchandising_type_cd AS item_merchandising_type_cd_desc_gr,
 item_merchandising_type_cd AS item_merchandising_type_cd_desc_hr,
 item_merchandising_type_cd AS item_merchandising_type_cd_desc_hu,
 item_merchandising_type_cd AS item_merchandising_type_cd_desc_ie,
 item_merchandising_type_cd AS item_merchandising_type_cd_desc_it,
 item_merchandising_type_cd AS item_merchandising_type_cd_desc_lt,
 item_merchandising_type_cd AS item_merchandising_type_cd_desc_ni,
 item_merchandising_type_cd AS item_merchandising_type_cd_desc_nl,
 item_merchandising_type_cd AS item_merchandising_type_cd_desc_pl,
 item_merchandising_type_cd AS item_merchandising_type_cd_desc_pt,
 item_merchandising_type_cd AS item_merchandising_type_cd_desc_ro,
 item_merchandising_type_cd AS item_merchandising_type_cd_desc_se,
 item_merchandising_type_cd AS item_merchandising_type_cd_desc_si,
 item_merchandising_type_cd AS item_merchandising_type_cd_desc_sk,
 item_merchandising_type_cd AS item_merchandising_type_cd_desc_cs,
 item_merchandising_type_cd AS item_merchandising_type_cd_desc_mt,
 item_merchandising_type_cd AS item_merchandising_type_cd_desc_us,
 item_merchandising_type_cd AS item_merchandising_type_cd_desc_rs
FROM ldl_p_lew_core_ac.v_ref_spaceman_item_merchandising_type_1;