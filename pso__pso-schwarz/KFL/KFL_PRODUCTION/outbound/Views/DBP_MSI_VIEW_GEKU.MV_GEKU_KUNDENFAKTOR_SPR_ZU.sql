CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_geku_kundenfaktor_spr_zu (kundenfaktor_id, kf_kommentar,
kf_kommentar_cz, kf_kommentar_pl, kf_kommentar_sk, kf_kommentar_hr, kf_kommentar_ro, kf_kommentar_bg, kf_bez, kf_bez_cz
, kf_bez_pl, kf_bez_sk, kf_bez_hr, kf_bez_ro, kf_bez_bg) AS SELECT kundenfaktor_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN kf_kommentar
   ELSE NULL
   END) AS kf_kommentar,
 MAX(CASE
   WHEN spr_id = 124
   THEN kf_kommentar
   ELSE NULL
   END) AS kf_kommentar_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN kf_kommentar
   ELSE NULL
   END) AS kf_kommentar_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN kf_kommentar
   ELSE NULL
   END) AS kf_kommentar_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN kf_kommentar
   ELSE NULL
   END) AS kf_kommentar_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN kf_kommentar
   ELSE NULL
   END) AS kf_kommentar_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN kf_kommentar
   ELSE NULL
   END) AS kf_kommentar_bg,
 MAX(CASE
   WHEN spr_id = 22
   THEN kf_bez
   ELSE NULL
   END) AS kf_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN kf_bez
   ELSE NULL
   END) AS kf_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN kf_bez
   ELSE NULL
   END) AS kf_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN kf_bez
   ELSE NULL
   END) AS kf_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN kf_bez
   ELSE NULL
   END) AS kf_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN kf_bez
   ELSE NULL
   END) AS kf_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN kf_bez
   ELSE NULL
   END) AS kf_bez_bg
FROM kfl_production_dbp_view.v_geku_kundenfaktor_spr_zu AS V01
GROUP BY kundenfaktor_id;