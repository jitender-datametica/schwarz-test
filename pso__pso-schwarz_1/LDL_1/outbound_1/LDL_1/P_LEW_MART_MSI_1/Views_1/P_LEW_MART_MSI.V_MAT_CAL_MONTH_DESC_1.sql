CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_cal_month_desc_1 (month_id, cy_month, cy, byr, cy_month_name_at,
cy_month_name_be, cy_month_name_be_fr, cy_month_name_bg, cy_month_name_ch, cy_month_name_cy, cy_month_name_cz,
cy_month_name, cy_month_name_dk, cy_month_name_ee, cy_month_name_es, cy_month_name_fi, cy_month_name_fr,
cy_month_name_gb, cy_month_name_gr, cy_month_name_hr, cy_month_name_hu, cy_month_name_ie, cy_month_name_it,
cy_month_name_lt, cy_month_name_lv, cy_month_name_ni, cy_month_name_nl, cy_month_name_de, cy_month_name_pl,
cy_month_name_pt, cy_month_name_ro, cy_month_name_se, cy_month_name_si, cy_month_name_sk, cy_month_name_cs,
cy_month_name_mt, cy_month_name_us, cy_month_name_rs, cy_month_name_short_at, cy_month_name_short_be,
cy_month_name_short_be_fr, cy_month_name_short_bg, cy_month_name_short_ch, cy_month_name_short_cy,
cy_month_name_short_cz, cy_month_name_short, cy_month_name_short_dk, cy_month_name_short_ee, cy_month_name_short_es,
cy_month_name_short_fi, cy_month_name_short_fr, cy_month_name_short_gb, cy_month_name_short_gr, cy_month_name_short_hr,
cy_month_name_short_hu, cy_month_name_short_ie, cy_month_name_short_it, cy_month_name_short_lt, cy_month_name_short_lv,
cy_month_name_short_ni, cy_month_name_short_nl, cy_month_name_short_de, cy_month_name_short_pl, cy_month_name_short_pt,
cy_month_name_short_ro, cy_month_name_short_se, cy_month_name_short_si, cy_month_name_short_sk, cy_month_name_short_cs,
cy_month_name_short_mt, cy_month_name_short_us, cy_month_name_short_rs, month_name_at, month_name_be, month_name_be_fr,
month_name_bg, month_name_ch, month_name_cy, month_name_cz, month_name, month_name_dk, month_name_ee, month_name_es,
month_name_fi, month_name_fr, month_name_gb, month_name_gr, month_name_hr, month_name_hu, month_name_ie, month_name_it,
month_name_lt, month_name_lv, month_name_ni, month_name_nl, month_name_de, month_name_pl, month_name_pt, month_name_ro,
month_name_se, month_name_si, month_name_sk, month_name_cs, month_name_mt, month_name_us, month_name_rs) AS SELECT
 `_month_id` AS month_id,
 cy_month,
 cy,
 byr,
   TRIM(month_name_at) || ' ' || TRIM(SUBSTR(CAST(cy AS STRING), 1, 39)) AS cy_month_name_at,
   TRIM(month_name_be) || ' ' || TRIM(SUBSTR(CAST(cy AS STRING), 1, 39)) AS cy_month_name_be,
   TRIM(month_name_fr) || ' ' || TRIM(SUBSTR(CAST(cy AS STRING), 1, 39)) AS cy_month_name_be_fr,
   TRIM(month_name_bg) || ' ' || TRIM(SUBSTR(CAST(cy AS STRING), 1, 39)) AS cy_month_name_bg,
   TRIM(month_name_ch) || ' ' || TRIM(SUBSTR(CAST(cy AS STRING), 1, 39)) AS cy_month_name_ch,
   TRIM(month_name_cy) || ' ' || TRIM(SUBSTR(CAST(cy AS STRING), 1, 39)) AS cy_month_name_cy,
   TRIM(month_name_cz) || ' ' || TRIM(SUBSTR(CAST(cy AS STRING), 1, 39)) AS cy_month_name_cz,
   TRIM(month_name) || ' ' || TRIM(SUBSTR(CAST(cy AS STRING), 1, 39)) AS cy_month_name,
   TRIM(month_name_dk) || ' ' || TRIM(SUBSTR(CAST(cy AS STRING), 1, 39)) AS cy_month_name_dk,
   TRIM(month_name_ee) || ' ' || TRIM(SUBSTR(CAST(cy AS STRING), 1, 39)) AS cy_month_name_ee,
   TRIM(month_name_es) || ' ' || TRIM(SUBSTR(CAST(cy AS STRING), 1, 39)) AS cy_month_name_es,
   TRIM(month_name_fi) || ' ' || TRIM(SUBSTR(CAST(cy AS STRING), 1, 39)) AS cy_month_name_fi,
   TRIM(month_name_fr) || ' ' || TRIM(SUBSTR(CAST(cy AS STRING), 1, 39)) AS cy_month_name_fr,
   TRIM(month_name_gb) || ' ' || TRIM(SUBSTR(CAST(cy AS STRING), 1, 39)) AS cy_month_name_gb,
   TRIM(month_name_gr) || ' ' || TRIM(SUBSTR(CAST(cy AS STRING), 1, 39)) AS cy_month_name_gr,
   TRIM(month_name_hr) || ' ' || TRIM(SUBSTR(CAST(cy AS STRING), 1, 39)) AS cy_month_name_hr,
   TRIM(month_name_hu) || ' ' || TRIM(SUBSTR(CAST(cy AS STRING), 1, 39)) AS cy_month_name_hu,
   TRIM(month_name_ie) || ' ' || TRIM(SUBSTR(CAST(cy AS STRING), 1, 39)) AS cy_month_name_ie,
   TRIM(month_name_it) || ' ' || TRIM(SUBSTR(CAST(cy AS STRING), 1, 39)) AS cy_month_name_it,
   TRIM(month_name_lt) || ' ' || TRIM(SUBSTR(CAST(cy AS STRING), 1, 39)) AS cy_month_name_lt,
   TRIM(month_name_lv) || ' ' || TRIM(SUBSTR(CAST(cy AS STRING), 1, 39)) AS cy_month_name_lv,
   TRIM(month_name_ni) || ' ' || TRIM(SUBSTR(CAST(cy AS STRING), 1, 39)) AS cy_month_name_ni,
   TRIM(month_name_nl) || ' ' || TRIM(SUBSTR(CAST(cy AS STRING), 1, 39)) AS cy_month_name_nl,
   TRIM(month_name_de) || ' ' || TRIM(SUBSTR(CAST(cy AS STRING), 1, 39)) AS cy_month_name_de,
   TRIM(month_name_pl) || ' ' || TRIM(SUBSTR(CAST(cy AS STRING), 1, 39)) AS cy_month_name_pl,
   TRIM(month_name_pt) || ' ' || TRIM(SUBSTR(CAST(cy AS STRING), 1, 39)) AS cy_month_name_pt,
   TRIM(month_name_ro) || ' ' || TRIM(SUBSTR(CAST(cy AS STRING), 1, 39)) AS cy_month_name_ro,
   TRIM(month_name_se) || ' ' || TRIM(SUBSTR(CAST(cy AS STRING), 1, 39)) AS cy_month_name_se,
   TRIM(month_name_si) || ' ' || TRIM(SUBSTR(CAST(cy AS STRING), 1, 39)) AS cy_month_name_si,
   TRIM(month_name_sk) || ' ' || TRIM(SUBSTR(CAST(cy AS STRING), 1, 39)) AS cy_month_name_sk,
   TRIM(month_name_cs) || ' ' || TRIM(SUBSTR(CAST(cy AS STRING), 1, 39)) AS cy_month_name_cs,
   TRIM(month_name_mt) || ' ' || TRIM(SUBSTR(CAST(cy AS STRING), 1, 39)) AS cy_month_name_mt,
   TRIM(month_name_us) || ' ' || TRIM(SUBSTR(CAST(cy AS STRING), 1, 39)) AS cy_month_name_us,
   TRIM(month_name_rs) || ' ' || TRIM(SUBSTR(CAST(cy AS STRING), 1, 39)) AS cy_month_name_rs,
 cy_month_name_short_at,
 cy_month_name_short_be,
 cy_month_name_short_fr AS cy_month_name_short_be_fr,
 cy_month_name_short_bg,
 cy_month_name_short_ch,
 cy_month_name_short_cy,
 cy_month_name_short_cz,
 cy_month_name_short,
 cy_month_name_short_dk,
 cy_month_name_short_ee,
 cy_month_name_short_es,
 cy_month_name_short_fi,
 cy_month_name_short_fr,
 cy_month_name_short_gb,
 cy_month_name_short_gr,
 cy_month_name_short_hr,
 cy_month_name_short_hu,
 cy_month_name_short_ie,
 cy_month_name_short_it,
 cy_month_name_short_lt,
 cy_month_name_short_lv,
 cy_month_name_short_ni,
 cy_month_name_short_nl,
 cy_month_name_short_de,
 cy_month_name_short_pl,
 cy_month_name_short_pt,
 cy_month_name_short_ro,
 cy_month_name_short_se,
 cy_month_name_short_si,
 cy_month_name_short_sk,
 cy_month_name_short_cs,
 cy_month_name_short_mt,
 cy_month_name_short_us,
 cy_month_name_short_rs,
 month_name_at,
 month_name_be,
 month_name_fr AS month_name_be_fr,
 month_name_bg,
 month_name_ch,
 month_name_cy,
 month_name_cz,
 month_name,
 month_name_dk,
 month_name_ee,
 month_name_es,
 month_name_fi,
 month_name_fr,
 month_name_gb,
 month_name_gr,
 month_name_hr,
 month_name_hu,
 month_name_ie,
 month_name_it,
 month_name_lt,
 month_name_lv,
 month_name_ni,
 month_name_nl,
 month_name_de,
 month_name_pl,
 month_name_pt,
 month_name_ro,
 month_name_se,
 month_name_si,
 month_name_sk,
 month_name_cs,
 month_name_mt,
 month_name_us,
 month_name_rs
FROM (SELECT month_of_year AS `_month_id`,
   cy_month,
   cy,
   bus_year AS byr,
   month_of_year_short_name_de AS cy_month_name_short_at,
   month_of_year_short_name_nl AS cy_month_name_short_be,
   month_of_year_short_name_bg AS cy_month_name_short_bg,
   month_of_year_short_name_de AS cy_month_name_short_ch,
   month_of_year_short_name_el AS cy_month_name_short_cy,
   month_of_year_short_name_cs AS cy_month_name_short_cz,
   month_of_year_short_name AS cy_month_name_short,
   month_of_year_short_name_da AS cy_month_name_short_dk,
    CASE
    WHEN month_of_year = 1
    THEN 'Jaan.'
    WHEN month_of_year = 2
    THEN 'Veeb.'
    WHEN month_of_year = 3
    THEN 'Märts'
    WHEN month_of_year = 4
    THEN 'Apr.'
    WHEN month_of_year = 5
    THEN 'Mai'
    WHEN month_of_year = 6
    THEN 'Juuni'
    WHEN month_of_year = 7
    THEN 'Juuli'
    WHEN month_of_year = 8
    THEN 'Aug.'
    WHEN month_of_year = 9
    THEN 'Sept.'
    WHEN month_of_year = 10
    THEN 'Okt.'
    WHEN month_of_year = 11
    THEN 'Nov.'
    WHEN month_of_year = 12
    THEN 'Dets.'
    ELSE NULL
    END AS cy_month_name_short_ee,
   month_of_year_short_name_es AS cy_month_name_short_es,
   month_of_year_short_name_fi AS cy_month_name_short_fi,
   month_of_year_short_name_fr AS cy_month_name_short_fr,
   month_of_year_short_name_en AS cy_month_name_short_gb,
   month_of_year_short_name_el AS cy_month_name_short_gr,
   month_of_year_short_name_hr AS cy_month_name_short_hr,
   month_of_year_short_name_hu AS cy_month_name_short_hu,
    CASE
    WHEN month_of_year = 12
    THEN 'Dez'
    ELSE month_of_year_short_name_en
    END AS cy_month_name_short_ie,
   month_of_year_short_name_it AS cy_month_name_short_it,
    CASE
    WHEN month_of_year = 1
    THEN 'saus.'
    WHEN month_of_year = 2
    THEN 'vas.'
    WHEN month_of_year = 3
    THEN 'kovas'
    WHEN month_of_year = 4
    THEN 'bal.'
    WHEN month_of_year = 5
    THEN 'geg.'
    WHEN month_of_year = 6
    THEN 'birz'
    WHEN month_of_year = 7
    THEN 'liepa'
    WHEN month_of_year = 8
    THEN 'rugp.'
    WHEN month_of_year = 9
    THEN 'rugs.'
    WHEN month_of_year = 10
    THEN 'spalis'
    WHEN month_of_year = 11
    THEN 'lapkr.'
    WHEN month_of_year = 12
    THEN 'gr.'
    ELSE NULL
    END AS cy_month_name_short_lt,
    CASE
    WHEN month_of_year = 5
    THEN 'Maijs'
    WHEN month_of_year = 10
    THEN 'Okt'
    ELSE month_of_year_short_name_en
    END AS cy_month_name_short_lv,
    CASE
    WHEN month_of_year = 12
    THEN 'Dez'
    ELSE month_of_year_short_name_en
    END AS cy_month_name_short_ni,
   month_of_year_short_name_nl AS cy_month_name_short_nl,
   month_of_year_short_name_de AS cy_month_name_short_de,
   month_of_year_short_name_pl AS cy_month_name_short_pl,
   month_of_year_short_name_pt AS cy_month_name_short_pt,
   month_of_year_short_name_ro AS cy_month_name_short_ro,
   month_of_year_short_name_sv AS cy_month_name_short_se,
   month_of_year_short_name_sl AS cy_month_name_short_si,
   month_of_year_short_name_sk AS cy_month_name_short_sk,
   month_of_year_short_name_es AS cy_month_name_short_cs,
   month_of_year_short_name_en AS cy_month_name_short_mt,
   month_of_year_short_name_en AS cy_month_name_short_us,
    CASE
    WHEN month_of_year = 8
    THEN 'Avg'
    ELSE month_of_year_short_name_sk
    END AS cy_month_name_short_rs,
    CASE
    WHEN month_of_year = 1
    THEN 'Jänner'
    ELSE month_of_year_name_de
    END AS month_name_at,
   month_of_year_name_nl AS month_name_be,
   month_of_year_name_bg AS month_name_bg,
   month_of_year_name_de AS month_name_ch,
    CASE
    WHEN month_of_year = 1
    THEN 'Ιανουάριος'
    WHEN month_of_year = 2
    THEN 'Φεβρουάριος'
    WHEN month_of_year = 3
    THEN 'Μάρτιος'
    WHEN month_of_year = 4
    THEN 'Απρίλιος'
    WHEN month_of_year = 5
    THEN 'Μάϊος'
    WHEN month_of_year = 6
    THEN 'Ιούνιος'
    WHEN month_of_year = 7
    THEN 'Ιούλιος'
    WHEN month_of_year = 8
    THEN 'Αύγουστος'
    WHEN month_of_year = 9
    THEN 'Σεπτέμβριος'
    WHEN month_of_year = 10
    THEN 'Οκτώβριος'
    WHEN month_of_year = 11
    THEN 'Νοέμβριος'
    WHEN month_of_year = 12
    THEN 'Δεκέμβριος'
    ELSE NULL
    END AS month_name_cy,
   month_of_year_name_cs AS month_name_cz,
   month_of_year_name AS month_name,
   month_of_year_name_da AS month_name_dk,
    CASE
    WHEN month_of_year = 1
    THEN 'Jaanuar'
    WHEN month_of_year = 2
    THEN 'Veebruar'
    WHEN month_of_year = 3
    THEN 'Märts'
    WHEN month_of_year = 4
    THEN 'Aprill'
    WHEN month_of_year = 5
    THEN 'Mai'
    WHEN month_of_year = 6
    THEN 'Juuni'
    WHEN month_of_year = 7
    THEN 'Juuli'
    WHEN month_of_year = 8
    THEN 'August'
    WHEN month_of_year = 9
    THEN 'September'
    WHEN month_of_year = 10
    THEN 'Oktoober'
    WHEN month_of_year = 11
    THEN 'November'
    WHEN month_of_year = 12
    THEN 'Detsember'
    ELSE NULL
    END AS month_name_ee,
   month_of_year_name_es AS month_name_es,
   month_of_year_name_fi AS month_name_fi,
   month_of_year_name_fr AS month_name_fr,
   month_of_year_name_en AS month_name_gb,
    CASE
    WHEN month_of_year = 1
    THEN 'Ιανουάριος'
    WHEN month_of_year = 2
    THEN 'Φεβρουάριος'
    WHEN month_of_year = 3
    THEN 'Μάρτιος'
    WHEN month_of_year = 4
    THEN 'Απρίλιος'
    WHEN month_of_year = 5
    THEN 'Μάϊος'
    WHEN month_of_year = 6
    THEN 'Ιούνιος'
    WHEN month_of_year = 7
    THEN 'Ιούλιος'
    WHEN month_of_year = 8
    THEN 'Αύγουστος'
    WHEN month_of_year = 9
    THEN 'Σεπτέμβριος'
    WHEN month_of_year = 10
    THEN 'Οκτώβριος'
    WHEN month_of_year = 11
    THEN 'Νοέμβριος'
    WHEN month_of_year = 12
    THEN 'Δεκέμβριος'
    ELSE NULL
    END AS month_name_gr,
   month_of_year_name_hr AS month_name_hr,
   month_of_year_name_hu AS month_name_hu,
   month_of_year_name_en AS month_name_ie,
   month_of_year_name_it AS month_name_it,
    UPPER(SUBSTR(month_of_year_name_lt, 1, 1)) || SUBSTR(month_of_year_name_lt, 2) AS month_name_lt,
    CASE
    WHEN month_of_year = 1
    THEN 'Janvaris'
    WHEN month_of_year = 2
    THEN 'Februaris'
    WHEN month_of_year = 3
    THEN 'Marts'
    WHEN month_of_year = 4
    THEN 'Aprilis'
    WHEN month_of_year = 5
    THEN 'Maijs'
    WHEN month_of_year = 6
    THEN 'Junijs'
    WHEN month_of_year = 7
    THEN 'Julijs'
    WHEN month_of_year = 8
    THEN 'Augusts'
    WHEN month_of_year = 9
    THEN 'Septembris'
    WHEN month_of_year = 10
    THEN 'Oktobris'
    WHEN month_of_year = 11
    THEN 'Novembris'
    WHEN month_of_year = 12
    THEN 'Decembris'
    ELSE NULL
    END AS month_name_lv,
   month_of_year_name_en AS month_name_ni,
   month_of_year_name_nl AS month_name_nl,
   month_of_year_name_de AS month_name_de,
   month_of_year_name_pl AS month_name_pl,
   month_of_year_name_pt AS month_name_pt,
   month_of_year_name_ro AS month_name_ro,
   LOWER(month_of_year_name_sv) AS month_name_se,
   month_of_year_name_sl AS month_name_si,
   month_of_year_name_sk AS month_name_sk,
   month_of_year_name_es AS month_name_cs,
   month_of_year_name_en AS month_name_mt,
   month_of_year_name_en AS month_name_us,
    CASE
    WHEN month_of_year = 1
    THEN 'Januar'
    WHEN month_of_year = 2
    THEN 'Februar'
    WHEN month_of_year = 3
    THEN 'Mart'
    WHEN month_of_year = 4
    THEN 'April'
    WHEN month_of_year = 5
    THEN 'Maj'
    WHEN month_of_year = 6
    THEN 'Jun'
    WHEN month_of_year = 7
    THEN 'Jul'
    WHEN month_of_year = 8
    THEN 'Avgust'
    WHEN month_of_year = 9
    THEN 'Septembar'
    WHEN month_of_year = 10
    THEN 'Oktobar'
    WHEN month_of_year = 11
    THEN 'Novembar'
    WHEN month_of_year = 12
    THEN 'Decembar'
    ELSE NULL
    END AS month_name_rs
  FROM ldl_p_lew_bil_ac.v_dim_cal_month_1 AS DCM
  WHERE cy_month <> - 1) AS base;