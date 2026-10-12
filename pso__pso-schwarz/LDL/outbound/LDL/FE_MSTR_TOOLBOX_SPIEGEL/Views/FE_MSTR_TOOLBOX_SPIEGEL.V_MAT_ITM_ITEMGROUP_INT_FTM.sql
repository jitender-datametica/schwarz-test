CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_mat_itm_itemgroup_int_ftm (itemgroup_int_id, itemgroup_int_desc_at
, itemgroup_int_desc_be, itemgroup_int_desc_be_fr, itemgroup_int_desc_bg, itemgroup_int_desc_ch, itemgroup_int_desc_cy,
itemgroup_int_desc_cz, itemgroup_int_desc, itemgroup_int_desc_dk, itemgroup_int_desc_es, itemgroup_int_desc_fi,
itemgroup_int_desc_fr, itemgroup_int_desc_gb, itemgroup_int_desc_gr, itemgroup_int_desc_hr, itemgroup_int_desc_hu,
itemgroup_int_desc_ie, itemgroup_int_desc_it, itemgroup_int_desc_lt, itemgroup_int_desc_ni, itemgroup_int_desc_nl,
itemgroup_int_desc_de, itemgroup_int_desc_pl, itemgroup_int_desc_pt, itemgroup_int_desc_ro, itemgroup_int_desc_se,
itemgroup_int_desc_si, itemgroup_int_desc_sk, itemgroup_int_desc_cs, itemgroup_int_desc_mt, itemgroup_int_desc_us,
itemgroup_int_desc_rs, itemgroup_int_long_desc_at, itemgroup_int_long_desc_be, itemgroup_int_long_desc_be_fr,
itemgroup_int_long_desc_bg, itemgroup_int_long_desc_ch, itemgroup_int_long_desc_cy, itemgroup_int_long_desc_cz,
itemgroup_int_long_desc, itemgroup_int_long_desc_dk, itemgroup_int_long_desc_es, itemgroup_int_long_desc_fi,
itemgroup_int_long_desc_fr, itemgroup_int_long_desc_gb, itemgroup_int_long_desc_gr, itemgroup_int_long_desc_hr,
itemgroup_int_long_desc_hu, itemgroup_int_long_desc_ie, itemgroup_int_long_desc_it, itemgroup_int_long_desc_lt,
itemgroup_int_long_desc_ni, itemgroup_int_long_desc_nl, itemgroup_int_long_desc_de, itemgroup_int_long_desc_pl,
itemgroup_int_long_desc_pt, itemgroup_int_long_desc_ro, itemgroup_int_long_desc_se, itemgroup_int_long_desc_si,
itemgroup_int_long_desc_sk, itemgroup_int_long_desc_cs, itemgroup_int_long_desc_mt, itemgroup_int_long_desc_us,
itemgroup_int_long_desc_rs) AS /* _DE as ITEMGROUP_INT_DESC has the ids in the description */
/* _GB as _US as the ids in the description */ SELECT itemgroup_int_id,
 itemgroup_int_desc_cz AS itemgroup_int_desc_at,
  CASE
  WHEN itemgroup_int_id = - 1
  THEN itemgroup_int_desc_be
  ELSE itemgroup_int_desc_cy
  END AS itemgroup_int_desc_be,
  CASE
  WHEN itemgroup_int_id = - 1
  THEN itemgroup_int_desc_be_fr
  ELSE itemgroup_int_desc_cy
  END AS itemgroup_int_desc_be_fr,
 itemgroup_int_desc_ch AS itemgroup_int_desc_bg,
 itemgroup_int_desc_bg AS itemgroup_int_desc_ch,
 itemgroup_int_desc_be AS itemgroup_int_desc_cy,
 itemgroup_int_desc_at AS itemgroup_int_desc_cz,
 itemgroup_int_desc,
 itemgroup_int_desc_dk,
 itemgroup_int_desc_es,
 itemgroup_int_desc_fi,
 itemgroup_int_desc_fr,
 itemgroup_int_desc_gb,
 itemgroup_int_desc_gr,
 itemgroup_int_desc_hr,
 itemgroup_int_desc_hu,
 itemgroup_int_desc_ie,
 itemgroup_int_desc_it,
 itemgroup_int_desc_lt,
 itemgroup_int_desc_ni,
 itemgroup_int_desc_nl,
 itemgroup_int_desc_de,
 itemgroup_int_desc_pl,
 itemgroup_int_desc_pt,
 itemgroup_int_desc_ro,
 itemgroup_int_desc_se,
 itemgroup_int_desc_si,
 itemgroup_int_desc_sk,
 itemgroup_int_desc_cs,
 itemgroup_int_desc_mt,
 itemgroup_int_desc_us,
 itemgroup_int_desc_rs,
  CASE
  WHEN itemgroup_int_id = - 1
  THEN '       ' || itemgroup_int_desc_at
  ELSE CAST(itemgroup_int_id AS STRING) || ' : ' || itemgroup_int_desc_at
  END AS itemgroup_int_long_desc_at,
  CASE
  WHEN itemgroup_int_id = - 1
  THEN '       ' || itemgroup_int_desc_be
  ELSE CAST(itemgroup_int_id AS STRING) || ' : ' || itemgroup_int_desc_be
  END AS itemgroup_int_long_desc_be,
  CASE
  WHEN itemgroup_int_id = - 1
  THEN '       ' || itemgroup_int_desc_be_fr
  ELSE CAST(itemgroup_int_id AS STRING) || ' : ' || itemgroup_int_desc_be
  END AS itemgroup_int_long_desc_be_fr,
  CASE
  WHEN itemgroup_int_id = - 1
  THEN '       ' || itemgroup_int_desc_bg
  ELSE CAST(itemgroup_int_id AS STRING) || ' : ' || itemgroup_int_desc_bg
  END AS itemgroup_int_long_desc_bg,
  CASE
  WHEN itemgroup_int_id = - 1
  THEN '       ' || itemgroup_int_desc_ch
  ELSE CAST(itemgroup_int_id AS STRING) || ' : ' || itemgroup_int_desc_ch
  END AS itemgroup_int_long_desc_ch,
  CASE
  WHEN itemgroup_int_id = - 1
  THEN '       ' || itemgroup_int_desc_cy
  ELSE CAST(itemgroup_int_id AS STRING) || ' : ' || itemgroup_int_desc_cy
  END AS itemgroup_int_long_desc_cy,
  CASE
  WHEN itemgroup_int_id = - 1
  THEN '       ' || itemgroup_int_desc_cz
  ELSE CAST(itemgroup_int_id AS STRING) || ' : ' || itemgroup_int_desc_cz
  END AS itemgroup_int_long_desc_cz,
  CASE
  WHEN itemgroup_int_id = - 1
  THEN '       ' || itemgroup_int_desc
  ELSE CAST(itemgroup_int_id AS STRING) || ' : ' || itemgroup_int_desc
  END AS itemgroup_int_long_desc,
  CASE
  WHEN itemgroup_int_id = - 1
  THEN '       ' || itemgroup_int_desc_dk
  ELSE CAST(itemgroup_int_id AS STRING) || ' : ' || itemgroup_int_desc_dk
  END AS itemgroup_int_long_desc_dk,
  CASE
  WHEN itemgroup_int_id = - 1
  THEN '       ' || itemgroup_int_desc_es
  ELSE CAST(itemgroup_int_id AS STRING) || ' : ' || itemgroup_int_desc_es
  END AS itemgroup_int_long_desc_es,
  CASE
  WHEN itemgroup_int_id = - 1
  THEN '       ' || itemgroup_int_desc_fi
  ELSE CAST(itemgroup_int_id AS STRING) || ' : ' || itemgroup_int_desc_fi
  END AS itemgroup_int_long_desc_fi,
  CASE
  WHEN itemgroup_int_id = - 1
  THEN '       ' || itemgroup_int_desc_fr
  ELSE CAST(itemgroup_int_id AS STRING) || ' : ' || itemgroup_int_desc_fr
  END AS itemgroup_int_long_desc_fr,
  CASE
  WHEN itemgroup_int_id = - 1
  THEN '       ' || itemgroup_int_desc_gb
  ELSE CAST(itemgroup_int_id AS STRING) || ' : ' || itemgroup_int_desc_gb
  END AS itemgroup_int_long_desc_gb,
  CASE
  WHEN itemgroup_int_id = - 1
  THEN '       ' || itemgroup_int_desc_gr
  ELSE CAST(itemgroup_int_id AS STRING) || ' : ' || itemgroup_int_desc_gr
  END AS itemgroup_int_long_desc_gr,
  CASE
  WHEN itemgroup_int_id = - 1
  THEN '       ' || itemgroup_int_desc_hr
  ELSE CAST(itemgroup_int_id AS STRING) || ' : ' || itemgroup_int_desc_hr
  END AS itemgroup_int_long_desc_hr,
  CASE
  WHEN itemgroup_int_id = - 1
  THEN '       ' || itemgroup_int_desc_hu
  ELSE CAST(itemgroup_int_id AS STRING) || ' : ' || itemgroup_int_desc_hu
  END AS itemgroup_int_long_desc_hu,
  CASE
  WHEN itemgroup_int_id = - 1
  THEN '       ' || itemgroup_int_desc_ie
  ELSE CAST(itemgroup_int_id AS STRING) || ' : ' || itemgroup_int_desc_ie
  END AS itemgroup_int_long_desc_ie,
  CASE
  WHEN itemgroup_int_id = - 1
  THEN '       ' || itemgroup_int_desc_it
  ELSE CAST(itemgroup_int_id AS STRING) || ' : ' || itemgroup_int_desc_it
  END AS itemgroup_int_long_desc_it,
  CASE
  WHEN itemgroup_int_id = - 1
  THEN '       ' || itemgroup_int_desc_lt
  ELSE CAST(itemgroup_int_id AS STRING) || ' : ' || itemgroup_int_desc_lt
  END AS itemgroup_int_long_desc_lt,
  CASE
  WHEN itemgroup_int_id = - 1
  THEN '       ' || itemgroup_int_desc_ni
  ELSE CAST(itemgroup_int_id AS STRING) || ' : ' || itemgroup_int_desc_ni
  END AS itemgroup_int_long_desc_ni,
  CASE
  WHEN itemgroup_int_id = - 1
  THEN '       ' || itemgroup_int_desc_nl
  ELSE CAST(itemgroup_int_id AS STRING) || ' : ' || itemgroup_int_desc_nl
  END AS itemgroup_int_long_desc_nl,
  CASE
  WHEN itemgroup_int_id = - 1
  THEN '       ' || itemgroup_int_desc_de
  ELSE CAST(itemgroup_int_id AS STRING) || ' : ' || itemgroup_int_desc_de
  END AS itemgroup_int_long_desc_de,
  CASE
  WHEN itemgroup_int_id = - 1
  THEN '       ' || itemgroup_int_desc_pl
  ELSE CAST(itemgroup_int_id AS STRING) || ' : ' || itemgroup_int_desc_pl
  END AS itemgroup_int_long_desc_pl,
  CASE
  WHEN itemgroup_int_id = - 1
  THEN '       ' || itemgroup_int_desc_pt
  ELSE CAST(itemgroup_int_id AS STRING) || ' : ' || itemgroup_int_desc_pt
  END AS itemgroup_int_long_desc_pt,
  CASE
  WHEN itemgroup_int_id = - 1
  THEN '       ' || itemgroup_int_desc_ro
  ELSE CAST(itemgroup_int_id AS STRING) || ' : ' || itemgroup_int_desc_ro
  END AS itemgroup_int_long_desc_ro,
  CASE
  WHEN itemgroup_int_id = - 1
  THEN '       ' || itemgroup_int_desc_se
  ELSE CAST(itemgroup_int_id AS STRING) || ' : ' || itemgroup_int_desc_se
  END AS itemgroup_int_long_desc_se,
  CASE
  WHEN itemgroup_int_id = - 1
  THEN '       ' || itemgroup_int_desc_si
  ELSE CAST(itemgroup_int_id AS STRING) || ' : ' || itemgroup_int_desc_si
  END AS itemgroup_int_long_desc_si,
  CASE
  WHEN itemgroup_int_id = - 1
  THEN '       ' || itemgroup_int_desc_sk
  ELSE CAST(itemgroup_int_id AS STRING) || ' : ' || itemgroup_int_desc_sk
  END AS itemgroup_int_long_desc_sk,
  CASE
  WHEN itemgroup_int_id = - 1
  THEN '       ' || itemgroup_int_desc_cs
  ELSE CAST(itemgroup_int_id AS STRING) || ' : ' || itemgroup_int_desc_cs
  END AS itemgroup_int_long_desc_cs,
  CASE
  WHEN itemgroup_int_id = - 1
  THEN '       ' || itemgroup_int_desc_mt
  ELSE CAST(itemgroup_int_id AS STRING) || ' : ' || itemgroup_int_desc_mt
  END AS itemgroup_int_long_desc_mt,
  CASE
  WHEN itemgroup_int_id = - 1
  THEN '       ' || itemgroup_int_desc_us
  ELSE CAST(itemgroup_int_id AS STRING) || ' : ' || itemgroup_int_desc_us
  END AS itemgroup_int_long_desc_us,
  CASE
  WHEN itemgroup_int_id = - 1
  THEN '       ' || itemgroup_int_desc_rs
  ELSE CAST(itemgroup_int_id AS STRING) || ' : ' || itemgroup_int_desc_rs
  END AS itemgroup_int_long_desc_rs
FROM (SELECT itemgroup_int_id,
    itemgroup_int_desc_at,
    itemgroup_int_desc_be,
    itemgroup_int_desc_be_fr,
    itemgroup_int_desc_bg,
    itemgroup_int_desc_ch,
    itemgroup_int_desc_cy,
    itemgroup_int_desc_cz,
    itemgroup_int_desc_de AS itemgroup_int_desc,
    itemgroup_int_desc_dk,
    itemgroup_int_desc_es,
    itemgroup_int_desc_fi,
    itemgroup_int_desc_fr,
    itemgroup_int_desc_gb,
    itemgroup_int_desc_gr,
    itemgroup_int_desc_hr,
    itemgroup_int_desc_hu,
    itemgroup_int_desc_ie,
    itemgroup_int_desc_it,
    itemgroup_int_desc_lt,
    itemgroup_int_desc_ni,
    itemgroup_int_desc_nl,
    itemgroup_int_desc_de,
    itemgroup_int_desc_pl,
    itemgroup_int_desc_pt,
    itemgroup_int_desc_ro,
    itemgroup_int_desc_se,
    itemgroup_int_desc_si,
    itemgroup_int_desc_sk,
    itemgroup_int_desc_cs,
    itemgroup_int_desc_mt,
    itemgroup_int_desc_gb AS itemgroup_int_desc_us,
    itemgroup_int_desc_rs
   FROM ldl_p_lew_mart_msi_ac.v_itm_itemgroup_int
   UNION ALL
   SELECT DISTINCT - 1 AS itemgroup_int_id,
    'Gesamt' AS itemgroup_int_desc_at,
    'Gesamt' AS itemgroup_int_desc_be,
    'Gesamt' AS itemgroup_int_desc_be_fr,
    'Gesamt' AS itemgroup_int_desc_bg,
    'Gesamt' AS itemgroup_int_desc_ch,
    'Gesamt' AS itemgroup_int_desc_cy,
    'Gesamt' AS itemgroup_int_desc_cz,
    'Gesamt' AS itemgroup_int_desc,
    'Gesamt' AS itemgroup_int_desc_dk,
    'Gesamt' AS itemgroup_int_desc_es,
    'Gesamt' AS itemgroup_int_desc_fi,
    'Gesamt' AS itemgroup_int_desc_fr,
    'Gesamt' AS itemgroup_int_desc_gb,
    'Gesamt' AS itemgroup_int_desc_gr,
    'Gesamt' AS itemgroup_int_desc_hr,
    'Gesamt' AS itemgroup_int_desc_hu,
    'Gesamt' AS itemgroup_int_desc_ie,
    'Gesamt' AS itemgroup_int_desc_it,
    'Gesamt' AS itemgroup_int_desc_lt,
    'Gesamt' AS itemgroup_int_desc_ni,
    'Gesamt' AS itemgroup_int_desc_nl,
    'Gesamt' AS itemgroup_int_desc_de,
    'Gesamt' AS itemgroup_int_desc_pl,
    'Gesamt' AS itemgroup_int_desc_pt,
    'Gesamt' AS itemgroup_int_desc_ro,
    'Gesamt' AS itemgroup_int_desc_se,
    'Gesamt' AS itemgroup_int_desc_si,
    'Gesamt' AS itemgroup_int_desc_sk,
    'Gesamt' AS itemgroup_int_desc_cs,
    'Gesamt' AS itemgroup_int_desc_mt,
    'Gesamt' AS itemgroup_int_desc_us,
    'Gesamt' AS itemgroup_int_desc_rs
   FROM ldl_p_lew_mart_msi_ac.v_itm_itemgroup_int) AS itg;